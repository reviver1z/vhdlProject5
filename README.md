# vhdlProject5
Design and implement an entity with FSM and any other necessary components in VHDL for controlling a multi-floor elevator system (10 floors), optimizing the response to multiple floor requests.

Design a testbench to verify the correct operation of the elevator through simulation.

Deliver the code and a report explaining your design thoroughly and include a diagram of the FSM.

Requirements
States:

Idle, MovingUp, MovingDown, OpenDoor, CloseDoor.
Waiting: A brief pause at each floor to determine the next action.
Inputs:

Individual floor request buttons inside the elevator.
Call buttons up and down on each floor.
Input sensor for each floor to detect the current position of the elevator.
Outputs:

Motor control signals.
Door control signals.
Display of the current floor.
Behavior:

In 'Idle', the elevator waits for a request.
Upon receiving a request (or more), the most efficient direction is determined based on the current position and requested floors.
In 'MovingUp' or 'MovingDown', it progresses towards the nearest requested floor in that direction.
Stops at floors with pending requests in the current direction of movement.
In 'OpenDoor', it opens the door at the requested floor, then proceeds to 'Waiting'.
In 'Waiting', it determines if there are more requests in the current direction. If not, it changes direction or goes back to 'Idle'.
Constraints:

Efficient management of requests made during movement with minimal transitions.
Priority to requests in the current direction of movement for optimizing movement."

Category: This text is related to the field of Digital Systems Design or Embedded Systems Design, specifically focusing on designing a Finite State Machine (FSM) to control a multi-floor elevator system in VHDL.
