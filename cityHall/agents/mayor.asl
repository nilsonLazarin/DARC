// Agent mayor in project cityHall.mas2j
{ include("../../_commonAgents/citizen.asl") }
!registerInCivilDefense.

+!createTaskForce(AlertID): not waitCallBack(AlertID)<-
    .print("Organizing a Task Force to Event",AlertID);
    ?nationalCivilDefense(CDIotAddress); 
    .send(telephonist,achieve,sendExternalMessage(CDIotAddress,commander,tell,preparingTaskForce(AlertID)));

    !appointingCoordinator(AlertID,CDIotAddress);

    ?myIotAddress(CityIotAddress);
    .create_mas("extra/newCoalition.zip",gui,callBack(CityIotAddress));
    +waitCallBack(AlertID);
    !sendCoordinatorToMAS(AlertID);
.

+!appointingCoordinator(AlertID,CDIotAddress)<-
    .create_agent(coordinator,"../_commonAgents/citizen.asl");
    .send(coordinator,tell,nationalCivilDefense(CDIotAddress));
    .send(coordinator,tell,alertID(AlertID));
    ?myIotAddress(CityIotAddress);
    .send(coordinator,tell,cityHallIotAddress(CityIotAddress));
    .send(coordinator,tellHow,"+!startTaskForce <- .send(telephonist,askOne,myIotAddress(U),Reply); +Reply; !registerTaskForce.");
    .send(coordinator,tellHow,"+!registerTaskForce: myCityIBGE(IBGE) & alertID(ID) & nationalCivilDefense(CD) & myIotAddress(U) <- .send(telephonist,achieve,sendExternalMessage(CD,commander,tell,taskForce(ID,IBGE,U))).");
    .send(coordinator,tellHow,"+evacuating(Home): smartHome(UUID) & UUID=Home & alertID(ID) & cityHallIotAddress(CityUUID) <- .send(telephonist,achieve,sendExternalMessage(CityUUID,mayor,tell,alert(evacuate,Home))).");
.
+!sendCoordinatorToMAS(AlertID): taskForce(AlertID,UUID) <-
    .send(telephonist,achieve,tranportAnAgentTo(coordinator,UUID));
    .wait(10000);
    .send(telephonist,achieve,sendExternalMessage(UUID,coordinator,achieve,startTaskForce));
.

-!sendCoordinatorToMAS(AlertID) <- .random(R); .wait(3000*R); .print("waiting start taskforce"); !sendCoordinatorToMAS(AlertID).


+!registerInCivilDefense
: nationalCivilDefense(CDIotAddress) 
& myIotAddress(CityIotAddress)
& myCityIBGE(IBGE)
<-
    .print("Requesting register for ",IBGE);
    .send(telephonist,achieve,sendExternalMessage(CDIotAddress,commander,achieve,registerCity(IBGE,CityIotAddress)));
    .random(R); .wait(5000*R);
    !registerInCivilDefense;
.

+!registerInCivilDefense: not nationalCivilDefense(UUID) <-
    .send(telephonist,askOne,nationalCivilDefense(UUID),Reply);
    +Reply;
    !registerInCivilDefense;
.

+!registerInCivilDefense: not myIotAddress(UUID) <-
    .send(telephonist,askOne,myIotAddress(UUID),Reply);
    +Reply;
    !registerInCivilDefense;
.

+registredInCivilDefense[source(X)] <- 
    .drop_desire(registerInCivilDefense);
    .print("Our city is registred in the National Civil Defense System");
.

+!newMasSuccessfullyCreated(UUID)[source(telephonist)]: waitCallBack(AlertID)[source(self)]<-
    .print("Task Force created in MAS:",UUID);
    .send(telephonist,achieve,mas2masMessage(UUID,tell,where(AlertID)));
    -waitCallBack(AlertID);
    +taskForce(AlertID,UUID);
.

+alert(evacuate,Home) <-
    .print("Preparing Rescue for ",Home).