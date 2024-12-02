//+------------------------------------------------------------------+
//|                                                 MoyBolSto1.0.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//Cette Stratégie utilise 4 indicateur technique
//Une Moyenne Mobile,Deux Bandes de Bollinger et Une Stochastique
//La Moyenne mobile sert à identifier la tendance, la stochastique et les bande de bolinger sert à trouver un point d'entrée
//Le dernière bande de bollanger sert de stop loss

#include <Trade\Trade.mqh>

//teste de l'ope_bougie
bool ope_bougie=false;
bool ope_bougie_sell=false;
bool ope_bougie_buy=false;

input group "Moyenne Mobile";
input int                  ma_period=200;                 // la période de la moyenne
input int                  ma_shift=0;                   // le décalage
input ENUM_MA_METHOD       ma_method=MODE_SMA;           // le type du lissage
input ENUM_APPLIED_PRICE   ma_applied_price=PRICE_CLOSE;    // le type du prix


input group "Bollinger";
input int                 bands_period = 20;      // période pour le calcul de la moyenne ligne
input int                 bands_shift = 0;       // décalage de l'indicateur à l'horizontale
input double              bands_deviation= 2;         // nombre de divergences standards(Il y a un bug dans le nom, j'ai du rajouté le 1)
input ENUM_APPLIED_PRICE  bands_applied_price= PRICE_CLOSE;      // type de prix ou le handle

input group "Bollinger2";
input int                 bands_period2 = 20;      // période pour le calcul de la moyenne ligne
input int                 bands_shift2 = 0;       // décalage de l'indicateur à l'horizontale
input double              bands_deviation2= 3;         // nombre de divergences standards 
input ENUM_APPLIED_PRICE  bands_applied_price2= PRICE_CLOSE;      // type de prix ou le handle

input group "Stochastic";
input int                  Kperiod=5;                 // la période K (le nombre de barres pour le calcul)
input int                  Dperiod=3;                 // la période D (la période du lissage primaire)
input int                  slowing=3;                 // la période du lissage définitif      
input ENUM_MA_METHOD       sto_method=MODE_SMA;        // le type du lissage  
input ENUM_STO_PRICE       price_field=STO_LOWHIGH;   // la méthode de calcul du stochastique


void OnTick(){
   if(ope_bougie==false){
      
      if(PositionsTotal()<1){
         start();
      }
   }
   else{
         set_ope_bougie();

         
   }
      
}
/////////////////Fonction start///////////////////////////
void start(){

   CTrade trade;
   //Initialisation Moyenne Mobile
   double MoyMobile=getMoyenneM();
   
   //Initialisation Bande de Bollinger 
   double bollingerBands[];
   setBollingerBands(bollingerBands);
   
   double MidBB = bollingerBands[0];
   double UpperBB = bollingerBands[1];
   double LowBB = bollingerBands[2];
   
   //Initialisation Bande de Bollinger 2 
   double bollingerBands2[];
   setBollingerBands2(bollingerBands2);
   
   double MidBB2 = bollingerBands2[0];
   double UpperBB2 = bollingerBands2[1];
   double LowBB2 = bollingerBands2[2];
   
   //Initialisation Stochastic
   double Stochastic[];
   SetStochastic(Stochastic);
   
   double K =Stochastic[0];
   double D = Stochastic[1];
   
   //Initialisation
   double ask = SymbolInfoDouble(_Symbol,SYMBOL_ASK);
   double bid = SymbolInfoDouble(_Symbol,SYMBOL_BID);
   
   if (MoyMobile!=-1 && LowBB && UpperBB!=-1 && K!=-1 ){//Si il n y a pas eu de problème lors de l'initialisation
      //Achat
   
      if(MoyMobile < ask && LowBB >= ask && K <=20 ){//Condition d'achat

         double StopBuy= ((ask - LowBB2)/(SymbolInfoDouble(_Symbol,SYMBOL_POINT)*10))+(SymbolInfoInteger(_Symbol,SYMBOL_SPREAD)*0.1);
         double volumeBuy = CalculatorPst(StopBuy,_Symbol);
         Print("Stop : "+(string)LowBB2);
         Print("Prix : "+(string)ask);
         Print("StopBuy:"+(string)StopBuy);
         Print("le volume est : " + (string)volumeBuy);
         Print("Spread:" + (string)SymbolInfoInteger(_Symbol,SYMBOL_SPREAD));
         
      
         if(trade.Buy(volumeBuy,_Symbol,ask,LowBB2,MidBB)){//On Achète
            int code = (int)trade.ResultRetcode();//Renvoie le code 10009 si Achat bien éffectuer
            ulong ticket = trade.ResultOrder();//id de la position en cours, si le trade ne ses pas réaliser le ticket sera à zero
            Print("Ticket:"+(string)ticket);
            ope_bougie=true;
            ope_bougie_buy=true;
         
            if(ticket == 0){
            
               Print("///////////Il y a eu un problème////////////");
               Print("Code:"+(string)code);
            
            }
         }
      }
   
      //Vente
      else if(MoyMobile > bid && UpperBB <= bid &&K >=81 ){//Condition de vente
      
         double StopSell=( (UpperBB2 - bid)/(SymbolInfoDouble(_Symbol,SYMBOL_POINT)*10))+(SymbolInfoInteger(_Symbol,SYMBOL_SPREAD)*0.1);
         double volumeSell = CalculatorPst(StopSell,_Symbol);
         Print("Stop : "+(string)UpperBB2);
         Print("Prix : "+(string)bid);
         Print("StopSell:"+(string)StopSell);
         Print("le volume est : " + (string)volumeSell);
         Print("Spread:" + (string)SymbolInfoInteger(_Symbol,SYMBOL_SPREAD));
         
         if(trade.Sell(volumeSell,_Symbol,bid,UpperBB2,MidBB)){//On Vend
         
            int Vcode = (int)trade.ResultRetcode();//Renvoie le code 10009 si Achat bien éffectuer
            ulong Vticket = trade.ResultOrder();//id de la position en cours, si le trade ne ses pas réaliser le ticket sera à zero
            Print("Ticket:"+(string)Vticket);
            ope_bougie=true;
            ope_bougie_sell=true;
         
            if(Vticket == 0){
            
               Print("///////////Il y a eu un problème////////////");
               Print("Code:"+(string)Vcode);
            
            }
         
         }
      
      }
      
   }

}

