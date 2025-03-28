//+------------------------------------------------------------------+
//|                                                étoile_m&s_tk.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//test avec avalente avec 2 bougie et etoile du matin et soir rebond sur des kijun plate et SSB plate
#include <Trade\Trade.mqh>

ulong date_post_op = 0;

input group "Ichimoku";
input int ichi_tenkan=9;
input int ichi_kijun=26;
input int ichi_SSB=52;


void OnTick(){
      
   MqlDateTime now;
   TimeToStruct(TimeCurrent(), now);
   if(now.hour >= 8 && now.hour < 18){
      if(date_post_op<=(ulong)TimeCurrent() ){

         if(PositionsTotal()<1){
           //Initialisation
            double ask = SymbolInfoDouble(_Symbol,SYMBOL_ASK);
            double bid = SymbolInfoDouble(_Symbol,SYMBOL_BID);
            double tenkan=tenkan(PERIOD_H1,1);
            double kijun1=kijun(PERIOD_H1,1);
            double kijun2=kijun(PERIOD_H1,2);
            double kijun3=kijun(PERIOD_H1,3);
            double SSA= SSA(PERIOD_H1,1,0);
            double SSB= SSB(PERIOD_H1,1,0);
            


            
            
            
            if(tenkan!=-1 && kijun1!=-1 && SSA!=-1 && SSB!=-1 &&kijun2==kijun3 )//si il n'y a pas eu d'errreur dans la fonction setIchimoku
            {
            //Condition d'achat'
               if(tenkan>kijun1 &&(kijun1>=SSA&&kijun1>=SSB)&&bougie_high(1)>=kijun1&&
               (bougie_low(1)<=kijun1||bougie_low(2)<=kijun2||bougie_low(3)<=kijun3)){
               etoile_du_matin();
               }
               
            //Condition de vente
               else if( tenkan<=kijun1&&(kijun1<=SSA&&kijun1<=SSB)&&bougie_low(1)<=kijun1&&
               (kijun1 <= bougie_high(1)||kijun2 <= bougie_high(2)||kijun3 <= bougie_high(3))){
               etoile_du_soir();
               }
       
            }
         }
      }
   }

      
}


///////////////////////////////////////tenkan///////////////////////////////////////////////////////////
double tenkan(ENUM_TIMEFRAMES period, int numtenkan){
   
  //On crée des tableau vide pour pouvoir stocker nos données.
   double tenkan[]; 
   
   /*On défini chaqu'un des tableau comme une série temporel dons chaque élément sera classé par ordre décroissant du temps*/
   
   ArraySetAsSeries(tenkan,true);
   
   //Manipulateur de ichimoku
   
   int iIchiKyo = iIchimoku(_Symbol,period,ichi_tenkan,ichi_kijun,ichi_SSB);
   
   //On copie les données de tenkan dans chaqu'une des tableaux correspondant à une de ces courbe.
   if(CopyBuffer(iIchiKyo,0,0,2,tenkan)>0){
      
      return tenkan[numtenkan];
   }
   else{
      Print("Problème tenkan");
      return -1;
   }
   
}
double kijun(ENUM_TIMEFRAMES period, int numkijun){
   
  //On crée des tableau vide pour pouvoir stocker nos données.
   double kijun[]; 
   
   /*On défini chaqu'un des tableau comme une série temporel dons chaque élément sera classé par ordre décroissant du temps*/
   
   ArraySetAsSeries(kijun,true);
   
   //Manipulateur de ichimoku
   
   int iIchiKyo = iIchimoku(_Symbol,period,ichi_tenkan,ichi_kijun,ichi_SSB);
   
   //On copie les données de tenkan dans chaqu'une des tableaux correspondant à une de ces courbe.
   if(CopyBuffer(iIchiKyo,1,0,5,kijun)>0){
      
      return kijun[numkijun];
   }
   else{
   Print("Problème kijun");
      return -1;
   }
   
}
double SSA(ENUM_TIMEFRAMES period, int numSSA,int shift){
   
  //On crée des tableau vide pour pouvoir stocker nos données.
   double SSA[]; 
   
   /*On défini chaqu'un des tableau comme une série temporel dons chaque élément sera classé par ordre décroissant du temps*/
   
   ArraySetAsSeries(SSA,true);
   
   //Manipulateur de ichimoku
   
   int iIchiKyo = iIchimoku(_Symbol,period,ichi_tenkan,ichi_kijun,ichi_SSB);
   
   //On copie les données de tenkan dans chaqu'une des tableaux correspondant à une de ces courbe.
   if(CopyBuffer(iIchiKyo,2,shift,2,SSA)>0){
      
      return SSA[numSSA];
   }
   else{
   Print("Problème SSA");
      return -1;
   }
   
}
double SSB(ENUM_TIMEFRAMES period, int numSSB,int shift){
   
  //On crée des tableau vide pour pouvoir stocker nos données.
   double SSB[]; 
   
   /*On défini chaqu'un des tableau comme une série temporel dons chaque élément sera classé par ordre décroissant du temps*/
   
   ArraySetAsSeries(SSB,true);
   
   //Manipulateur de ichimoku
   
   int iIchiKyo = iIchimoku(_Symbol,period,ichi_tenkan,ichi_kijun,ichi_SSB);
   
   //On copie les données de tenkan dans chaqu'une des tableaux correspondant à une de ces courbe.
   if(CopyBuffer(iIchiKyo,3,shift,2,SSB)>0){
      
      return SSB[numSSB];
   }
   else{
   Print("Problème SSB");
      return -1;
   }
   
}



