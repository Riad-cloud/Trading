//+------------------------------------------------------------------+
//|                                                    indicator.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
/*Dans ce programme on va voir comment mettre et utilisé dans notre programme un indicateur technique
pour faire un dans un robot de trading*/



void OnTick(){
   
   Print("RSI:" +(string)getRsi());
   
   double bollingerBands[];
   setBollingerBands(bollingerBands);
   
   Print("Middle Bollinger Bands" +(string)bollingerBands[0]);
   Print("Upper Bollinger Bands" +(string)bollingerBands[1]);
   Print("Lower Bollinger Bands" +(string)bollingerBands[2]);
   

}
double getRsi(){
   
   double rsiBuffer[];
   
   ArraySetAsSeries(rsiBuffer,true);
   
   //On met la valeur du Rsi paramétrer dans la variable rsi
   int rsi = iRSI(_Symbol,_Period,20,PRICE_CLOSE);
   
   //On copie le rsi dans le tableau avec Copie buffer
   /*CopyBuffer prend 5 argument le premier est le manipulateur de l'indicateur
   Le deuxième est l'index de la courbe a récupéré comme on a qu'une courbe alors on met 0
   le troisième est à partir de quand on veut récupérer nos données donc comme on veut le plus récent donc le RSI qui est à l'indexe 0
   Le quatrième est le nombre de valeur qu'on souhaite récupérer
   Le cinquième est le tableau ou on vas copier ces données
   La fonction copyBuffer retourne un nombre entier, elle retourne -1 si il y a eu un problème ou sinon elle retourne le nombre de données copié*/
   
   if(CopyBuffer(rsi,0,0,1,rsiBuffer)>0){
      return rsiBuffer[0];
   
   }
   else{
       PrintFormat("On n'a pas réussi à copier les données de l'indicateur iRSI, le code de l'erreur %d",GetLastError());
       return -1;
   }
}

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
   
   int iBolBands = iBands(_Symbol,_Period,20,0,2,PRICE_CLOSE);
   
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