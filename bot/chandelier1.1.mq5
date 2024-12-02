//+------------------------------------------------------------------+
//|                                                   chandelier.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
////Dans ce programme je test les figures en chandelier avec des programmes d'entrée de position qui sont dant un fichier externe
#include <Riad\Candle.mqh>
#include <Riad/Ichimoku.mqh>
#include <Trade\Trade.mqh>
#include <Riad\Calculateur.mqh>
#include <Riad\figure_continuation.mqh>
#include <Riad\figure_retournement.mqh>
#include <Riad\Entry.mqh>

input group "Money Management";
input float Risque=0.5;
input int Capital=20000;
input int ichi_SSB=52;

input group "TimeFrames";
input ENUM_TIMEFRAMES Timeframe_position1 = PERIOD_M5;
input ENUM_TIMEFRAMES Timeframe_position2 = PERIOD_M3;
input ENUM_TIMEFRAMES Timeframe_contexte = PERIOD_H1;

string symboles[] = {"EURJPY", "GBPJPY"};
ulong date_post_op[] = {0,0};

void OnTick(){
   bool test= true;//Le programme marchera tous le temps
   MqlDateTime now;
   TimeToStruct(TimeCurrent(), now);//On paramètre la variable au temps actuelle
   
   if(now.hour >= 9 && now.hour < 19){
      //boucle selectionnant 1 à 1 les symboles
      for(int i = 0; i < ArraySize(symboles); i += 1){
      
         //On compare la date à laquelle on a tradé à la variable de l'heure actuelle pour qu'il éviter les bug
         if(date_post_op[i]<=(ulong)TimeCurrent()){
            
            //On regarde si il y a 1 position ouvert dans le symbol
            if(symbolGetPositionTotal(symboles[i]) < 1){

               start(i,symboles[i],Timeframe_position1,Timeframe_position2,Timeframe_contexte);
               
            
            }

         }

      }
   }//if horaire
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
   if(avalente_haussier(symbolName,Timeframe_contexte))
   {
      opportunite_haussiere = true;
      date_fin_opportunite_haussiere= (ulong)TimeCurrent()+get_time(symbolName,Timeframe_contexte);
      Print( "Opportunité haussière");
   }
   else if(avalente_baissiere(symbolName,Timeframe_contexte))
   {
      opportunite_baissiere=true;
      date_fin_opportunite_baissiere= (ulong)TimeCurrent()+get_time(symbolName,Timeframe_contexte);
         Print( "Opportunité baissière");
         //Print( "Opportunité baissière");
        // Print( "Opportunité baissière");
      
   }
   while (opportunite_haussiere)
   {
      if(Cassure_Tenkan_Haussier2(symbolName,Timeframe_position1,Capital,Risque))
      {
         date_post_op[i]= set_ope_bougie(symboles[i]);
         break;
      }
      else if(Cassure_Tenkan_Haussier2(symbolName,Timeframe_position2,Capital,Risque))
      {
         date_post_op[i]= set_ope_bougie(symboles[i]);
         break;  
      }
      break;
   }
   while (opportunite_baissiere)
   {  
      if(Cassure_Tenkan_Baissier2(symbolName,Timeframe_position1,Capital,Risque)){
      
         date_post_op[i]= set_ope_bougie(symboles[i]);
         break;
      }
      else if(Cassure_Tenkan_Baissier2(symbolName,Timeframe_position2,Capital,Risque))
      {
         date_post_op[i]= set_ope_bougie(symboles[i]);
         break;  
      }
      break;
         
   }


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