/////////////////////////////Etoile/////////////////////////////////////////////////////////////////
void etoile_du_matin(){
   CTrade trade;//objet qui sert à prendre position
   double ask = SymbolInfoDouble(_Symbol,SYMBOL_ASK);//prix d'achat 
   
   
   if(bougie_close(1)>bougie_open(1) && bougie_close(3)<bougie_open(3)&&
      bougie_corps(3)> (bougie_corps(2) * 2) && 
      bougie_corps(1) > (bougie_corps(2) * 2)){
      
         double stoploss= bougie_low(2);
         double takeprofit= bougie_close(1)+bougie_corps(1);
         if(trade.Buy(0.10,_Symbol,ask,stoploss,takeprofit)){
               
            date_post_op= set_ope_bougie();  

         }
      
      }
           
}
void etoile_du_soir(){
   CTrade trade;//objet qui sert à prendre position
   double ask = SymbolInfoDouble(_Symbol,SYMBOL_ASK);//prix d'achat 
   double bid = SymbolInfoDouble(_Symbol,SYMBOL_BID);//prix de vente
   
   if(bougie_close(1)<bougie_open(1) && bougie_close(3)>bougie_open(3)&&
      bougie_corps(3)> (bougie_corps(2) * 2) && 
      bougie_corps(1) > (bougie_corps(2) * 2)){
         
         double stoploss= bougie_high(2);
         double takeprofit= bougie_close(1)-bougie_corps(1);
         if(trade.Sell(0.10,_Symbol,bid,stoploss,takeprofit)){
               
            date_post_op= set_ope_bougie();
         }  
         
      }
   
}

//////////////////////////Fonction operation////////////////////////////////////////////////////////
//Cette fonction va nous permettre de ne pas prendre plusieurs position perdante dans une bougie qui a déja un trade perdant.
ulong set_ope_bougie(){
   
   MqlRates historyBuffer[];//tableaux contenant les données de bougie
   
   ArraySetAsSeries(historyBuffer,true);//Indexe le tableau dans le sens du plus récent ou plus anciens
   ulong UT = 0;//variable qui va être implémenté du délai avant lequel on peu reprendre une position
   if(CopyRates(_Symbol,_Period,0,3,historyBuffer)){
               ulong date1 = (ulong)historyBuffer[2].time;
               ulong date2 = (ulong)historyBuffer[1].time;
               UT = (ulong)TimeCurrent() +3*(date2-date1);//contient 3 fois l'UT utilisé
         
}
   return UT;//retourne la valeur de UT
}

////////////////////////////////////Bougie close///////////////////////////////

double bougie_close(int numChandel){
   MqlRates historyBuffer[];//Tableau de données
   //Faire de ce tableau une série temporel
    ArraySetAsSeries(historyBuffer,true);//Faire de ce tableau une série temporel
    double close= NULL;
    int tailleTab = numChandel+1;
   if(CopyRates(_Symbol,_Period/*ou Period()ou encoredes pèriode personalysée*/,0,tailleTab,historyBuffer)){
      close = historyBuffer[numChandel].close;
      }
      return close;
}




double bougie_open(int numChandel){
   MqlRates historyBuffer[];//Tableau de données
   //Faire de ce tableau une série temporel
    ArraySetAsSeries(historyBuffer,true);//Faire de ce tableau une série temporel
    double open= NULL;
    int tailleTab = numChandel+1;
    if(CopyRates(_Symbol,_Period/*ou Period()ou encoredes pèriode personalysée*/,0,tailleTab,historyBuffer)){
      open = historyBuffer[numChandel].open;
    }
     return open;
}
double bougie_high(int numChandel){
   MqlRates historyBuffer[];//Tableau de données
   //Faire de ce tableau une série temporel
    ArraySetAsSeries(historyBuffer,true);//Faire de ce tableau une série temporel
    double high= NULL;
    int tailleTab = numChandel+1;
    if(CopyRates(_Symbol,_Period/*ou Period()ou encoredes pèriode personalysée*/,0,tailleTab,historyBuffer)){
      high = historyBuffer[numChandel].high;
    }
    return high;
}
double bougie_low(int numChandel){
   MqlRates historyBuffer[];//Tableau de données
   //Faire de ce tableau une série temporel
   ArraySetAsSeries(historyBuffer,true);//Faire de ce tableau une série temporel
   double low= NULL;
   int tailleTab = numChandel+1;
   if(CopyRates(_Symbol,_Period/*ou Period()ou encoredes pèriode personalysée*/,0,tailleTab,historyBuffer)){
      low = historyBuffer[numChandel].low;
   }
   return low;
}
double bougie_corps(int numChandel){
   double corps=-1;
   if(bougie_open(numChandel)>bougie_close(numChandel)){
      corps = bougie_open(numChandel)-bougie_close(numChandel);
   }
   else
     {     
      corps = bougie_close(numChandel)-bougie_open(numChandel);
     }
   
   return corps;

}