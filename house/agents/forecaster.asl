// Agent inmetAgent in project inmetAlert
{ include("../../_commonAgents/citizen.asl") }

/* Initial beliefs and rules */
// Provided by Alert-AS - Centro Virtual para Avisos de Eventos Meteorológicos Severos --> https://alertas2.inmet.gov.br/
inmetAlertAS("https://apiprevmet3.inmet.gov.br/avisos/rss").

/* Initial goals */
!start.

/* Plans */
+!start
: inmetAlertAS(URL) 
& myCityIBGE(COD) <- 
    .random(R); .wait(10000*R);
    .inmetGovBrCheck(URL,COD).


+inmetAlert(AlertID,Event,Serverity,Certainty,Time,ResponseType,Description,Instruction,Link)[source(inmetGovBR)]
: Time=rightNow
//& Serverity=severe
<-
/*        .print("New Alert: ",AlertID,
    "\n Description: ",Description,
    "\n Event : ",Event, 
    "\n Serverity: ",Serverity,
    "\n Certainty: ",Certainty,
    "\n When: ",Time,
    "\n Type: ",ResponseType,
    "\n What to do: ",Instruction,
    "\n More info: ",Link,
    "\n");
*/
    .print("New Alert: ",AlertID," Serverity: ",Serverity);

    .send(leader,tell,weatherEvent(AlertID,Event,Serverity)); 
.

