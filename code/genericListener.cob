RETRIEVAL
NO-ACTIVITY-LOG
DMLIST

*****************************************************************
 The following program is an example of a TCP/IP generic        *
 listener server program written in COBOL.                      *
 The processing is the following:                               *
  - read a message from the client (first 4 bytes = data length)*
  - send the message back to the client program                 *
  - if the message text is equal to "STOP" or if the connection *
    is closed, then it closes its socket and return to the      *
    generic listener service.                                   *
  - if the message text is not equal to "STOP", then it returns *
    to the generic listener service without closing its socket. *
*****************************************************************

IDENTIFICATION DIVISION.
PROGRAM-ID.               COBLIS.
ENVIRONMENT DIVISION.
IDMS-CONTROL SECTION.
PROTOCOL. MODE IS IDMS-DC DEBUG
          IDMS-RECORDS MANUAL.

DATA DIVISION.

WORKING-STORAGE SECTION.

01  COPY IDMS SUBSCHEMA-CTRL.
01  COPY IDMS RECORD SOCKET-CALL-INTERFACE.

01  MSG01  PIC X(20) VALUE ' Parameter string  :'.
01  MSG02  PIC X(20) VALUE ' Socket descriptor :'.
01  MSG03  PIC X(20) VALUE ' Resume count      :'.
01  MSG04  PIC X(15) VALUE ' Starting read.'.
01  MSG05  PIC X(16) VALUE ' Starting write.'.
01  MSG06  PIC X(16) VALUE ' Closing socket.'.
01  MSG07  PIC X(20) VALUE ' Socket return code:'.
01  MSG08  PIC X(20) VALUE ' Socket reason code:'.
01  MSG09  PIC X(20) VALUE ' Socket errno      :'.
01  MSG10  PIC X(20) VALUE ' Buffer length     :'.
01  MSG11  PIC X(08) VALUE ' Buffer:'.
01  MSG12  PIC X(22) VALUE ' Data length too long.'.

01  RETLEN           PIC S9(8) COMP.
01  WK-LENGTH        PIC S9(8) COMP.
01  WK-SUBSCRIPT     PIC S9(4) COMP.
01  TERM-FLAG        PIC S9(8) COMP VALUE 0.

01  BUFFER.
  03  BUFFER-ARRAY   PIC X(1) OCCURS 84 TIMES.
01  BUFFER-REDEF     REDEFINES BUFFER.
  03  BUFLEN         PIC 9(8) COMP.
  03  BUFTXT80       PIC X(80).
  03  BUFTXT80-REDEF REDEFINES BUFTXT80.
    05  BUFTXT04     PIC X(4).
    05  BUFTXT76     PIC X(76).

01  WORKW.
  03  WORK-WCC       PIC X.
  03  WORK           PIC X(80).

LINKAGE SECTION.
*****************************************************************
 Parameter list with which a listener program receives control  *
*****************************************************************
01  SOCKET-PARMS         PIC X(80).
01  SOCKET-DESCRIPTOR    PIC S9(8) COMP.
01  SOCKET-RESUME-COUNT  PIC S9(8) COMP.

PROCEDURE DIVISION USING SOCKET-PARMS,
                         SOCKET-DESCRIPTOR,
                         SOCKET-RESUME-COUNT.

*****************************************************************
 Display the 3 input parameters                                 *
*****************************************************************
TCP-START.

*****************************************************************
 Read the first 4 bytes: will contain the remaining length      *
*****************************************************************
    MOVE 4 TO WK-LENGTH.
    MOVE 0 TO BUFLEN.
    MOVE 1 TO WK-SUBSCRIPT.
    PERFORM TCP-READ THRU TCP-READ-EXIT.
    IF TERM-FLAG = 1 GO TO TCP-EXIT.

*****************************************************************
 Read the remaining data (maximum 80 characters are allowed)    *
*****************************************************************
    IF BUFLEN GREATER THAN 80
      WRITE LOG MESSAGE ID 9060300
        PARMS FROM MSG12 LENGTH 22
      PERFORM TCP-CLOSE THRU TCP-CLOSE-EXIT
      GO TO TCP-EXIT.

    MOVE BUFLEN TO WK-LENGTH.
    MOVE 5      TO WK-SUBSCRIPT.
    PERFORM TCP-READ THRU TCP-READ-EXIT.
    IF TERM-FLAG = 1 GO TO TCP-EXIT.

    MOVE BUFLEN TO WORK.
    WRITE LOG MESSAGE ID 9060300
      PARMS FROM MSG10 LENGTH 20
            FROM WORKW LENGTH 9.
    MOVE BUFTXT80 TO WORK.
    MOVE BUFLEN TO WK-LENGTH.
    ADD 1 TO WK-LENGTH.
    WRITE LOG MESSAGE ID 9060300
      PARMS FROM MSG11 LENGTH 8
            FROM WORKW LENGTH WK-LENGTH.

