﻿//+------------------------------------------------------------------+
//|                                                   chandelier.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//Dans ce programme je test les figures en chandelier avec des programmes d'entrée de position qui sont dans le fichier lui même
#include <Riad\Candle.mqh>
#include <Riad/Ichimoku.mqh>
#include <Trade\Trade.mqh>
#include <Riad\Calculateur.mqh>
#include <Riad\figure_continuation.mqh>
#include <Riad\figure_retournement.mqh>


input group "Money Management";
input float Risque=0.5;
input int Capital=20000;
input int ichi_SSB=52;

input group "TimeFrames";
input ENUM_TIMEFRAMES Timeframe_position1 = PERIOD_M5;
input ENUM_TIMEFRAMES Timeframe_position2 = PERIOD_M3;
input ENUM_TIMEFRAMES Timeframe_contexte = PERIOD_H1;

string symboles[] = {"EURUSD", "GBPUSD"};
ulong date_post_op[] = {0,0};

void OnTick(){
   bool test= true;//Le programme marchera tous le temps
   MqlDateTime now;
   TimeToStruct(TimeCurrent(), now);//On paramètre la variable au temps actuelle
   
   if(now.hour >= 9 && now.hour < 19){
      //boucle selectionnant 1 à 1 les symboles
      for(int i = 0; i < ArraySize(symboles); i += 1){
         /*if(lastcloseorder(date_post_op[i],symboles[i])==true){
            date_post_op[i]= set_ope_bougie(symboles[i]);
         }*/
         //On compare la date à laquelle on a tradé à la variable de l'heure actuelle pour qu'il éviter les bug
         if(date_post_op[i]<=(ulong)TimeCurrent()){
        
            //On regarde si il y a 1 position ouvert dans le symbol
            if(symbolGetPositionTotal(symboles[i]) < 1){
               /*Cassure_Tenkan_Baissier(i,symboles[i],_Period);
               Cassure_Tenkan_Haussier(i,symboles[i],_Period);*/
               start(i,symboles[i],Timeframe_position1,Timeframe_position2,Timeframe_contexte);
            
            }
         }
       }
    }
}
/////////////////////////////////////////////////////////////////////////////////////////////
void start(int i,string symbolName,ENUM_TIMEFRAMES Timeframe_position1,ENUM_TIMEFRAMES Timeframe_position2, ENUM_TIMEFRAMES Timeframe_contexte ){
   ulong date_fin_opportunite_haussiere = 0;
   ulong date_fin_opportunite_baissiere = 0;
   bool opportunite_haussiere = false;
   bool opportunite_baissiere = false;
   /* On initialise le niv de prix où l'opportunité n'est plus valide. On ne differencie pas l'opportnité haussière de la baissière
   car il est impossible qu'on est les deux en même temps*/
   bool SL_opportunite = 0;
   //On regarde toutes les figures haussière
   if(etoile_du_matin(symbolName,Timeframe_contexte))
   {
      opportunite_haussiere = true;
      SL_opportunite= bougie_high(2,symbolName,Timeframe_contexte);
      date_fin_opportunite_haussiere= (ulong)TimeCurrent()+get_time(symbolName,Timeframe_contexte);
   }
   else if(etoile_du_soir(symbolName,Timeframe_contexte))
   {
      opportunite_baissiere=true;
      SL_opportunite= bougie_high(2,symbolName,Timeframe_contexte);
      date_fin_opportunite_baissiere= (ulong)TimeCurrent()+get_time(symbolName,Timeframe_contexte);
        // Print( "Opportunité baissière");
         //Print( "Opportunité baissière");
        // Print( "Opportunité baissière");
      
   }
   while (opportunite_haussiere)
   {
      if(Cassure_Tenkan_Haussier(i,symbolName,Timeframe_position1)){

         break;
      }
      else if(Cassure_Tenkan_Haussier(i,symbolName,Timeframe_position2))
      {

         break;  
      }
      break;
   }
   while (opportunite_baissiere)
   {
      if(Cassure_Tenkan_Baissier(i,symbolName,Timeframe_position1)){
         /*double stoploss= bougie_high(1,symbolName,Timeframe_position1);
         double spread=0;
         if(SymbolInfoDouble(symbolName,SYMBOL_POINT)==0.00001)
         {
            spread = (SymbolInfoInteger(symbolName,SYMBOL_SPREAD)*0.00001);
         }
         else
         {           
            spread = (SymbolInfoInteger(symbolName,SYMBOL_SPREAD)*0.001);
         }
         double takeprofit= bougie_close(1,symbolName,Timeframe_position1)-(bougie_corps(1,symbolName,Timeframe_position1)+spread)*3;
         double lot=CalculatorPstdevise(stoploss,bid,symbolName,1, Capital,Risque);
         if(trade.Sell(lot,symbolName,bid,stoploss,takeprofit)){
            date_post_op[i]= set_ope_bougie(symboles[i]);
            int Scode = (int)trade.ResultRetcode();//voir la doc
            ulong Sticket = trade.ResultOrder();//identification d'une position, si le trade ne ses pas réaliser le ticket sera à zero
            Print("Code:"+(string)Scode);
            Print("Ticket:"+(string)Sticket);
            break;
         }*/
         break;
      }
      else if(Cassure_Tenkan_Baissier(i,symbolName,Timeframe_position2))
      {
         /*double stoploss= bougie_high(1,symbolName,Timeframe_position1);
         double spread=0;
         if(SymbolInfoDouble(symbolName,SYMBOL_POINT)==0.00001)
         {
            spread = (SymbolInfoInteger(symbolName,SYMBOL_SPREAD)*0.00001);
         }
         else
         {           
            spread = (SymbolInfoInteger(symbolName,SYMBOL_SPREAD)*0.001);
         }
         double takeprofit= bougie_close(1,symbolName,Timeframe_position1)-(bougie_corps(1,symbolName,Timeframe_position1)+spread)*3;
         double lot=CalculatorPstdevise(stoploss,bid,symbolName,1, Capital,Risque);
         if(trade.Sell(lot,symbolName,bid,stoploss,takeprofit)){
            date_post_op[i]= set_ope_bougie(symboles[i]);
            int Scode = (int)trade.ResultRetcode();//voir la doc
            ulong Sticket = trade.ResultOrder();//identification d'une position, si le trade ne ses pas réaliser le ticket sera à zero
            Print("Code:"+(string)Scode);
            Print("Ticket:"+(string)Sticket);
            break;
         }*/
         break;  
      }
      break;
         
   }


}

