//+------------------------------------------------------------------+
//|                                                chandelier2.0.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//Dans ce programme j'ai rajouter la fonction BE en changeant les parametre de en ENTRY
#include <Riad\Candle.mqh>
#include <Riad/Ichimoku.mqh>
#include <Trade\Trade.mqh>
#include <Riad\Calculateur.mqh>
#include <Riad\figure_continuation.mqh>
#include <Riad\figure_retournement.mqh>
#include <Riad\Entry2.0.mqh>
#include <Riad\Update.mqh>

input group "Money Management";
input float Risque=0.5;
input int Capital=20000;
input int ichi_SSB=52;

input group "TimeFrames";
input ENUM_TIMEFRAMES Timeframe_position1 = PERIOD_M5;
input ENUM_TIMEFRAMES Timeframe_position2 = PERIOD_M3;
input ENUM_TIMEFRAMES Timeframe_contexte = PERIOD_H1;

string symboles[] = {"EURJPY", "GBPJPY"};
bool modifiedSl[]={0,0};
ulong date_post_op[] = {0,0};
double BE=0;

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
               modifiedSl[i]=0;
               BE=0;
               start(i,symboles[i],Timeframe_position1,Timeframe_position2,Timeframe_contexte);
               
            
            }
            else if(modifiedSl[i]==1)
            {
               updateStopLoss(symboles[i],BE );
            }//elseif
         }
         else if(modifiedSl[i]==1)
         {
           updateStopLoss(symboles[i],BE );
         }//elseif
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
      double BE_TF1=Cassure_Tenkan_Haussier3(i,symbolName,Timeframe_position1,Capital,Risque);
      if(BE_TF1!=0)
      {
         date_post_op[i]= set_ope_bougie(symboles[i]);
         BE=BE_TF1;
         modifiedSl[i]=1;
         break;
      }
      double BE_TF2=Cassure_Tenkan_Haussier3(i,symbolName,Timeframe_position2,Capital,Risque);
      if(BE_TF2!=0)
      {
         date_post_op[i]= set_ope_bougie(symboles[i]);
         BE=BE_TF2;
         modifiedSl[i]=1;
         break;  
      }
      break;
   }
   while (opportunite_baissiere)
   {
      double BE_TF1=Cassure_Tenkan_Baissier3(i,symbolName,Timeframe_position1,Capital,Risque);
      if(BE_TF1!=0){
         date_post_op[i]= set_ope_bougie(symboles[i]);
         BE=BE_TF1;
         modifiedSl[i]=1;
         break;
      }
      double BE_TF2=Cassure_Tenkan_Baissier3(i,symbolName,Timeframe_position2,Capital,Risque);
      if(BE_TF2!=0)
      {
         date_post_op[i]= set_ope_bougie(symboles[i]);
         BE=BE_TF2;
         modifiedSl[i]=1;
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
