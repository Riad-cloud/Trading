//+------------------------------------------------------------------+
//|                                                 avalente_T&K.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#include <Trade\Trade.mqh>


ulong date_post_op[] = {0,0,0/*,0,0,0*/};

input group "Ichimoku";
input int ichi_tenkan=9;
input int ichi_kijun=26;
input int ichi_SSB=52;

string symboles[] = {"EURUSD", "EURJPY","EURNZD"/*,"GBPUSD","GBPJPY","GBPNZD","EURAUD","EURCAD","EURCHF","GBPAUD","GBPCAD","GBPCHF"*/};


void OnTick(){
      
   MqlDateTime now;
   TimeToStruct(TimeCurrent(), now);
   if(now.hour >= 8 && now.hour < 18){
      //boucle selectionnant 1 à 1 les symboles
      for(int i = 0; i < ArraySize(symboles); i += 1){
   
         if(date_post_op[i]<=(ulong)TimeCurrent() ){

            if(symbolGetPositionTotal(symboles[i]) < 1){//On regarde si il y a 1 position ouvert dans le symbo
               //Initialisation
               double ask = SymbolInfoDouble(symboles[i],SYMBOL_ASK);
               double bid = SymbolInfoDouble(symboles[i],SYMBOL_BID);
               double tenkan1=tenkan(_Period,1,symboles[i]);
               double tenkan2=tenkan(_Period,2,symboles[i]);
               double kijun1=kijun(_Period,1,symboles[i]);
               double kijun2=kijun(_Period,2,symboles[i]);
               double kijun3=kijun(_Period,3,symboles[i]);
               double kijun11=kijun(_Period,11,symboles[i]);
               double SSA= SSA(_Period,1,0,symboles[i]);
               double SSB= SSB(_Period,1,0,symboles[i]);
            
            
               if(tenkan1!=-1 && kijun1!=-1 && SSA!=-1 && SSB!=-1  )//si il n'y a pas eu d'errreur dans la fonction setIchimoku
               {
               //Condition d'achat'
                  if(tenkan1>kijun1 &&(kijun1>=SSA&&kijun1>=SSB)&&bougie_open(1,symboles[i])>=kijun1&&
                     (bougie_open(1,symboles[i])<=tenkan1||bougie_close(2,symboles[i])<=tenkan1)){
                     Avalante_haussier2(i,symboles[i]);

                  }
               //Condition de vente
                  else if( tenkan1<kijun1&&(kijun1<=SSA&&kijun1<=SSB)&&bougie_open(1,symboles[i])<=kijun1&&
                           (bougie_open(1,symboles[i])>=tenkan1||bougie_close(2,symboles[i])>=tenkan2)){
                  
                     Avalante_baissier2(i,symboles[i]);

               }
       
            }
         }
      }
   }
   
   }
      
}


