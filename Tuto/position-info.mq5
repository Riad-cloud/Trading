//+------------------------------------------------------------------+
//|                                                position-info.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#include <Trade\Trade.mqh>

//Ce programme va nous servir à voir comment récupérer les infos de nos position en mql5

CTrade trade;

void OnTick(void){
   
   if(PositionsTotal()<1){
      trade.Buy(0.01,_Symbol,SymbolInfoDouble(_Symbol,SYMBOL_ASK),0.0,0.0);
      trade.Sell(0.01,_Symbol,SymbolInfoDouble(_Symbol,SYMBOL_BID),0.0,0.0);
   }
   else{
      for(int i=0;i<PositionsTotal();i+=1)
      {
        ulong ticket = PositionGetTicket(i);
        
        Print("Ticket: " +(string)ticket);
        
        if(PositionSelectByTicket(ticket)){/*cette fonction retourne un booléen*/
            double stoploss = PositionGetDouble(POSITION_SL);
            double takeprofit = PositionGetDouble(POSITION_TP);
            double priceOpen = PositionGetDouble(POSITION_PRICE_OPEN);
            
            datetime timeOpen = (datetime)PositionGetInteger(POSITION_TIME);
            int type = (int)PositionGetInteger(POSITION_TYPE);//Renvoie le type de la position:si c'est un buy ou un sell.0 pour Buy, 1 pour Sell
            
            Print("Stoploss: " +(string)stoploss);
            Print("TakeProfit: " +(string)takeprofit);
            Print("Heure d'ouverture: " +(string)timeOpen);
            Print("Type position: " +(string)type);
        }
         
      }
      
   }
}