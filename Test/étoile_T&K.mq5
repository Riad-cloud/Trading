//+------------------------------------------------------------------+
//|                                        Alert_Opportunité_0.1.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"

#include <Riad\Candle.mqh>
#include <Riad\figure_continuation1.0.mqh>
#include <Riad\figure_retournement1.0.mqh>
#include <Riad/Figure_indicateur_technique.mqh>


string symboles[] = {"EURUSD", "GBPUSD","USDJPY","USDCAD","NZDUSD","AUDUSD","USDCHF","EURJPY","GBPJPY","CADJPY","EURNZD","GBPNZD","EURGBP","NZDJPY","AUDJPY",
"EURAUD","GBPAUD","GBPCHF","AUDCHF","CHFJPY"};
ulong date_post_op[] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
input group "TimeFrames";
input ENUM_TIMEFRAMES Timeframe_contexte = PERIOD_H1;

void OnTick(){
   MqlDateTime now;
   TimeToStruct(TimeCurrent(), now);//On paramètre la variable au temps actuelle
   
      //boucle selectionnant 1 à 1 les symboles
      for(int i = 0; i < ArraySize(symboles); i += 1){
         /*if(lastcloseorder(date_post_op[i],symboles[i])==true){
            date_post_op[i]= set_ope_bougie(symboles[i]);
         }*/
         //On compare la date à laquelle on a tradé à la variable de l'heure actuelle pour qu'il éviter les bug
         if(date_post_op[i]<=(ulong)TimeCurrent()){
        
            //On regarde si il y a 1 position ouvert dans le symbol
            
               start(i,symboles[i],Timeframe_contexte);
            
            
         }
       }
    
}
void start (int i, string symbolName,ENUM_TIMEFRAMES Timeframe){
   if(etoile_du_matin(symbolName,Timeframe)&&
   (Bull_apesanteur_basse(3,symbolName,Timeframe)||Bull_apesanteur_basse(2,symbolName,Timeframe)||Ichimoku_TK_achat(1,symbolName,Timeframe)))
   {
      double ask = SymbolInfoDouble(symbolName,SYMBOL_ASK);
      double stoploss= bougie_low(1,symbolName,Timeframe);
      double takeprofit= bougie_close(1,symbolName,Timeframe)+bougie_corps(1,symbolName,Timeframe);
      double lot=CalculatorPstdevise(stoploss,ask,symbolName,0, capital,0.5);
      if(trade.Buy(lot,symbolName,ask,stoploss,takeprofit)){
         date_post_op[i]= set_ope_bougie(symboles[i]);

      }
    }
    /////////////////////////////////////////////////////////////
    else if (etoile_du_soir(symbolName,Timeframe)&&
    (Bull_apesanteur_haute(3,symbolName,Timeframe)||Bull_apesanteur_haute(2,symbolName,Timeframe)||Ichimoku_TK_vente(1,symbolName,Timeframe)))
    {
      double bid = SymbolInfoDouble(symbolName,SYMBOL_BID);
      double stoploss= bougie_high(1,symbolName,Timeframe);
      double takeprofit= bougie_close(1,symbolName,Timeframe)-bougie_corps(1,symbolName,Timeframe);
      double lot=CalculatorPstdevise(stoploss,bid,symbolName,1, capital,0.5);
      if(trade.Sell(lot,symbolName,bid,stoploss,takeprofit)){
         date_post_op[i]= set_ope_bougie(symboles[i]);                   
      }
      
      
    }
    /////////////////////////////////////////////////////////////
    else if (avalente_haussier(symbolName,Timeframe)&&
    (Bull_apesanteur_basse(1,symbolName,Timeframe)||Bull_apesanteur_basse(2,symbolName,Timeframe)||Ichimoku_TK_achat(1,symbolName,Timeframe)))
    {
      double ask = SymbolInfoDouble(symbolName,SYMBOL_ASK);
      double stoploss= bougie_low(1,symbolName,Timeframe);
      double takeprofit= bougie_close(1,symbolName,Timeframe)+bougie_corps(1,symbolName,Timeframe);
      double lot=CalculatorPstdevise(stoploss,ask,symbolName,0, capital,0.5);
      if(trade.Buy(lot,symbolName,ask,stoploss,takeprofit)){
         date_post_op[i]= set_ope_bougie(symboles[i]);

      }
      
      
    }
        /////////////////////////////////////////////////////////////
    else if (avalente_baissiere(symbolName,Timeframe)&&
    (Bull_apesanteur_haute(1,symbolName,Timeframe)||Bull_apesanteur_haute(2,symbolName,Timeframe)||Ichimoku_TK_vente(1,symbolName,Timeframe)))
    {
      double bid = SymbolInfoDouble(symbolName,SYMBOL_BID);
      double stoploss= bougie_high(1,symbolName,Timeframe);
      double takeprofit= bougie_close(1,symbolName,Timeframe)-bougie_corps(1,symbolName,Timeframe);
      double lot=CalculatorPstdevise(stoploss,bid,symbolName,1, capital,0.5);
      if(trade.Sell(lot,symbolName,bid,stoploss,takeprofit)){
         date_post_op[i]= set_ope_bougie(symboles[i]);                   
      }
      
      
    }
    /////////////////////////////////////////////////////////////
    else if (penetrante_haussier(symbolName,Timeframe)&&
    (Bull_apesanteur_basse(1,symbolName,Timeframe)||Bull_apesanteur_basse(2,symbolName,Timeframe)||Ichimoku_TK_achat(1,symbolName,Timeframe)))
    {
      double ask = SymbolInfoDouble(symbolName,SYMBOL_ASK);
      double stoploss= bougie_low(1,symbolName,Timeframe);
      double takeprofit= bougie_close(1,symbolName,Timeframe)+bougie_corps(1,symbolName,Timeframe);
      double lot=CalculatorPstdevise(stoploss,ask,symbolName,0, capital,0.5);
      if(trade.Buy(lot,symbolName,ask,stoploss,takeprofit)){
         date_post_op[i]= set_ope_bougie(symboles[i]);

      }
      
      
    }
        /////////////////////////////////////////////////////////////
    else if (penetrante_baissiere(symbolName,Timeframe)&&
    (Bull_apesanteur_haute(1,symbolName,Timeframe)||Bull_apesanteur_haute(2,symbolName,Timeframe)||Ichimoku_TK_vente(1,symbolName,Timeframe)))
    {
      double bid = SymbolInfoDouble(symbolName,SYMBOL_BID);
      double stoploss= bougie_high(1,symbolName,Timeframe);
      double takeprofit= bougie_close(1,symbolName,Timeframe)-bougie_corps(1,symbolName,Timeframe);
      double lot=CalculatorPstdevise(stoploss,bid,symbolName,1, capital,0.5);
      if(trade.Sell(lot,symbolName,bid,stoploss,takeprofit)){
         date_post_op[i]= set_ope_bougie(symboles[i]);                   
      }
      
      
    }
     else if (Cassure_kijun_haussier(1,symbolName,Timeframe))
    {
      double ask = SymbolInfoDouble(symbolName,SYMBOL_ASK);
      double stoploss= bougie_low(1,symbolName,Timeframe);
      double takeprofit= bougie_close(1,symbolName,Timeframe)+bougie_corps(1,symbolName,Timeframe);
      double lot=CalculatorPstdevise(stoploss,ask,symbolName,0, capital,0.5);
      if(trade.Buy(lot,symbolName,ask,stoploss,takeprofit)){
         date_post_op[i]= set_ope_bougie(symboles[i]);

      }
      
      
    }
        /////////////////////////////////////////////////////////////
    else if (Cassure_kijun_baissier(1,symbolName,Timeframe))
    {
      double bid = SymbolInfoDouble(symbolName,SYMBOL_BID);
      double stoploss= bougie_high(1,symbolName,Timeframe);
      double takeprofit= bougie_close(1,symbolName,Timeframe)-bougie_corps(1,symbolName,Timeframe);
      double lot=CalculatorPstdevise(stoploss,bid,symbolName,1, capital,0.5);
      if(trade.Sell(lot,symbolName,bid,stoploss,takeprofit)){
         date_post_op[i]= set_ope_bougie(symboles[i]);                   
      }
      
      
    }
        //////////////////////////////////////////////////////////////
    else if (Cassure_Tenkan_Haussier(symbolName,Timeframe))
    {
      double ask = SymbolInfoDouble(symbolName,SYMBOL_ASK);
      double stoploss= bougie_low(1,symbolName,Timeframe);
      double takeprofit= bougie_close(1,symbolName,Timeframe)+bougie_corps(1,symbolName,Timeframe);
      double lot=CalculatorPstdevise(stoploss,ask,symbolName,0, capital,0.5);
      if(trade.Buy(lot,symbolName,ask,stoploss,takeprofit)){
         date_post_op[i]= set_ope_bougie(symboles[i]);

      }
      
      
    }
        /////////////////////////////////////////////////////////////
    else if (Cassure_Tenkan_Baissier(symbolName,Timeframe))
    {
      double bid = SymbolInfoDouble(symbolName,SYMBOL_BID);
      double stoploss= bougie_high(1,symbolName,Timeframe);
      double takeprofit= bougie_close(1,symbolName,Timeframe)-bougie_corps(1,symbolName,Timeframe);
      double lot=CalculatorPstdevise(stoploss,bid,symbolName,1, capital,0.5);
      if(trade.Sell(lot,symbolName,bid,stoploss,takeprofit)){
         date_post_op[i]= set_ope_bougie(symboles[i]);               
      }
      
      
    }

}

ulong set_ope_bougie(string symbolName){
   
   MqlRates historyBuffer[];//tableaux contenant les données de bougie
   
   ArraySetAsSeries(historyBuffer,true);//Indexe le tableau dans le sens du plus récent ou plus anciens
   ulong UT = 0;//variable qui va être implémenté du délai avant lequel on peu reprendre une position
   if(CopyRates(symbolName,Timeframe_contexte,0,2,historyBuffer)){
               ulong date1 = (ulong)historyBuffer[2].time;
               ulong date2 = (ulong)historyBuffer[1].time;
               UT = (ulong)TimeCurrent() +2*(date2-date1);//contient 2 fois l'UT utilisé
         
}
   return UT;//retourne la valeur de UT
}

string TimeframeToString(ENUM_TIMEFRAMES TF) {
   switch (TF) {

      case PERIOD_H1:   return "H1";
      case PERIOD_H4:   return "H4";
      case PERIOD_H8:   return "H8";
      case PERIOD_H12:   return "H12";
      case PERIOD_D1:   return "D1";
      case PERIOD_W1:   return "W1";
      case PERIOD_MN1:  return "MN1";
      default:          return "UNKNOWN"; // Si la période n'est pas reconnue
   }
}