*****************************************************************
 Send the message back to the client                            *
*****************************************************************
    MOVE BUFLEN TO WK-LENGTH.
    ADD 4 TO WK-LENGTH.
    MOVE 1 TO WK-SUBSCRIPT.
    PERFORM TCP-WRITE THRU TCP-WRITE-EXIT.

    IF BUFLEN = 4 AND BUFTXT04 = 'STOP'
      PERFORM TCP-CLOSE THRU TCP-CLOSE-EXIT.

TCP-EXIT.
    GOBACK.

*****************************************************************
 Procedure to read a message from the client                    *
*****************************************************************
TCP-READ.
    WRITE LOG MESSAGE ID 9060300
      PARMS FROM MSG04  LENGTH 15.
    PERFORM UNTIL WK-LENGTH = 0
      CALL 'IDMSOCKI' USING SOCKET-FUNCTION-READ,
                            SOCKET-RETCD,
                            SOCKET-ERRNO,
                            SOCKET-RSNCD,
                            SOCKET-DESCRIPTOR,
                            BUFFER-ARRAY(WK-SUBSCRIPT),
                            WK-LENGTH,
                            RETLEN
      MOVE SOCKET-RETCD TO WORK
      WRITE LOG MESSAGE ID 9060300
        PARMS FROM MSG07 LENGTH 20
              FROM WORKW LENGTH 9
      IF SOCKET-RETCD NOT = 0 OR RETLEN = 0
        PERFORM TCP-ERROR THRU TCP-ERROR-EXIT
        GO TO TCP-READ-EXIT
        END-IF
      ADD RETLEN TO WK-SUBSCRIPT
      SUBTRACT RETLEN FROM WK-LENGTH
    END-PERFORM.
TCP-READ-EXIT.
    EXIT.

*****************************************************************
 Procedure to send a message to the client                      *
*****************************************************************
TCP-WRITE.
    WRITE LOG MESSAGE ID 9060300
      PARMS FROM MSG05 LENGTH 16.
    PERFORM UNTIL WK-LENGTH = 0
      CALL 'IDMSOCKI' USING SOCKET-FUNCTION-WRITE,
                            SOCKET-RETCD,
                            SOCKET-ERRNO,
                            SOCKET-RSNCD,
                            SOCKET-DESCRIPTOR,
                            BUFFER-ARRAY(WK-SUBSCRIPT),
                            WK-LENGTH,
                            RETLEN
      MOVE SOCKET-RETCD TO WORK
      WRITE LOG MESSAGE ID 9060300
        PARMS FROM MSG07 LENGTH 20
              FROM WORKW LENGTH 9
      IF SOCKET-RETCD NOT = 0 OR RETLEN = 0
        PERFORM TCP-ERROR THRU TCP-ERROR-EXIT
        GO TO TCP-WRITE-EXIT
        END-IF
      ADD RETLEN TO WK-SUBSCRIPT
      SUBTRACT RETLEN FROM WK-LENGTH
    END-PERFORM.
TCP-WRITE-EXIT.
    EXIT.

*****************************************************************
 Procedure to close the socket                                  *
*****************************************************************
TCP-CLOSE.
    WRITE LOG MESSAGE ID 9060300
      PARMS FROM MSG06 LENGTH 16.
    CALL 'IDMSOCKI' USING SOCKET-FUNCTION-CLOSE,
                          SOCKET-RETCD,
                          SOCKET-ERRNO,
                          SOCKET-RSNCD,
                          SOCKET-DESCRIPTOR.
    MOVE SOCKET-RETCD TO WORK.
    WRITE LOG MESSAGE ID 9060300
      PARMS FROM MSG07 LENGTH 20
            FROM WORKW LENGTH 9.
TCP-CLOSE-EXIT.
    EXIT.

*****************************************************************
 Procedure to process the socket call errors                    *
*****************************************************************
TCP-ERROR.
    MOVE SOCKET-RSNCD TO WORK.
    WRITE LOG MESSAGE ID 9060300
       PARMS FROM MSG08 LENGTH 20
             FROM WORKW LENGTH 9.
    MOVE SOCKET-ERRNO TO WORK.
    WRITE LOG MESSAGE ID 9060300
       PARMS FROM MSG09 LENGTH 20
             FROM WORKW LENGTH 9.
    MOVE RETLEN  TO WORK.
    WRITE LOG MESSAGE ID 9060300
       PARMS FROM MSG10 LENGTH 20
             FROM WORKW LENGTH 9.
    PERFORM TCP-CLOSE THRU TCP-CLOSE-EXIT.
    MOVE 1 TO TERM-FLAG.
TCP-ERROR-EXIT.
    EXIT.

*****************************************************************

    COPY IDMS IDMS-STATUS.
IDMS-ABORT SECTION.
IDMS-ABORT-EXIT.
    EXIT.