//+------------------------------------------------------------------+
//|                                                      history.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

//Dans cette page on va récuperer les données qu'on peut récupérer dans la fenêtre de données.
//Donc les données des bougie selon la périod voulu.

void OnTick(){

   MqlRates historyBuffer[];//Tableau de données
   //Faire de ce tableau une série temporel:càd qu'on dit à MT5 dans quelle ordre on veut qu'il copie les données hystorique
   ArraySetAsSeries(historyBuffer,true);//l'ordre du tableau, si on met true ça veut dire qu'on récupère du plus récent au ancien
   
   //Les pèriodes peuveut être personalisé et le zero veut dire qu'on veut récupérer les données à partir de maintenant.
   //CopyRates(_Symbol,_Period/*ou Period()ou encoredes pèriode personalysée*/,0,5,historyBuffer)//copie l'historique dans le tableau retourne un booléun
   if(CopyRates(_Symbol,_Period/*ou Period()ou encoredes pèriode personalysée*/,0,5,historyBuffer)){
      Print("Times :" + (string)historyBuffer[2].time);
      Print("Open :" + (string)historyBuffer[2].open);
      Print("Closes :" + (string)historyBuffer[2].close);
      Print("High :" + (string)historyBuffer[2].high);
      Print("Low :" + (string)historyBuffer[2].low);
      Print("Spread :" + (string)historyBuffer[2].spread);
      Print("Volume :" + (string)historyBuffer[2].tick_volume);
      
   }
}
