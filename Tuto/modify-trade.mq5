//+------------------------------------------------------------------+
//|                                                 modify-trade.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//On va voir comment modifier ou fermer une position de force en mql5
#include <Trade\Trade.mqh>

CTrade trade;


void OnTick(){

   if(PositionsTotal() < 1){
      
      trade.Buy(0.01,_Symbol,SymbolInfoDouble(_Symbol,SYMBOL_ASK),0.0,0.0);
       
   }
   else{
   
      ulong ticket = PositionGetTicket(0);
      
      if(PositionSelectByTicket(ticket)){
         //Si la position n'a ni take Profit ni Stop loss alors on en rajoute automatiquement     
         if(PositionGetDouble(POSITION_SL)<0.0001 && PositionGetDouble(POSITION_TP)<0.0001){
            if(trade.PositionModify(ticket,PositionGetDouble(POSITION_PRICE_OPEN)*0.99,PositionGetDouble(POSITION_PRICE_OPEN)*1.01))
            {
               int code = (int)trade.ResultRetcode();
               
               if(code==10009){
               
                  Print("Position modified");   
               }
            
            }   
            
         }//if(PositionGetDouble)
         
         //Si la Position dure une journée alors on ferme la position
         else if(PositionGetInteger(POSITION_TIME)+(24*60*60)<TimeCurrent()){
         
            if(trade.PositionClose(ticket)){//Ferme laposition
            
               int code = (int)trade.ResultRetcode();
            
               if(code==10009){
               
                  Print("Position closed");
                  
               }
            }
         }//else if
      }//If(PositionSelect)
      
   }//else   
}//ontick