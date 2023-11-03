serialPort(ttyUSB0).

/* Initial goals */
!start.

/* Plans */
+!start:
serialPort(Port) <- 
	.port(Port);
	.limit(600);
	.percepts(open).


+rainLast24hrs(RainStatus) <- .print("New perception-> rainLevel: ",RainStatus," mm"). 

+!infoTaskForce: 
rainLast24hrs(RainStatus) & 
waitingInstructions(Alert,TaskForce,OurUUID)<- 
	.send(telephonist,achieve,sendExternalMessage(TaskForce,assistant,tell,rainLast24hrs(OurUUID,RainStatus))); 
	.random(R);
	.wait(10000*R); 
	!infoTaskForce.

+!infoLCD(Message) <- .act(Message).

+!yellowAlert <- .act(yellowAlert).
+!greenAlert <- .act(greenAlert).
+!redAlert <- .act(redAlert).
      