////////////////////////////Cassure tenkan//////////////////////////////////////////////////
bool Cassure_Tenkan_Haussier(int i,string symbolName,ENUM_TIMEFRAMES Period){
    CTrade trade;//objet qui sert à prendre position
  
   double ask = SymbolInfoDouble(symbolName,SYMBOL_ASK);//prix d'achat
   double meche1=bougie_meche_H(1,symbolName,Period)*2;
   double kijun1=kijun(Period,1,symbolName);
   double kijun2=kijun(Period,2,symbolName);
   double tenkan1= tenkan(Period,1,symbolName);
   double tenkan2= tenkan(Period,2,symbolName);
   double SSA1=SSA(Period,1,0,symbolName);
   double SSB1=SSB(Period,1,0,symbolName);
   bool Cassure_Correct=true; //Indique si la cassure est bien correct
   if(bougie_statut(2,symbolName,Period)==1)// si la bougie 2 est haussière
   {
      if(tenkan2!=-1 &&tenkan2<=bougie_close(2,symbolName,Period))//si la bougie 2 à casser aussi
      {
      Cassure_Correct=false;
      }
   }
   if(bougie_statut(2,symbolName,Period)==0)// si la bougie est baissière
   {
      if(tenkan2!=-1 && tenkan2<=bougie_close(2,symbolName,Period))//si la bougie 2 à casser aussi ou est plus haute que tenkan
      {
      Cassure_Correct=false;
      }
   }
   if(bougie_statut(2,symbolName,Period)==2)// si la bougie est un doji
   {
      if(tenkan2!=-1 && tenkan2<=bougie_close(2,symbolName,Period))//si la bougie 2 à casser aussi ou est plus haute que tenkan
      {
      Cassure_Correct=false;
      }
   }
   
   if(bougie_statut(1,symbolName,Period)==1 &&//La bougie 1 est haussiere
      meche1<=bougie_corps(1,symbolName,Period)&&
      bougie_corps(1,symbolName,Period)>bougie_corps(2,symbolName,Period)&&
      bougie_corps(1,symbolName,Period)>bougie_corps(3,symbolName,Period)){
      if(tenkan1!=-1 && tenkan1<=bougie_close(1,symbolName,Period)&& tenkan1>=bougie_open(1,symbolName,Period)&&(SSA1<tenkan1||SSB1<tenkan1)&&Cassure_Correct==true)
      {
        double stoploss= bougie_low(1,symbolName,Period);
        //Spread forex
        double spread=0;
         if(SymbolInfoDouble(symbolName,SYMBOL_POINT)==0.00001)
         {
            spread = (SymbolInfoInteger(symbolName,SYMBOL_SPREAD)*0.00001);
         }
         else
         {
            
            spread = (SymbolInfoInteger(symbolName,SYMBOL_SPREAD)*0.001);
         }
        double takeprofit= bougie_close(1,symbolName,Period)+(bougie_corps(1,symbolName,Period)+spread)*3;
        double lot=CalculatorPstdevise(stoploss,ask,symbolName,0, Capital,Risque);
        if(trade.Buy(lot,symbolName,ask,stoploss,takeprofit)){
         date_post_op[i]= set_ope_bougie(symboles[i]);
         int Scode = (int)trade.ResultRetcode();//voir la doc
         ulong Sticket = trade.ResultOrder();//identification d'une position, si le trade ne ses pas réaliser le ticket sera à zero
         Print("Code:"+(string)Scode);
         Print("Ticket:"+(string)Sticket);
         Print("Tenkan:"+(string)tenkan1);
         Print("prix d'ouverture:"+(string)bougie_open(1,symbolName,Period));
         Print("prix de fermeture:"+(string)bougie_close(1,symbolName,Period));
         return true;
        }
      }
      
   }
   return false;

}