///////////////////////////////////////tenkan///////////////////////////////////////////////////////////
double tenkan(ENUM_TIMEFRAMES period, int numtenkan,string SymbolName){
   
  //On crée des tableau vide pour pouvoir stocker nos données.
   double tenkan[]; 
   
   /*On défini chaqu'un des tableau comme une série temporel dons chaque élément sera classé par ordre décroissant du temps*/
   
   ArraySetAsSeries(tenkan,true);
   
   //Manipulateur de ichimoku
   
   int iIchiKyo = iIchimoku(SymbolName,period,ichi_tenkan,ichi_kijun,ichi_SSB);
   
   //On copie les données de tenkan dans chaqu'une des tableaux correspondant à une de ces courbe.
   if(CopyBuffer(iIchiKyo,0,0,3,tenkan)>0){
      
      return tenkan[numtenkan];
   }
   else{
      Print("Problème tenkan");
      return -1;
   }
   
}
double kijun(ENUM_TIMEFRAMES period, int numkijun,string SymbolName){
   
  //On crée des tableau vide pour pouvoir stocker nos données.
   double kijun[]; 
   
   /*On défini chaqu'un des tableau comme une série temporel dons chaque élément sera classé par ordre décroissant du temps*/
   
   ArraySetAsSeries(kijun,true);
   
   //Manipulateur de ichimoku
   
   int iIchiKyo = iIchimoku(SymbolName,period,ichi_tenkan,ichi_kijun,ichi_SSB);
   
   //On copie les données de tenkan dans chaqu'une des tableaux correspondant à une de ces courbe.
   if(CopyBuffer(iIchiKyo,1,0,12,kijun)>0){
      
      return kijun[numkijun];
   }
   else{
   Print("Problème kijun");
      return -1;
   }
   
}
double SSA(ENUM_TIMEFRAMES period, int numSSA,int shift,string SymbolName){
   
  //On crée des tableau vide pour pouvoir stocker nos données.
   double SSA[]; 
   
   /*On défini chaqu'un des tableau comme une série temporel dons chaque élément sera classé par ordre décroissant du temps*/
   
   ArraySetAsSeries(SSA,true);
   
   //Manipulateur de ichimoku
   
   int iIchiKyo = iIchimoku(SymbolName,period,ichi_tenkan,ichi_kijun,ichi_SSB);
   
   //On copie les données de tenkan dans chaqu'une des tableaux correspondant à une de ces courbe.
   if(CopyBuffer(iIchiKyo,2,shift,2,SSA)>0){
      
      return SSA[numSSA];
   }
   else{
   Print("Problème SSA");
      return -1;
   }
   
}
double SSB(ENUM_TIMEFRAMES period, int numSSB,int shift,string SymbolName){
   
  //On crée des tableau vide pour pouvoir stocker nos données.
   double SSB[]; 
   
   /*On défini chaqu'un des tableau comme une série temporel dons chaque élément sera classé par ordre décroissant du temps*/
   
   ArraySetAsSeries(SSB,true);
   
   //Manipulateur de ichimoku
   
   int iIchiKyo = iIchimoku(SymbolName,period,ichi_tenkan,ichi_kijun,ichi_SSB);
   
   //On copie les données de tenkan dans chaqu'une des tableaux correspondant à une de ces courbe.
   if(CopyBuffer(iIchiKyo,3,shift,2,SSB)>0){
      
      return SSB[numSSB];
   }
   else{
   Print("Problème SSB");
      return -1;
   }
   
}



