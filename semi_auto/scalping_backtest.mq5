//+------------------------------------------------------------------+
//|                                            scalping_backtest.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
ulong date_post_op= 0;
#include <Trade\Trade.mqh>//Accées à la librairie nous permettant d'ouvrir une position dont la class Ctrade
//Ce programme va nous faire des carré dans un temps un temps limité sur plusieurs jours

CTrade trade;
input datetime date_start=D'2022.09.01 09:00:00';
input datetime date_end=D'2023.07.31 09:00:00';
input int Heure=8;
input int Minute=00;
int stop=0;
void OnTick(){

   if(stop<=0){
      OPR2();   
   }

}


ulong get_ope_bougie(){
   
   MqlRates historyBuffer[];
   
   ArraySetAsSeries(historyBuffer,true);
   ulong UT = 0;
   if(CopyRates(_Symbol,PERIOD_M15,0,3,historyBuffer)){
               ulong date1 = (ulong)historyBuffer[2].time;
               ulong date2 = (ulong)historyBuffer[1].time;
               UT = 12*(date2-date1);
         
   }
   return UT;
     
   
}

void OPR2(){


   MqlRates historyBuffer[];
   ArraySetAsSeries(historyBuffer,true);
   ulong UT = 0;
   int taille_tab =CopyRates(_Symbol,PERIOD_M15,date_start,date_end,historyBuffer);
   if(taille_tab>0){
      
      for(int i=0;i<taille_tab;i++)
      {
         MqlDateTime now;
         TimeToStruct(historyBuffer[i].time, now);
         if(now.hour == Heure && now.min == Minute){
         
//---définit les variable du réctangle           
            datetime date = historyBuffer[i].time;
            datetime date2 =(datetime)((ulong)historyBuffer[i].time+get_ope_bougie());
            double low =getlowerCandle(_Symbol,PERIOD_M15,date,date2);
            double high=getHigherCandle(_Symbol,PERIOD_M15,date,date2);
            
//--- Test des différent valeur
            Print("high=" + (string)high);
            Print("low=" + (string)low);
            Print("date=" + (string)date);
            Print("date2=" + (string)date2);
            int  total_obj = i+1;
            if(!ObjectCreate(0,(string)total_obj,OBJ_RECTANGLE,0,date,low,date2,high))
            {
               Print(__FUNCTION__," : impossible de créer un rectangle ! Code d'erreur = ",GetLastError());
            }
//--- définit la couleur du rectangle
            ObjectSetInteger(0,(string)total_obj,OBJPROP_COLOR,clrAqua);
//--- définit le style des lignes du rectangle
            ObjectSetInteger(0,(string)total_obj,OBJPROP_STYLE,STYLE_SOLID);
//--- active (true) ou désactive (false) le mode de remplissage du rectangle
            ObjectSetInteger(0,(string)total_obj,OBJPROP_FILL,true);
//--- affiche en premier plan (false) ou en arrière-plan (true)
            ObjectSetInteger(0,(string)total_obj,OBJPROP_BACK,true);
            date_post_op=get_ope_bougie();
         
         }
      }
   }
   stop=1;
   
}
double getHigherCandle(string symbolName, ENUM_TIMEFRAMES timeframe,datetime start_time,datetime stop_time){

   MqlRates higherBuffer;
   MqlRates rates[];
   double higher=NULL;
   
   ArraySetAsSeries(rates, true);
   int nbCandle=CopyRates(symbolName, timeframe,start_time,stop_time,rates) ;
   if(nbCandle!=NULL){

      higherBuffer = rates[0];

      for(int i = 1; i < nbCandle; i += 1){

         if(rates[i].open > higherBuffer.open) higherBuffer = rates[i];

      }

      higher = higherBuffer.open;

      

   }
   return higher;
}


double getlowerCandle(string symbolName, ENUM_TIMEFRAMES timeframe, datetime start_time,datetime stop_time){

   MqlRates lowerBuffer;
   MqlRates rates[];
   double lower=NULL;
   
   ArraySetAsSeries(rates, true);
   int nbCandle =CopyRates(symbolName, timeframe,start_time,stop_time, rates);
   if( nbCandle !=NULL){

      lowerBuffer = rates[0];

      for(int i = 1; i < nbCandle; i += 1){

         if(rates[i].open < lowerBuffer.open) lowerBuffer = rates[i];

      }

      lower = lowerBuffer.open;

   }
   return lower;


}
