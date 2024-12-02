//+------------------------------------------------------------------+
//|                                                      rwr-1.0.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//https://www.whselfinvest.com/fr-lu/plateforme-de-trading/strategies-trading-gratuites/systeme/66-red-white-red-configuration-graphique

#include <Trade\Trade.mqh>

void OnTick(){
   
   if(PositionsTotal()<1){
      start();
     }   
}
//Fonction start: va chercher le patern et ouvrir une position si elle le trouve
void start(){
   
   CTrade trade;
   //Paramètrage du tableau
   MqlRates historyBuffer[];
   
   ArraySetAsSeries(historyBuffer,true);
   
   if(CopyRates(_Symbol,_Period,0,5,historyBuffer)){
   
   // condition pattern 1: bougie 3 baissière, bougie 2 haussière et bougie 1 baissière
      if(historyBuffer[3].close < historyBuffer[3].open &&
         historyBuffer[2].close > historyBuffer[2].open &&
         historyBuffer[1].close < historyBuffer[1].open){
         
   //Condition pattern 2: On compare les plus bas de chaque bougie      
         if(historyBuffer[4].low > historyBuffer[3].low &&
            historyBuffer[3].low > historyBuffer[2].low &&
            historyBuffer[1].low > historyBuffer[2].low){
         
            double ask = SymbolInfoDouble(_Symbol,SYMBOL_ASK);
   //Condittion pattern: if le prix d'achat est plus haut que le plus haut de la bougie prècèdente         
            if(ask > historyBuffer[1].high){
            
               double stoploss = historyBuffer[2].low;//StopLoss au plus bas de la bougie n°2
               double takeprofit = ask+(ask-stoploss)*2;//TakeProfit de fois plus grand que le stop loss
               
               if(trade.Buy(0.01,_Symbol,ask,stoploss,takeprofit)){//ordre d'achat
                  
                  ulong ticket= trade.ResultOrder();//id de l'ordre
                  
                  if(ticket > 0)
                  {
                     Print("position ouvert à:" + (string)ask +". Ticket:"+ (string)ticket)   ;
                  }//if(ticket > 0)
               }//if trade.Buy
               
            }//if(ask > historyBuffer[1].high)
         }//Condition pattern 2
      }//Condition pattern 1
   }

}//Start
