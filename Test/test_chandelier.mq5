#include <Riad/Figure_indicateur_technique.mqh>
#include <Riad\Calculateur.mqh>
#include <Riad\Candle.mqh>
#include <Riad\figure_continuation1.0.mqh>
#include <Riad\figure_retournement1.0.mqh>
#include <Trade\Trade.mqh>
#include <Riad/Setup.mqh>
//test des setup définit

int capital = 20000;
CTrade trade;
string symboles[] = {"EURUSD", "GBPUSD","USDJPY","USDCAD","NZDUSD","AUDUSD","USDCHF","EURJPY","GBPJPY","CADJPY","EURNZD","GBPNZD","EURGBP","NZDJPY","AUDJPY",
"EURAUD","GBPAUD","GBPCHF","AUDCHF","CHFJPY"};
ulong date_post_op[] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};

void  OnTick(void)
{
   
   bool test= true;//Le programme marchera tous le temps
   MqlDateTime now;
   TimeToStruct(TimeCurrent(), now);//On paramètre la variable au temps actuelle
   
   if(now.hour >= 6 && now.hour < 11){
      //boucle selectionnant 1 à 1 les symboles
      for(int i = 0; i < ArraySize(symboles); i += 1){
      
         //On compare la date à laquelle on a tradé à la variable de l'heure actuelle pour qu'il éviter les bug
         if(date_post_op[i]<=(ulong)TimeCurrent()){
            
            //On regarde si il y a 1 position ouvert dans le symbol
            if(symbolGetPositionTotal(symboles[i]) < 1){
      
               start(i,symboles[i],_Period);
            }
         
          }
       }   
   }
   
}
void start (int i,string symbolName,ENUM_TIMEFRAMES Timeframe){

   if(etoile_du_matin(symbolName,Timeframe)&&
   (Bull_apesanteur_basse(3,symbolName,Timeframe)||Bull_apesanteur_basse(2,symbolName,Timeframe)||Ichimoku_TK_achat(1,symbolName,Timeframe)))
   {
     double ask = SymbolInfoDouble(symbolName,SYMBOL_ASK);
      double stoploss= bougie_low(1,symbolName,Timeframe);
      double takeprofit= bougie_close(1,symbolName,Timeframe)+bougie_corps(1,symbolName,Timeframe);
      double lot=CalculatorPstdevise(stoploss,ask,symbolName,0, capital,0.5);
      if(trade.Buy(lot,symbolName,ask,stoploss,takeprofit)){
         date_post_op[i]= set_ope_bougie(Timeframe);

      }
   }
   else if (etoile_du_soir(symbolName,Timeframe)&&
    (Bull_apesanteur_haute(3,symbolName,Timeframe)||Bull_apesanteur_haute(2,symbolName,Timeframe)||Ichimoku_TK_vente(1,symbolName,Timeframe)))
   {
      double bid = SymbolInfoDouble(symbolName,SYMBOL_BID);
      double stoploss= bougie_high(1,symbolName,Timeframe);
      double takeprofit= bougie_close(1,symbolName,Timeframe)-bougie_corps(1,symbolName,Timeframe);
      double lot=CalculatorPstdevise(stoploss,bid,symbolName,1, capital,0.5);
      if(trade.Sell(lot,symbolName,bid,stoploss,takeprofit)){
         date_post_op[i]= set_ope_bougie(Timeframe);                   
      }
   }
   else if (avalente_haussier(symbolName,Timeframe)&&
    (Bull_apesanteur_basse(1,symbolName,Timeframe)||Bull_apesanteur_basse(2,symbolName,Timeframe)||Ichimoku_TK_achat(1,symbolName,Timeframe)))
   {
     double ask = SymbolInfoDouble(symbolName,SYMBOL_ASK);
      double stoploss= bougie_low(1,symbolName,Timeframe);
      double takeprofit= bougie_close(1,symbolName,Timeframe)+bougie_corps(1,symbolName,Timeframe);
      double lot=CalculatorPstdevise(stoploss,ask,symbolName,0, capital,0.5);
      if(trade.Buy(lot,symbolName,ask,stoploss,takeprofit)){
         date_post_op[i]= set_ope_bougie(Timeframe);

      }
   }
   else if (avalente_baissiere(symbolName,Timeframe)&&
    (Bull_apesanteur_haute(1,symbolName,Timeframe)||Bull_apesanteur_haute(2,symbolName,Timeframe)||Ichimoku_TK_vente(1,symbolName,Timeframe)))
   {
      double bid = SymbolInfoDouble(symbolName,SYMBOL_BID);
      double stoploss= bougie_high(1,symbolName,Timeframe);
      double takeprofit= bougie_close(1,symbolName,Timeframe)-bougie_corps(1,symbolName,Timeframe);
      double lot=CalculatorPstdevise(stoploss,bid,symbolName,1, capital,0.5);
      if(trade.Sell(lot,symbolName,bid,stoploss,takeprofit)){
         date_post_op[i]= set_ope_bougie(Timeframe);                   
      }
   }

    else if (penetrante_haussier(symbolName,Timeframe)&&
    (Bull_apesanteur_basse(1,symbolName,Timeframe)||Bull_apesanteur_basse(2,symbolName,Timeframe)||Ichimoku_TK_achat(1,symbolName,Timeframe)))
   {
     double ask = SymbolInfoDouble(symbolName,SYMBOL_ASK);
      double stoploss= bougie_low(1,symbolName,Timeframe);
      double takeprofit= bougie_close(1,symbolName,Timeframe)+bougie_corps(1,symbolName,Timeframe);
      double lot=CalculatorPstdevise(stoploss,ask,symbolName,0, capital,0.5);
      if(trade.Buy(lot,symbolName,ask,stoploss,takeprofit)){
         date_post_op[i]= set_ope_bougie(Timeframe);

      }
   }
    else if (penetrante_baissiere(symbolName,Timeframe)&&
    (Bull_apesanteur_haute(1,symbolName,Timeframe)||Bull_apesanteur_haute(2,symbolName,Timeframe)||Ichimoku_TK_vente(1,symbolName,Timeframe)))
   {
      double bid = SymbolInfoDouble(symbolName,SYMBOL_BID);
      double stoploss= bougie_high(1,symbolName,Timeframe);
      double takeprofit= bougie_close(1,symbolName,Timeframe)-bougie_corps(1,symbolName,Timeframe);
      double lot=CalculatorPstdevise(stoploss,bid,symbolName,1, capital,0.5);
      if(trade.Sell(lot,symbolName,bid,stoploss,takeprofit)){
         date_post_op[i]= set_ope_bougie(Timeframe);                   
      }
   }
   
}

//////////////////////////Fonction operation////////////////////////////////////////////////////////
//Cette fonction va nous permettre de ne pas prendre plusieurs position perdante dans une bougie qui a déja un trade perdant.
ulong set_ope_bougie(ENUM_TIMEFRAMES Timeframe){
   
   MqlRates historyBuffer[];
   
   ArraySetAsSeries(historyBuffer,true);
   ulong UT = 0;
   if(CopyRates(_Symbol,Timeframe,0,3,historyBuffer)){
               ulong date1 = (ulong)historyBuffer[2].time;
               ulong date2 = (ulong)historyBuffer[1].time;
               UT = (ulong)TimeCurrent() +2*(date2-date1);
         
   }
   return UT;
     
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