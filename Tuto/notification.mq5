//+------------------------------------------------------------------+
//|                                                 notification.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//Programme qui va envoyer des notification sur ton téléphone

void OnInit(){
   string content = "Message envoyé depuis Metrader 5 MZE";
   
   if(!SendNotification(content))
     {
      Print(content);
     }
}