bool Cassure_Tenkan_Baissier(int i, string symbolName,ENUM_TIMEFRAMES Period){
    CTrade trade;//objet qui sert à prendre position
  
   double bid = SymbolInfoDouble(symbolName,SYMBOL_BID);//prix de vente
   double meche1=bougie_meche_B(1,symbolName,Period)*2;
   double tenkan1= tenkan(Period,1,symbolName);
   double tenkan2= tenkan(Period,2,symbolName);
   double SSA1=SSA(Period,1,0,symbolName);
   double SSB1=SSB(Period,1,0,symbolName);
   bool Cassure_Correct=true; //Indique si la cassure est bien correct
   if(bougie_statut(2,symbolName,Period)==0)// si la bougie 2 est baissière ou est plus basse
   {
      if(tenkan2!=-1 &&tenkan2>=bougie_close(2,symbolName,Period))//si la bougie 2 à casser aussi
      {
      Cassure_Correct=false;
      }
   }
   if(bougie_statut(2,symbolName,Period)==1)// si la bougie est haussière
   {
      if(tenkan2!=-1 && tenkan2>=bougie_close(2,symbolName,Period))//si la bougie 2 à casser aussi
      {
      Cassure_Correct=false;
      }
   }
   if(bougie_statut(2,symbolName,Period)==2)// si la bougie est un doji
   {
      if(tenkan2!=-1 && tenkan2>=bougie_close(2,symbolName,Period))//si la bougie 2 à casser aussi
      {
      Cassure_Correct=false;
      }
   }
   
   if(bougie_statut(1,symbolName,Period)==0 &&//La bougie 1 est baissière
      meche1<=bougie_corps(1,symbolName,Period)&&
      bougie_corps(1,symbolName,Period)>bougie_corps(2,symbolName,Period)&&
      bougie_corps(1,symbolName,Period)>bougie_corps(3,symbolName,Period)&&
      bougie_corps(1,symbolName,Period)>bougie_corps(4,symbolName,Period)/*&&
      bougie_corps(1,symbolName,Period)>bougie_corps(5,symbolName,Period)*/){
      
      if(tenkan1!=-1 && tenkan1<=bougie_open(1,symbolName,Period)&& tenkan1>=bougie_close(1,symbolName,Period)&&(SSA1>tenkan1||SSB1>tenkan1)&&Cassure_Correct==true)
      {
         double stoploss= bougie_high(1,symbolName,Period);
         double spread=0;
         if(SymbolInfoDouble(symbolName,SYMBOL_POINT)==0.00001)
         {
            spread = (SymbolInfoInteger(symbolName,SYMBOL_SPREAD)*0.00001);
         }
         else
         {           
            spread = (SymbolInfoInteger(symbolName,SYMBOL_SPREAD)*0.001);
         }
        double takeprofit= bougie_close(1,symbolName,Period)-(bougie_corps(1,symbolName,Period)+spread)*3;
        double lot=CalculatorPstdevise(stoploss,bid,symbolName,1, Capital,Risque);
        if(trade.Sell(lot,symbolName,bid,stoploss,takeprofit)){
         date_post_op[i]= set_ope_bougie(symboles[i]);
         int Scode = (int)trade.ResultRetcode();//voir la doc
         ulong Sticket = trade.ResultOrder();//identification d'une position, si le trade ne ses pas réaliser le ticket sera à zero
         Print("Code:"+(string)Scode);
         Print("Ticket:"+(string)Sticket);
         return true;
               
                  
        }
      }
      
   }
   return false;

}

