//+------------------------------------------------------------------+
//|                                                      test_bb.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
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
string symboles[] = {"EURUSD", "GBPUSD","USDJPY","USDCAD","NZDUSD","AUDUSD","USDCHF","EURJPY","GBPJPY","CADJPY","EURNZD"/*,"GBPNZD","EURGBP","NZDJPY","AUDJPY",
"EURAUD","GBPAUD","GBPCHF","AUDCHF","CHFJPY"*/};
ulong date_post_op[] = {0,0,0,0,0,0,0,0,0,0,0/*,0,0,0,0,0,0,0,0,0*/};

void  OnTick(void)
{
   
   bool test= true;//Le programme marchera tous le temps
   MqlDateTime now;
   TimeToStruct(TimeCurrent(), now);//On paramètre la variable au temps actuelle
   //Les pric bugge à 00h05 surement car c'est l'initialisation des prix.
   //if((now.hour<=00 &&now.min>=06)||now.hour >= 1){
      //boucle selectionnant 1 à 1 les symboles
      for(int i = 0; i < ArraySize(symboles); i += 1){
      
         //On compare la date à laquelle on a tradé à la variable de l'heure actuelle pour qu'il éviter les bug
         if(date_post_op[i]<=(ulong)TimeCurrent()){
            
            //On regarde si il y a 1 position ouvert dans le symbol
            if(symbolGetPositionTotal(symboles[i]) < 1){
               start(i,symboles[i],_Period);
            }
            /*else
              {
               double mid= Mid_BB(_Period,1,symboles[i]);
               ModifyTakeProfitSimple(symboles[i],mid);
              }*/
         
         }
         /*else
         {
            double mid= Mid_BB(_Period,1,symboles[i]);
            ModifyTakeProfitSimple(symboles[i],mid);
         }*/
          
       }   
   //}
   
}
void start (int i,string symbolName,ENUM_TIMEFRAMES Timeframe){

   if(avalente_haussier(symbolName,Timeframe)&&opportunite_achat_BB(symbolName,Timeframe))
   {
     double ask = SymbolInfoDouble(symbolName,SYMBOL_ASK);
      double stoploss= bougie_low(1,symbolName,Timeframe);
      double takeprofit=Mid_BB(Timeframe,1,symbolName);
      double lot=CalculatorPstdevise(stoploss,ask,symbolName,0, capital,0.5);
      if(trade.Buy(lot,symbolName,ask,stoploss,takeprofit)){
         date_post_op[i]= set_ope_bougie(Timeframe);
         /*Print("avalenteA+" +symbolName);
         if(Bull_apesanteur_basse(1,symbolName,Timeframe))
           {
            Print("111");
           }
         if(Bull_apesanteur_basse(2,symbolName,Timeframe))
           {
            Print("222");
           }*/
      }
   }
   else if (avalente_baissiere(symbolName,Timeframe)&&opportunite_vente_BB(symbolName,Timeframe))
   {
      double bid = SymbolInfoDouble(symbolName,SYMBOL_BID);
      double stoploss= bougie_high(1,symbolName,Timeframe);
      double takeprofit= Mid_BB(Timeframe,1,symbolName);
      double lot=CalculatorPstdevise(stoploss,bid,symbolName,1, capital,0.5);
      if(trade.Sell(lot,symbolName,bid,stoploss,takeprofit)){
         date_post_op[i]= set_ope_bougie(Timeframe);                   
      }
   }
   else if(etoile_du_matin(symbolName,Timeframe)&& opportunite_achat_BB(symbolName,Timeframe))
   {
      double ask = SymbolInfoDouble(symbolName,SYMBOL_ASK);
      double stoploss= bougie_low(2,symbolName,Timeframe);
      double takeprofit= Mid_BB(Timeframe,1,symbolName);
      double lot=CalculatorPstdevise(stoploss,ask,symbolName,0, capital,0.5);
      if(trade.Buy(lot,symbolName,ask,stoploss,takeprofit)){
         date_post_op[i]= set_ope_bougie(Timeframe);
           
      }
   }
   else if (etoile_du_soir(symbolName,Timeframe) && opportunite_vente_BB(symbolName,Timeframe))
   {
      double bid = SymbolInfoDouble(symbolName,SYMBOL_BID);
      double stoploss= bougie_high(2,symbolName,Timeframe);
      double takeprofit= Mid_BB(Timeframe,1,symbolName);
      double lot=CalculatorPstdevise(stoploss,bid,symbolName,1, capital,0.5);
      if(trade.Sell(lot,symbolName,bid,stoploss,takeprofit)){
         date_post_op[i]= set_ope_bougie(Timeframe);
      }
   }
   else if (penetrante_haussier(symbolName,Timeframe)&&opportunite_achat_BB(symbolName,Timeframe))
   {
      double ask = SymbolInfoDouble(symbolName,SYMBOL_ASK);
      double stoploss= bougie_low(1,symbolName,Timeframe);
      double takeprofit= Mid_BB(Timeframe,1,symbolName);
      double lot=CalculatorPstdevise(stoploss,ask,symbolName,0, capital,0.5);
      if(trade.Buy(lot,symbolName,ask,stoploss, takeprofit)){
         date_post_op[i]= set_ope_bougie(Timeframe);
           
      }
   }
   else if (penetrante_baissiere(symbolName,Timeframe)&&opportunite_vente_BB(symbolName,Timeframe))
   {
      double bid = SymbolInfoDouble(symbolName,SYMBOL_BID);
      double stoploss= bougie_high(1,symbolName,Timeframe);
      double takeprofit= Mid_BB(Timeframe,1,symbolName);
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
}/*
////////////////////////////GetSymbolPositionsCount/////////////////////////////////
//retourne le nombre de position prise pour un symbole données
int GetSymbolPositionsCount(string symbol) 
{
    int count = 0;
    
    // Parcourir toutes les positions ouvertes
    for (int i = 0; i < PositionsTotal(); i++) 
    {
        // Récupérer le handle de la position
        ulong positionTicket = PositionGetTicket(i);
        
        // Si la position est valide, vérifier le symbole
        if (PositionSelectByTicket(positionTicket))
        {
            if (PositionGetString(POSITION_SYMBOL) == symbol) 
            {
                count++;
            }
        }
    }
    return count;
}
//////////////////////////////Modifié position////////////////////////////////
bool ModifyTakeProfitSimple(string symbol, double new_tp)
{
    // Sélectionne la position pour le symbole donné
    if(PositionSelect(symbol))
    {
        // Récupère le Take Profit actuel
        double current_tp = PositionGetDouble(POSITION_TP);
        
        // Vérifie si le TP est déjà égal au nouveau TP
        if(current_tp == new_tp)
        {
           // Print("Le Take Profit est déjà défini à cette valeur pour ", symbol, ": ", new_tp);
            return false; // Pas besoin de modification
        }

        // Récupère le ticket et le Stop Loss existant
        ulong ticket = PositionGetInteger(POSITION_TICKET);
        double stop_loss = PositionGetDouble(POSITION_SL);

        // Prépare la requête de modification
        MqlTradeRequest request;
        MqlTradeResult result;

        ZeroMemory(request);
        ZeroMemory(result);

        request.action = TRADE_ACTION_SLTP; // Modifier SL/TP
        request.position = ticket;         // Ticket de la position
        request.sl = stop_loss;            // Garde le même SL
        request.tp = new_tp;               // Nouveau TP

        // Envoie la requête et vérifie le résultat
        if(OrderSend(request, result) && result.retcode == TRADE_RETCODE_DONE)
        {
            Print("TP modifié pour ", symbol, ". Nouveau TP : ", new_tp);
            return true;
        }

        Print("Erreur lors de la modification du TP : ", result.retcode);
        return false;
    }

    //Print("Aucune position trouvée pour le symbole : ", symbol);
    return false;
}


//////////////////////////////Close position BB////////////////////////////////

void closePositionBB(string symbolName,ENUM_TIMEFRAMES Timeframe){

   CTrade trade;
   double bid = SymbolInfoDouble(symbolName,SYMBOL_BID);
   double mid= Mid_BB(Timeframe,1,symbolName);
   double prix = bougie_close(0,symbolName,Timeframe);
   if(GetSymbolPositionsCount(symbolName)>0)
    {
      if(bid == mid)
      {
         if(!trade.PositionClose(symbolName)){
         
         Print("probleme de fermeture de position pour la paire"+ symbolName);
            
         }
         else
           {
           double ecart=mid-bid;
            Print("prixbid= "+(string)bid);
            Print("prix= "+(string)prix);
            Print("Mid_bb= "+(string)mid);  
            Print("écart= "+(string)ecart);  
           }
         
      }

   }
}

*/