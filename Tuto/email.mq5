//+------------------------------------------------------------------+
//|                                                        email.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//Pour que l'email fonction il faut aller dant metatrader 5, aller sur Outils/Option/Email
//Puis remplir notre email outlook notre mot de passe outlook ainsi que toute les cases à remplir.
void OnInit(){

   string subject = "MT5 email";
   string content ="Message envoyé depuis Metrader 5 MZE";
   
   if(SendMail(subject, content)){
      Print(subject);
      Print(content);
   }
}
