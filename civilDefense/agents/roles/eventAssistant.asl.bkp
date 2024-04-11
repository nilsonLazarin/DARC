+where(OurMAS)[source(X)] <-
    .print("Thanks ",X);
    .wait(5000);
    !start.

+!newSmartHome(UUID)[source(coordinator)] <- 
    .random(R); .wait(5000*R);
    .print("Requesting execution to SmartHome",UUID);
    .send(telephonist,
        achieve,
        sendExternalMessage(UUID,
            actuator,
            achieve,
            infoTaskForce
        )
    );
.

+!start <-
    .send(coordinator,tellHow,"+!infoAllSmartHome[source(assistant)] <- for(smartHome(OurUUID)){.send(assistant,achieve,newSmartHome(OurUUID));}.");
    .send(coordinator,tellHow,"+smartHome(UUID) <- .send(assistant,achieve,newSmartHome(UUID)).");
    .send(coordinator,askOne,alertID(ID),Reply);
    +Reply;
    .send(coordinator,achieve,infoAllSmartHome).


+rainLast24hrs(SmartHome,RainStatus): RainStatus > 100  <- 
    .print("Emergency... ",RainStatus,"mm in the last 24hrs in ",SmartHome," go to a safe place...");
    ?alertID(Alert);
    .send(telephonist,
        achieve,
        sendExternalMessage(SmartHome,
            leader,
            achieve,
            alert(Alert,evacuate)
        )
    );
    
    .send(coordinator,tell,evacuating(SmartHome));
.

+rainLast24hrs(SmartHome,RainStatus): RainStatus > 80 & RainStatus < 100  <- 
    .print("Atention... ",RainStatus,"mm in the last 24hrs in ",SmartHome);
    ?alertID(Alert);
    .send(telephonist,
        achieve,
        sendExternalMessage(SmartHome,
            leader,
            achieve,
            alert(Alert,atention)
        )
    );
.

+rainLast24hrs(SmartHome,RainStatus) <- 
    .print("Information about ",SmartHome, " rainLevel=",RainStatus).
