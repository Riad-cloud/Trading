//+------------------------------------------------------------------+
//|                                                        trade.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//Dans ce programme on va voir comment acheter et vendre et autre fonctions spécifique au trading

#include <Trade\Trade.mqh>//Accées à la librairie nous permettant d'ouvrir une position dont la class Ctrade

CTrade trade;

void OnTick(){
   if(PositionsTotal()<1){//si il n'y a pas de position ouverte
      double ask = SymbolInfoDouble(_Symbol,SYMBOL_ASK);
      double stoploss = ask - 100*_Point;
      double takeprofit = ask + 100*_Point;
      
      //trade.Buy(0.01,_Symbol,ask,stoploss,takeprofit  //réalise un achat
      //La fonction trade.Buy va nous retourner true si la fonction a bien été éxécuté et false si il y a un problème
      if(trade.Buy(0.01,_Symbol,ask,stoploss,takeprofit)){
         int code = (int)trade.ResultRetcode();//voir la doc
         ulong ticket = trade.ResultOrder();//identification d'une position, si le trade ne ses pas réaliser le ticket sera à zero
         Print("Code:"+(string)code);
         Print("Ticket:"+(string)ticket);
      }
      double bid = SymbolInfoDouble(_Symbol,SYMBOL_BID);
      double sellstoploss = bid + 100*_Point;
      double selltakeprofit = bid - 100*_Point;
      
      //Vente
      if(trade.Sell(0.01,_Symbol,bid,sellstoploss,selltakeprofit)){
         int Scode = (int)trade.ResultRetcode();//voir la doc
         ulong Sticket = trade.ResultOrder();//identification d'une position, si le trade ne ses pas réaliser le ticket sera à zero
         Print("Code:"+(string)Scode);
         Print("Ticket:"+(string)Sticket);
      }
   }
   
 }                          