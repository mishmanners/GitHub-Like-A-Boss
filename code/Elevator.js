// JavaScript Programming by Magnus Wolffelt and contributors https://play.elevatorsaga.com/

{
    init : function(elevators, floors) {
        var elevator = elevators[0]; // Let's use the first elevator

        // Whenever the elevator is idle (has no more queued destinations) ...
        elevator.on("idle", function() {
            // let's go to all the floors (or did we forget one?)
            elevator.goToFloor(0);
            elevator.goToFloor(1);
            elevator.goToFloor(2);
            elevator.goToFloor(3);
        });
    },
    update : function(dt, elevators, floors) {
        // We normally don't need to do anything here
    }
}
