+!registerCity(IBGE,CityIotAddress)[source(telephonist)] <-
    .print("Registering City ",IBGE);
    +cityDirectory(IBGE,CityIotAddress);
    .send(telephonist,achieve,sendExternalMessage(CityIotAddress,mayor,tell,registredInCivilDefense));
.

+!getInfo(AlertID,IBGE,ExternalMAS)[source(telephonist)]: taskForce(TaskForceNR,City,TaskForceUUID) & AlertID = TaskForceNR <-
    -preparingTaskForce(TaskForceNR);
    .print("There are a taskforce for alert nr ",AlertID);
    .send(telephonist,achieve,sendExternalMessage(ExternalMAS,leader,tell,taskForce(TaskForceNR,TaskForceUUID)));
.

+!getInfo(AlertID,IBGE,ExternalMAS)[source(telephonist)]: preparingTaskForce(AlertID) & not taskForce(TaskForceNR,City,TaskForceUUID)  <-
    .print("Waiting preparing task Force for alert nr ",AlertID)
.

+!getInfo(AlertID,IBGE,ExternalMAS)[source(telephonist)]: not preparingTaskForce(AlertID) & not taskForce(TaskForceNR,City,TaskForceUUID) <-
    !createTaskForce(AlertID,IBGE);
.

+!createTaskForce(AlertID,IBGE): cityDirectory(IBGE,CityIotAddress) <-
    .send(telephonist,achieve,sendExternalMessage(CityIotAddress,mayor,achieve,createTaskForce(AlertID)));
.

+!createTaskForce(AlertID,IBGE): not cityDirectory(IBGE,CityIotAddress) <-
    .print("There is no a register for city:",IBGE);
.

+taskForce(TaskForceNR,City,TaskForceUUID) <-
    .print("Preparing a assistant to TaskForce");
    .random(R); .wait(10000*R);
    .create_agent(assistant,"agents/roles/eventAssistant.asl");
    .send(telephonist,achieve,tranportAnAgentTo(assistant,TaskForceUUID)).