// Agent telephonist in project cityHall.mas2j
/* Initial beliefs and rules */
whereIam(cityHall).
nationalCivilDefense("6b4a1f07-34e2-4e33-9aa9-03623a54c8f8").
//myIotAddress("4fa64a29-a0ec-4f3e-a188-5b1f9248d79c").

+newMasSuccessfullyCreated(UUID)<-
    !mas2masMessage(UUID,tell,stopCallBack);
    .send(mayor,achieve,newMasSuccessfullyCreated(UUID));
.

{ include("../../_planLibrary/communicatorInOpenMAS.asl") }
{ include("../../_commonAgents/citizen.asl") }