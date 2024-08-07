public class GenericListener {

    // Constants for messages
    private static final String MSG01 = " Parameter string  :";
    private static final String MSG02 = " Socket descriptor :";
    private static final String MSG03 = " Resume count      :";
    private static final String MSG04 = " Starting read.";

    public static void main(String[] args) {
        // Simulate the server loop
        while (true) {
            String message = readMessageFromClient();
            if (message == null) {
                // Connection closed
                closeSocket();
                break;
            }

            sendMessageToClient(message);

            if ("STOP".equals(message)) {
                closeSocket();
                break;
            }
        }
    }

    private static String readMessageFromClient() {
        // Simulate reading a message from the client
        // In a real implementation, this would involve socket I/O
        System.out.println(MSG04);
        return "Example message"; // Placeholder message
    }

    private static void sendMessageToClient(String message) {
        // Simulate sending a message back to the client
        // In a real implementation, this would involve socket I/O
        System.out.println("Sending message back to client: " + message);
    }

    private static void closeSocket() {
        // Simulate closing the socket
        // In a real implementation, this would involve socket operations
        System.out.println("Closing socket.");
    }
}