//////////////////////////Fonction operation////////////////////////////////////////////////////////
//Cette fonction va nous permettre de ne pas prendre plusieurs position perdante dans une bougie qui a déja un trade perdant.
ulong set_ope_bougie(string symbolName){
   
   MqlRates historyBuffer[];//tableaux contenant les données de bougie
   
   ArraySetAsSeries(historyBuffer,true);//Indexe le tableau dans le sens du plus récent ou plus anciens
   ulong UT = 0;//variable qui va être implémenté du délai avant lequel on peu reprendre une position
   if(CopyRates(symbolName,_Period,0,3,historyBuffer)){
               ulong date1 = (ulong)historyBuffer[2].time;
               ulong date2 = (ulong)historyBuffer[1].time;
               UT = (ulong)TimeCurrent() +2*(date2-date1);//contient 3 fois l'UT utilisé
         
   }
   return UT;//retourne la valeur de UT
}
/////////////////////////Fonction Getposition//////////////////////////////
int symbolGetPositionTotal(string symbolName){
   
   int total = 0;
   
   for(int i = 0; i < PositionsTotal(); i += 1){
   
      if(PositionGetSymbol(i) == symbolName){
      
         total += 1;
         
      }
   }
   return total;
}
ulong set_ope_bougie_soustraction(string symbolName){
   
   MqlRates historyBuffer[];//tableaux contenant les données de bougie
   
   ArraySetAsSeries(historyBuffer,true);//Indexe le tableau dans le sens du plus récent ou plus anciens
   ulong UT = 0;//variable qui va être implémenté du délai avant lequel on peu reprendre une position
   if(CopyRates(symbolName,_Period,0,3,historyBuffer)){
               ulong date1 = (ulong)historyBuffer[2].time;
               ulong date2 = (ulong)historyBuffer[1].time;
               UT = (ulong)TimeCurrent() -2*(date2-date1);//contient 3 fois l'UT utilisé
         
}
   return UT;//retourne la valeur de UT
}


//détecte si on a fermer un ordre il y a quelque temps.
bool lastcloseorder(ulong date_op, string symbole){
   if(date_op>(ulong)TimeCurrent()){
      datetime date= (datetime)date_op;
      HistorySelect(date,TimeCurrent());
      Print("utilisation de la fonction lastcloserorder");
      uint total=HistoryOrdersTotal();
//--- go through orders in a loop
      for(uint i=0;i<total;i+=1){
         ulong ticket =HistoryOrderGetTicket(i);
         ulong date_comparaison= set_ope_bougie_soustraction(symbole);
         if(HistoryOrderGetString(ticket,ORDER_SYMBOL)==symbole)
         {
            if((ulong)HistoryOrderGetInteger(ticket,ORDER_TIME_DONE)>=date_comparaison)
            {
               return true;
            }
         
         }
      }
   }
   return false;
}