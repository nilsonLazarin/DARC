{ include("../../_commonAgents/citizen.asl") }

+taskForce(AlertID,TaskForceUUID) <- 
    .print("Registering SmartHome in TaskForce, waiting instructions!!!");
    .drop_desire(getCivilDefenseInfo(AlertID));
    ?myCityIBGE(IBGE);
    ?myIotAddress(OurUUID);
    .broadcast(tell,waitingInstructions(AlertID,TaskForceUUID,OurUUID));
    .send(actuator,achieve,greenAlert);
    .send(telephonist,achieve,sendExternalMessage(TaskForceUUID,coordinator,tell,smartHome(OurUUID)));
.

+!getCivilDefenseInfo(AlertID)
: nationalCivilDefense(NDUUID) 
& myCityIBGE(IBGE) 
& myIotAddress(OurUUID)[source(telephonist)]
<- 
    .send(telephonist,achieve,sendExternalMessage(NDUUID,commander,achieve,getInfo(AlertID,IBGE,OurUUID)));
    .random(R); .wait(10000*R);
    !getCivilDefenseInfo(AlertID)
.

+!getCivilDefenseInfo(AlertID): not nationalCivilDefense(ND) <- 
    .send(telephonist,askOne,nationalCivilDefense(ND),Reply);
    +Reply;
    .random(R); .wait(1000*R);
    !getCivilDefenseInfo(AlertID);
.

+!getCivilDefenseInfo(AlertID): not myIotAddress(UU) <-
    .send(telephonist,askOne,myIotAddress(UU),Reply);
    +Reply;
    .random(R); .wait(1000*R);
    !getCivilDefenseInfo(AlertID);
.

+weatherEvent(AlertID,Event,Serverity)[source(forecaster)]: not contatingCivilDefense<- 
    +contatingCivilDefense;
    !getCivilDefenseInfo(AlertID).

+!alert(Alert,evacuate): taskForce(AlertID,TaskForceUUID) & Alert=AlertID <-
    .print("EVACUATE!!!!!!!!!!!!!!!!!!!");
    .send(actuator,achieve,redAlert);
    .send(actuator,achieve,infoLCD("Evacuate!!!!")).

+!alert(Alert,atention): taskForce(AlertID,TaskForceUUID) & Alert=AlertID <-
    .print("ALERT!!!!!!!!!!!!!!!!!!!!!!!!");
    .send(actuator,achieve,yellowAlert);
    .send(actuator,achieve,infoLCD("Atention!!!")).