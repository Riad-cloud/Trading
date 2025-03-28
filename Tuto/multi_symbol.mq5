//+------------------------------------------------------------------+
//|                                                 multi"USDJPY".mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//Prise de position sur plusieur actif avec RSI

#include <Trade/Trade.mqh>

CTrade trade;

string symboles[] = {"[CAC40]", "[DAX30]", "[SP500]", "[JP225]"};


void OnTick(){

  //boucle selectionnant 1 à 1 les symboles
   for(int i = 0; i < ArraySize(symboles); i += 1){
   
     if(symbolGetPositionTotal(symboles[i]) < 1){//On regarde si il y a 1 position ouvert dans le symbole
         
       double rsi = getRsi(symboles[i]);//init du Rsi
       
       if(rsi > 0.0 && rsi < 50){
       
          trade.Buy(SymbolInfoDouble(symboles[i], SYMBOL_VOLUME_MIN), symboles[i], SymbolInfoDouble(symboles[i], SYMBOL_ASK));
       
       }
       else if(rsi > 0.0 && rsi > 49.999999){
          
          trade.Sell(SymbolInfoDouble(symboles[i], SYMBOL_VOLUME_MIN), symboles[i], SymbolInfoDouble(symboles[i], SYMBOL_BID));        
       
       }
     }
   }
}

double getRsi(string symbolName){

   double rsiBuffer[];
   
   ArraySetAsSeries(rsiBuffer, true);
   
   int rsi = iRSI(symbolName, PERIOD_D1, 20, PRICE_CLOSE);
   
   if(CopyBuffer(rsi, 0, 0, 1, rsiBuffer) > 0) return rsiBuffer[0];
   
   return -1.0;

}

int symbolGetPositionTotal(string symbolName){
   
   int total = 0;
   
   for(int i = 0; i < PositionsTotal(); i += 1){
   
      if(PositionGetSymbol(i) == symbolName){
      
         total += 1;
         
      }
   }
   
   return total;

}