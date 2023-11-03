// Agent telephonist in project House.mas2j


/* Initial beliefs and rules */
whereIam(house).
nationalCivilDefense("6b4a1f07-34e2-4e33-9aa9-03623a54c8f8").

{ include("../../_planLibrary/communicatorInOpenMAS.asl") }
//{ include("../../_planLibrary/communicatorAgent.asl") }
{ include("../../_commonAgents/citizen.asl") }