////////////////////////////////Avalante après 3 bougie haussiere///////////////////////////////////////
void Avalante_haussier2(int i,string symbolName){
   CTrade trade;//objet qui sert à prendre position
   double ask = SymbolInfoDouble(symbolName,SYMBOL_ASK);//prix d'achat 
   
      bool avlacc=false;//variable représentant l'avalente d'accumulation
      if(bougie_open(3,symbolName)>=bougie_open(1,symbolName)&&
         bougie_open(3,symbolName)<=bougie_close(1,symbolName)&&
         bougie_open(4,symbolName)>=bougie_open(1,symbolName)&&
         bougie_open(4,symbolName)<=bougie_close(1,symbolName)){
         
         avlacc=true;
         }//On regarde si on une avalente d'accumulation
         
      double gm=bougie_close(1,symbolName)+(bougie_corps(1,symbolName));  
      if(bougie_close(1,symbolName)>bougie_open(1,symbolName)&&
         bougie_close(2,symbolName)<bougie_open(2,symbolName)&&
         bougie_corps(1,symbolName)>bougie_corps(2,symbolName)&&//pour éviter les gap
         bougie_close(1,symbolName)>bougie_open(2,symbolName)&&
         bougie_close(3,symbolName)<bougie_open(3,symbolName)&&
         bougie_close(4,symbolName)<bougie_open(4,symbolName))//avalente haussier
      {
         if(gm>bougie_high(1,symbolName)&&avlacc==false)
         {
            double stoploss= bougie_low(1,symbolName);
            double takeprofit= bougie_close(1,symbolName)+bougie_corps(1,symbolName);
            if(trade.Buy(0.10,symbolName,ask,stoploss,takeprofit)){
               
               date_post_op[i]= set_ope_bougie(symbolName);  

            }
         }

      }   
   
}
void Avalante_baissier2(int i,string symbolName){
   CTrade trade;//objet qui sert à prendre position
  
   double bid = SymbolInfoDouble(symbolName,SYMBOL_BID);//prix de vente
   
   bool avlacc=false;//variable représentant l'avalente d'accumulation
   
   if(bougie_open(3,symbolName)<=bougie_open(1,symbolName)&&
      bougie_open(3,symbolName)>=bougie_close(1,symbolName)&&
      bougie_open(4,symbolName)<=bougie_open(1,symbolName)&&
      bougie_open(4,symbolName)>=bougie_close(1,symbolName)){
      
      avlacc=true;
      }//On regarde si on une avalente d'accumulation
   
   double gm = bougie_close(1,symbolName)-bougie_corps(1,symbolName);
   if(bougie_close(1,symbolName)<bougie_open(1,symbolName)&&
      bougie_close(2,symbolName)>bougie_open(2,symbolName)&&
      bougie_corps(1,symbolName)>bougie_corps(2,symbolName)&&//pour éviter les gap
      bougie_close(1,symbolName)<bougie_open(2,symbolName)&&
      bougie_close(3,symbolName)>bougie_open(3,symbolName)&&
      bougie_close(4,symbolName)>bougie_open(4,symbolName))//avalente baissière
      {
      if(gm<bougie_low(1,symbolName)&&avlacc==false)
        {
            double stoploss= bougie_high(1,symbolName);
            double takeprofit= bougie_close(1,symbolName)-bougie_corps(1,symbolName);
            if(trade.Sell(0.10,symbolName,bid,stoploss,takeprofit)){
               
               date_post_op[i]= set_ope_bougie(symbolName);
            }
        }

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
               UT = (ulong)TimeCurrent() +3*(date2-date1);//contient 3 fois l'UT utilisé
         
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

////////////////////////////////////Bougie close/////////////////////////////////////

double bougie_close(int numChandel,string symbolName){
   MqlRates historyBuffer[];//Tableau de données
   //Faire de ce tableau une série temporel
    ArraySetAsSeries(historyBuffer,true);//Faire de ce tableau une série temporel
    double close= NULL;
    int tailleTab = numChandel+1;
   if(CopyRates(symbolName,_Period/*ou Period()ou encoredes pèriode personalysée*/,0,tailleTab,historyBuffer)){
      close = historyBuffer[numChandel].close;
      }
      return close;
}

///////////////////////////////////Bougie open////////////////////////////////////////

double bougie_open(int numChandel,string symbolName){
   MqlRates historyBuffer[];//Tableau de données
   //Faire de ce tableau une série temporel
    ArraySetAsSeries(historyBuffer,true);//Faire de ce tableau une série temporel
    double open= NULL;
    int tailleTab = numChandel+1;
    if(CopyRates(symbolName,_Period/*ou Period()ou encoredes pèriode personalysée*/,0,tailleTab,historyBuffer)){
      open = historyBuffer[numChandel].open;
    }
     return open;
}

/////////////////////////////////Bougie high/////////////////////////////////////////

double bougie_high(int numChandel,string symbolName){
   MqlRates historyBuffer[];//Tableau de données
   //Faire de ce tableau une série temporel
    ArraySetAsSeries(historyBuffer,true);//Faire de ce tableau une série temporel
    double high= NULL;
    int tailleTab = numChandel+1;
    if(CopyRates(symbolName,_Period/*ou Period()ou encoredes pèriode personalysée*/,0,tailleTab,historyBuffer)){
      high = historyBuffer[numChandel].high;
    }
    return high;
}

/////////////////////////////////Bougie low/////////////////////////////////////////

double bougie_low(int numChandel,string symbolName){
   MqlRates historyBuffer[];//Tableau de données
   //Faire de ce tableau une série temporel
   ArraySetAsSeries(historyBuffer,true);//Faire de ce tableau une série temporel
   double low= NULL;
   int tailleTab = numChandel+1;
   if(CopyRates(symbolName,_Period/*ou Period()ou encoredes pèriode personalysée*/,0,tailleTab,historyBuffer)){
      low = historyBuffer[numChandel].low;
   }
   return low;
}

/////////////////////////////////Bougie corps/////////////////////////////////////////

double bougie_corps(int numChandel,string symbolName){
   double corps=-1;
   if(bougie_open(numChandel,symbolName)>bougie_close(numChandel,symbolName)){
      corps = bougie_open(numChandel,symbolName)-bougie_close(numChandel,symbolName);
   }
   else
     {     
      corps = bougie_close(numChandel,symbolName)-bougie_open(numChandel,symbolName);
     }
   
   return corps;

}