//////////////////////////Fonction operation////////////////////////////////////////////////////////
//Cette fonction va nous permettre de ne pas prendre plusieurs position perdante dans une bougie qui a déja un trade perdant.
void set_ope_bougie(){
   
   double bollingerBands[];
   setBollingerBands(bollingerBands);
   double MidBB = bollingerBands[0];
   double ask = SymbolInfoDouble(_Symbol,SYMBOL_ASK);
   double bid = SymbolInfoDouble(_Symbol,SYMBOL_BID);
   
   if(ope_bougie_buy==true){
   
      if(MidBB<=ask){
      
         ope_bougie=false;
         ope_bougie_buy=false;
      }
      
   }
   if(ope_bougie_sell==true){
   
      if(MidBB>=bid){
      
         ope_bougie=false;
         ope_bougie_sell=false;
      }
      
   }
     
   
}
//////////////////////////Fonction de la Moyenne mobile 200/////////////////////////////////////////
double getMoyenneM(){
   
   double MoyMBuffer[];
   
   ArraySetAsSeries(MoyMBuffer,true);
   
   //On met la valeur du Rsi paramétrer dans la variable rsi
   int MoyMob = iMA(_Symbol,_Period,ma_period,ma_shift,ma_method,ma_applied_price);
   
   //On copie le moyenne mobile dans le tableau avec Copie buffer
   
   if(CopyBuffer(MoyMob,0,0,1,MoyMBuffer)>0){
      return MoyMBuffer[0];
   
   }
   else{
       PrintFormat("On n'a pas réussi à copier les données de l'indicateur Moyenne mobile, le code de l'erreur %d",GetLastError());
       return -1;
   }
}

//////////////////////////Fonction du premier Bollinger/////////////////////////////////////////
void setBollingerBands(double & array[]){

   //On redimenssione le tableau pour qu'il est est une taille de trois pour pouvoir stocker les bande de bollinger
   ArrayResize(array,3);
   
  //On crée des tableau vide pour pouvoir stocker nos données.
   double middleBuffer[];
   double upperBuffer[];
   double lowerBuffer[];
   
   /*On défini chaqu'un des tableau comme une série temporel dons chaque élément sera classé par ordre décroissant du temps*/
   
   ArraySetAsSeries(middleBuffer,true);
   ArraySetAsSeries(upperBuffer,true);
   ArraySetAsSeries(lowerBuffer,true);
   
   //Manipulateur des bande de bollinger
   
   int iBolBands = iBands(_Symbol,_Period,bands_period,bands_shift,bands_deviation,bands_applied_price);
   
   //On copie les données des bandes de boullinger dans chaqu'une des tableaux correspondant à une de ces courbe.
   if(CopyBuffer(iBolBands,0,0,1,middleBuffer)>0 
      && CopyBuffer(iBolBands,1,0,1,upperBuffer)>0 
      && CopyBuffer(iBolBands,2,0,1,lowerBuffer)>0){
      
      array[0]=middleBuffer[0];
      array[1]=upperBuffer[0];
      array[2]=lowerBuffer[0];
   }
   else{
   
      array[0]=-1.0;
      array[1]=-1.0;
      array[2]=-1.0;  
   }
}

