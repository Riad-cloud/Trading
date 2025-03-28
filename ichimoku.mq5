//+------------------------------------------------------------------+
//|                                                         test.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"

#include <Trade\Trade.mqh>

input group "Ichimoku";
input int ichi_tenkan=9;
input int ichi_kijun=26;
input int ichi_SSB=52;

input ENUM_APPLIED_PRICE  bands_applied_price= PRICE_CLOSE;      // type de prix ou le handle
void OnTick(){
      
   if(PositionsTotal()<1){
         start();
   }

      
}

void start(){
   
      double Ichimoku_droite[];
      setIchimoku(Ichimoku_droite);
      double tenkan = Ichimoku_droite[0];
      double kijun = Ichimoku_droite[1];
      double SSA = Ichimoku_droite[2];
      double SSB = Ichimoku_droite[3];
      Print("Tenkan" +(string)tenkan);
      Print("Kijun" +(string)kijun);
      Print("SSA" +(string)SSA);
      Print("SSB" +(string)SSB);

   
}

//////////////////////////Fonction Ichimoku/////////////////////////////////////////
void setIchimoku(double & array[]){

   //On redimenssione le tableau pour qu'il est est une taille de trois pour pouvoir stocker les bande de bollinger
   ArrayResize(array,5);
   
  //On crée des tableau vide pour pouvoir stocker nos données.
   double kijun[];
   double tenkan[];
   double chinkou[];
   double SSA[];
   double SSB[];
   
   
   /*On défini chaqu'un des tableau comme une série temporel dons chaque élément sera classé par ordre décroissant du temps*/
   
   ArraySetAsSeries(tenkan,true);
   ArraySetAsSeries(kijun,true);
   ArraySetAsSeries(chinkou,true);
   ArraySetAsSeries(SSA,true);
   ArraySetAsSeries(SSB,true);
   
   //Manipulateur de ichimoku
   
   int iIchiKyo = iIchimoku(_Symbol,_Period,ichi_tenkan,ichi_kijun,ichi_SSB);
   
   //On copie les données des bandes de boullinger dans chaqu'une des tableaux correspondant à une de ces courbe.
   if(CopyBuffer(iIchiKyo,0,0,1,tenkan)>0 
      && CopyBuffer(iIchiKyo,1,0,1,kijun)>0 
      && CopyBuffer(iIchiKyo,2,-26,1,SSA)>0
      && CopyBuffer(iIchiKyo,3,-26,1,SSB)>0
      && CopyBuffer(iIchiKyo,4,0,1,chinkou)>0){
      
      array[0]=tenkan[0];
      array[1]=kijun[0];
      array[2]=SSA[0];
      array[3]=SSB[0];
      array[4]=chinkou[0];
   }
   else{
   
      array[0]=-1.0;
      array[1]=-1.0;
      array[2]=-1.0;  
      array[3]=-1.0; 
      array[4]=-1.0; 
   }
}