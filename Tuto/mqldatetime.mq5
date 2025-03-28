//+------------------------------------------------------------------+
//|                                                  mqldatetime.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//Manipulation des objets de temps

void OnInit(){
   
   Print("DateTime:"+ (string)TimeCurrent());
   
   ulong NowTimestamp=(ulong)TimeCurrent();
   Print("Timestamp" + (string)NowTimestamp);
   
   MqlDateTime now;
   TimeToStruct(TimeCurrent(), now);
   
   Print("Jour:" + (string)now.day);
   Print("Heure : " + (string)now.hour);
   Print("Jour de la semaine :" + (string)now.day_of_week);
   Print("Jour de l'année :"+ (string)now.day_of_year);
   
}