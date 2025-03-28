//+------------------------------------------------------------------+
//|                                                 Entrée_vente.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
//Programme pour tester les entrée en position en vente
#include <Riad\Entry.mqh>

input group "Money Management";
input float Risque=0.5;
input int Capital=20000;

input group "TimeFrames";
input ENUM_TIMEFRAMES Timeframe_position1 = PERIOD_M5;
input ENUM_TIMEFRAMES Timeframe_position2 = PERIOD_M3;

bool position_prise = 0;

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
   if(position_prise== 0 ){
      
         if(PositionsTotal()<1){
            start(Timeframe_position1,Timeframe_position2);
         }
   }
   
}

void start(ENUM_TIMEFRAMES Timeframe_position1,ENUM_TIMEFRAMES Timeframe_position2 ){

   if(Cassure_Kijun_Baissier(_Symbol,Timeframe_position1,Capital,Risque))
   {
      position_prise=1;
      
   }
   else if(Cassure_Kijun_Baissier(_Symbol,Timeframe_position2,Capital,Risque))
   {
      position_prise=1;
      
   }
   else if(Cassure_Tenkan_Haussier2(_Symbol,Timeframe_position1,Capital,Risque))
   {
      position_prise=1;
      
   }
   else if(Cassure_Tenkan_Haussier2(_Symbol,Timeframe_position2,Capital,Risque))
   {
      position_prise=1;
      
   }
   
}