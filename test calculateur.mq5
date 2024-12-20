//+------------------------------------------------------------------+
//|                                             test calculateur.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
//Test du calculateur automatique de la position
#include <Riad\Calculateur.mqh>
#include <Riad\Candle.mqh>
#include <Riad\figure_continuation.mqh>
#include <Riad\figure_retournement.mqh>
#include <Trade\Trade.mqh>


int capital = 20000;
CTrade trade;
ulong date_post_op = 0;
void  OnTick(void)
{
   
      if(date_post_op<=(ulong)TimeCurrent() ){
      
         if(PositionsTotal()<1){
            start();
         }
      }

   
   
   
}
void start (){

   if(penetrante_haussier(_Symbol,_Period))
   {
     double ask = SymbolInfoDouble(_Symbol,SYMBOL_ASK);
      double stoploss= bougie_low(1,_Symbol,_Period);
      double takeprofit= bougie_close(1,_Symbol,Period())+bougie_corps(1,_Symbol,Period());
      Print("C'est bizarre");
      double lot=CalculatorPstdevise(stoploss,ask,_Symbol,0, capital,0.5);
      if(trade.Buy(lot,_Symbol,ask,stoploss,takeprofit)){
         date_post_op= set_ope_bougie();
           
      }
   }
   else if (penetrante_baissiere(_Symbol,PERIOD_CURRENT))
   {
      double bid = SymbolInfoDouble(_Symbol,SYMBOL_BID);
      double stoploss= bougie_high(1,_Symbol,_Period);
      Print("C'est bizarre2");
      double takeprofit= bougie_close(1,_Symbol,Period())-bougie_corps(1,_Symbol,Period());
      double lot=CalculatorPstdevise(stoploss,bid,_Symbol,1, capital,0.5);
      if(trade.Sell(lot,_Symbol,bid,stoploss,takeprofit)){
         date_post_op= set_ope_bougie();
                   
      }
   }
      if(avalente_haussier(_Symbol,_Period))
   {
     double ask = SymbolInfoDouble(_Symbol,SYMBOL_ASK);
      double stoploss= bougie_low(1,_Symbol,_Period);
      double takeprofit= bougie_close(1,_Symbol,Period())+bougie_corps(1,_Symbol,Period());
      Print("C'est bizarre");
      double lot=CalculatorPstdevise(stoploss,ask,_Symbol,0, capital,0.5);
      if(trade.Buy(lot,_Symbol,ask,stoploss,takeprofit)){
         date_post_op= set_ope_bougie();
           
      }
   }
   else if (avalente_baissiere(_Symbol,PERIOD_CURRENT))
   {
      double bid = SymbolInfoDouble(_Symbol,SYMBOL_BID);
      double stoploss= bougie_high(1,_Symbol,_Period);
      Print("C'est bizarre2");
      double takeprofit= bougie_close(1,_Symbol,Period())-bougie_corps(1,_Symbol,Period());
      double lot=CalculatorPstdevise(stoploss,bid,_Symbol,1, capital,0.5);
      if(trade.Sell(lot,_Symbol,bid,stoploss,takeprofit)){
         date_post_op= set_ope_bougie();
                   
      }
   }
   
      

}

//////////////////////////Fonction operation////////////////////////////////////////////////////////
//Cette fonction va nous permettre de ne pas prendre plusieurs position perdante dans une bougie qui a déja un trade perdant.
ulong set_ope_bougie(){
   
   MqlRates historyBuffer[];
   
   ArraySetAsSeries(historyBuffer,true);
   ulong UT = 0;
   if(CopyRates(_Symbol,_Period,0,3,historyBuffer)){
               ulong date1 = (ulong)historyBuffer[2].time;
               ulong date2 = (ulong)historyBuffer[1].time;
               UT = (ulong)TimeCurrent() +4*(date2-date1);
         
   }
   return UT;
     
   
}