//////////////////////////Fonction du deuxieme Bollinger/////////////////////////////////////////
void setBollingerBands2(double & array[]){

   //On redimenssione le tableau pour qu'il est est une taille de trois pour pouvoir stocker les bande de bollinger
   ArrayResize(array,3);
   
  //On crée des tableau vide pour pouvoir stocker nos données.
   double middleBuffer[];
   double upperBuffer[];
   double lowerBuffer[];
   
   /*On défini chaqu'un des tableau comme une série temporel dons chaque élément sera classé par ordre décroissant du temps*/
   
   ArraySetAsSeries(middleBuffer,true);
   ArraySetAsSeries(upperBuffer,true);
   ArraySetAsSeries(lowerBuffer,true);
   
   //Manipulateur des bande de bollinger
   
   int iBolBands = iBands(_Symbol,_Period,bands_period2,bands_shift2,bands_deviation2,bands_applied_price2);
   
   //On copie les données des bandes de boullinger dans chaqu'une des tableaux correspondant à une de ces courbe.
   if(CopyBuffer(iBolBands,0,0,1,middleBuffer)>0 
      && CopyBuffer(iBolBands,1,0,1,upperBuffer)>0 
      && CopyBuffer(iBolBands,2,0,1,lowerBuffer)>0){
      
      array[0]=middleBuffer[0];
      array[1]=upperBuffer[0];
      array[2]=lowerBuffer[0];
   }
   else{
   
      array[0]=-1.0;
      array[1]=-1.0;
      array[2]=-1.0;  
   }
}

//////////////////////////Fonction de la Stochastic/////////////////////////////////////////
void SetStochastic(double & array[]){

   //On redimenssione le tableau pour qu'il est est une taille de deux pour pouvoir stocker les deux courbe du stochastic
   ArrayResize(array,2);
   
  //On crée des tableau vide pour pouvoir stocker nos données.
   double K[];
   double D[];

   
   /*On défini chaqu'un des tableau comme une série temporel dons chaque élément sera classé par ordre décroissant du temps*/
   
   ArraySetAsSeries(K,true);
   ArraySetAsSeries(D,true);
   
   //Manipulateur des bande de bollinger
   
   int iSto = iStochastic(_Symbol,_Period,Kperiod,Dperiod,slowing,sto_method,price_field);
   
   //On copie les données des bandes de boullinger dans chaqu'une des tableaux correspondant à une de ces courbe.
   if(CopyBuffer(iSto,0,0,1,K)>0 
      && CopyBuffer(iSto,1,0,1,D)>0 ){
      
      array[0]=K[0];
      array[1]=D[0];
   }
   else{
   
      array[0]=-1.0;
      array[1]=-1.0;

   }
}

///////////////////////////Calculatrice//////////////////////////////////////////////
double CalculatorPst(double StopPip,string Symbole){
   int capital=20000;
   float Riskpourcent=1;
   double Risk=capital*(Riskpourcent/100);
   if(Getvalpip(Symbole)==0)
   {
      return 0;
   }
   double Position = Risk/StopPip/Getvalpip(Symbole);
   double Volume = floor((Position*100))/100;
   Print("P : "+(string)Position);
   return Volume;
}

float Getvalpip(string Symbole){
   float val_pip=0;//Valeur de pip selon notre devise de compte
   
   string PConversion="";//Paire qu'on utilise pour convertir les pips de la devise
   
   bool is_custom=false;//Paramètre de la fonction SymbolExist pour savoir si on utilise une paire personnalisé
   
   string Dcompte=AccountInfoString(ACCOUNT_CURRENCY);//devise du compte
   
   string Dcotation=StringSubstr(Symbole,3);//Devise de cotation de la paire trader  
    
   Print("Devise du compte = " + Dcompte);//test bug Dcompte
   
   Print("devise de cotation = " + Dcotation);//test bug Dcotation
   
   string Symbole1 = Dcotation+Dcompte;
   
   string Symbole2 =Dcompte + Dcotation;
   
   //Print("Symbole1 = " + Symbole1);//test bug Symbole1
   
   //Print("Symbole2 = " + Symbole2);//test bug Symbole 2
   if(Dcompte==Dcotation){
      Print("Bon");//Test bug
      val_pip=10.00;
   }
   
   else if(SymbolExist(Symbole1,is_custom)){
     PConversion=Symbole1;
     
     //Print("La paire de conversion = " + PConversion);//test bug Pconversion
      if(SymbolInfoDouble(PConversion,SYMBOL_POINT)==0.00001)
      {
         val_pip=10*SymbolInfoDouble(PConversion,SYMBOL_BID);
      }
      else
      {
         val_pip=10*SymbolInfoDouble(PConversion,SYMBOL_BID)*100;
      }
     
   }
   else if(SymbolExist(Symbole2,is_custom)){
   
      PConversion=Symbole2;

      //Print("La paire de conversion = " + PConversion);//test bug Pconversion
      if(SymbolInfoDouble(PConversion,SYMBOL_POINT)==0.00001)
      {
         val_pip=10/SymbolInfoDouble(PConversion,SYMBOL_BID);
      }
      else
      {
         val_pip=10/SymbolInfoDouble(PConversion,SYMBOL_BID)*100;

      }
   }
   
   Print("valeur du pip = "+ (string)val_pip);
   //Comment(val_pip);
   return val_pip;
}
