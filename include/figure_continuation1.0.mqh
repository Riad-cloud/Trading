//+------------------------------------------------------------------+
//|                                       figure_continuation1.0.mqh |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#include <Riad\Candle.mqh>
#include <Riad/Ichimoku.mqh>
#include <Trade\Trade.mqh>

bool _3methode_ascendante(string symbolName,ENUM_TIMEFRAMES Period){

   double lower=getlowerCandle(symbolName,Period,4,9);
   double meche1=bougie_meche_H(1,symbolName,Period)*2;
   double meche4=bougie_meche_H(4,symbolName,Period)*2;
   if(bougie_close(4,symbolName,Period)>bougie_open(4,symbolName,Period)&&
      bougie_close(1,symbolName,Period)>bougie_open(1,symbolName,Period)&&
      bougie_high(4,symbolName,Period)>=bougie_high(3,symbolName,Period)&&
      bougie_high(4,symbolName,Period)>=bougie_high(2,symbolName,Period)&&
      bougie_corps(4,symbolName,Period)>bougie_corps(2,symbolName,Period)&&
      bougie_corps(4,symbolName,Period)>bougie_corps(3,symbolName,Period)&&
      bougie_corps(1,symbolName,Period)>bougie_corps(2,symbolName,Period)&&
      bougie_corps(1,symbolName,Period)>bougie_corps(3,symbolName,Period)&&
      bougie_low(4,symbolName,Period)<=bougie_low(3,symbolName,Period)&&
      bougie_low(4,symbolName,Period)<=bougie_low(2,symbolName,Period)&&
      bougie_close(1,symbolName,Period)>bougie_high(4,symbolName,Period)&&
      lower!=bougie_open(4,symbolName,Period)&&
      meche1<=bougie_corps(1,symbolName,Period)&&
      meche4<=bougie_corps(4,symbolName,Period))//porte drapeau
      {
         string content = "3 méthode ascendante à 2 bougie sur la paire :"+(string)symbolName;
   
         if(!SendNotification(content))
         {
            Print(content);
         }
         return true;

      }
      return false;   
   
}
bool _3methodedescendante(string symbolName,ENUM_TIMEFRAMES Period){

   double higher=getHigherCandle(symbolName,Period,4,9);
   double meche1=bougie_meche_B(1,symbolName,Period)*2;
   double meche4=bougie_meche_B(4,symbolName,Period)*2;
   if(bougie_close(4,symbolName,Period)<bougie_open(4,symbolName,Period)&&
      bougie_close(1,symbolName,Period)<bougie_open(1,symbolName,Period)&&
      bougie_high(4,symbolName,Period)>=bougie_high(3,symbolName,Period)&&
      bougie_high(4,symbolName,Period)>=bougie_high(2,symbolName,Period)&&
      bougie_corps(4,symbolName,Period)>bougie_corps(2,symbolName,Period)&&
      bougie_corps(4,symbolName,Period)>bougie_corps(3,symbolName,Period)&&
      bougie_corps(1,symbolName,Period)>bougie_corps(2,symbolName,Period)&&
      bougie_corps(1,symbolName,Period)>bougie_corps(3,symbolName,Period)&&
      bougie_low(4,symbolName,Period)<=bougie_low(3,symbolName,Period)&&
      bougie_low(4,symbolName,Period)<=bougie_low(2,symbolName,Period)&&
      bougie_close(1,symbolName,Period)<bougie_low(4,symbolName,Period)&&
      higher!=bougie_open(4,symbolName,Period)&&
      meche1<=bougie_corps(1,symbolName,Period)&&
      meche4<=bougie_corps(4,symbolName,Period))//porte drapeau
      {
         string content = "3 méthode descendante à 2 bougie sur la paire :"+(string)symbolName+" en :"+(string)Period;
   
         if(!SendNotification(content))
         {
            Print(content);
         }
         return true;   
      } 
      return false;        
}

////////////////////////////////////////3 méthode asendanten 3 bougie////////////////////////////////////////////////////

bool _3methode_ascendante3b(string symbolName,ENUM_TIMEFRAMES Period){

   double lower=getlowerCandle(symbolName,Period,5,9);
   double meche1=bougie_meche_H(1,symbolName,Period)*2;
   double meche5=bougie_meche_H(5,symbolName,Period)*2;
   if(bougie_close(5,symbolName,Period)>bougie_open(5,symbolName,Period)&&
      bougie_close(1,symbolName,Period)>bougie_open(1,symbolName,Period)&&
      bougie_high(5,symbolName,Period)>=bougie_high(4,symbolName,Period)&&
      bougie_high(5,symbolName,Period)>=bougie_high(3,symbolName,Period)&&
      bougie_high(5,symbolName,Period)>=bougie_high(2,symbolName,Period)&&
      bougie_low(5,symbolName,Period)<=bougie_low(4,symbolName,Period)&&
      bougie_low(5,symbolName,Period)<=bougie_low(3,symbolName,Period)&&
      bougie_low(5,symbolName,Period)<=bougie_low(2,symbolName,Period)&&
      bougie_corps(5,symbolName,Period)>bougie_corps(2,symbolName,Period)&&
      bougie_corps(5,symbolName,Period)>bougie_corps(3,symbolName,Period)&&
      bougie_corps(5,symbolName,Period)>bougie_corps(4,symbolName,Period)&&
      bougie_corps(1,symbolName,Period)>bougie_corps(2,symbolName,Period)&&
      bougie_corps(1,symbolName,Period)>bougie_corps(3,symbolName,Period)&&
      bougie_corps(1,symbolName,Period)>bougie_corps(4,symbolName,Period)&&
      bougie_close(1,symbolName,Period)>bougie_high(5,symbolName,Period)&&
      lower!=bougie_open(5,symbolName,Period)&&
      meche1<=bougie_corps(1,symbolName,Period)&&
      meche5<=bougie_corps(5,symbolName,Period))//porte drapeau
      {
         string content = "3 méthode ascendante à 3 bougie sur la paire :"+(string)symbolName+" en :"+(string)Period;
   
         if(!SendNotification(content))
         {
            Print(content);
         }
         return true;
        

      }
      
      return false;   
   
}
bool _3methodedescendante3b(string symbolName,ENUM_TIMEFRAMES Period){
 
   double higher=getHigherCandle(symbolName,Period,5,9);
   double meche1=bougie_meche_B(1,symbolName,Period)*2;
   double meche5=bougie_meche_B(5,symbolName,Period)*2;
   if(bougie_close(5,symbolName,Period)<bougie_open(5,symbolName,Period)&&
      bougie_close(1,symbolName,Period)<bougie_open(1,symbolName,Period)&&
      bougie_high(5,symbolName,Period)>=bougie_high(4,symbolName,Period)&&
      bougie_high(5,symbolName,Period)>=bougie_high(3,symbolName,Period)&&
      bougie_high(5,symbolName,Period)>=bougie_high(2,symbolName,Period)&&
      bougie_low(5,symbolName,Period)<=bougie_low(4,symbolName,Period)&&
      bougie_low(5,symbolName,Period)<=bougie_low(3,symbolName,Period)&&
      bougie_low(5,symbolName,Period)<=bougie_low(2,symbolName,Period)&&
      bougie_corps(5,symbolName,Period)>bougie_corps(2,symbolName,Period)&&
      bougie_corps(5,symbolName,Period)>bougie_corps(3,symbolName,Period)&&
      bougie_corps(5,symbolName,Period)>bougie_corps(4,symbolName,Period)&&
      bougie_corps(1,symbolName,Period)>bougie_corps(2,symbolName,Period)&&
      bougie_corps(1,symbolName,Period)>bougie_corps(3,symbolName,Period)&&
      bougie_corps(1,symbolName,Period)>bougie_corps(4,symbolName,Period)&&
      bougie_close(1,symbolName,Period)<bougie_low(5,symbolName,Period)&&
      higher!=bougie_open(5,symbolName,Period)&&
      meche1<=bougie_corps(1,symbolName,Period)&&
      meche5<=bougie_corps(5,symbolName,Period))//porte drapeau
      {
         string content = "3 méthode descendante à 3 bougie sur la paire :"+(string)symbolName+" en :"+(string)Period;
   
         if(!SendNotification(content))
         {
            Print(content);
         }
         return true;    
       
      }
      return false;         
}
////////////////////////////////////////3 méthode ascendante en 4 bougie////////////////////////////////////////////////////

bool _3methode_ascendante4b(string symbolName,ENUM_TIMEFRAMES Period){

   double lower=getlowerCandle(symbolName,Period,6,9);
   double meche1=bougie_meche_H(1,symbolName,Period)*2;
   double meche6=bougie_meche_H(6,symbolName,Period)*2;
   if(bougie_close(6,symbolName,Period)>bougie_open(6,symbolName,Period)&&
      bougie_close(1,symbolName,Period)>bougie_open(1,symbolName,Period)&&
      bougie_high(6,symbolName,Period)>=bougie_high(5,symbolName,Period)&&
      bougie_high(6,symbolName,Period)>=bougie_high(4,symbolName,Period)&&
      bougie_high(6,symbolName,Period)>=bougie_high(3,symbolName,Period)&&
      bougie_high(6,symbolName,Period)>=bougie_high(2,symbolName,Period)&&
      bougie_low(6,symbolName,Period)<=bougie_low(5,symbolName,Period)&&
      bougie_low(6,symbolName,Period)<=bougie_low(4,symbolName,Period)&&
      bougie_low(6,symbolName,Period)<=bougie_low(3,symbolName,Period)&&
      bougie_low(6,symbolName,Period)<=bougie_low(2,symbolName,Period)&&
      bougie_corps(6,symbolName,Period)>bougie_corps(2,symbolName,Period)&&
      bougie_corps(6,symbolName,Period)>bougie_corps(3,symbolName,Period)&&
      bougie_corps(6,symbolName,Period)>bougie_corps(4,symbolName,Period)&&
      bougie_corps(6,symbolName,Period)>bougie_corps(5,symbolName,Period)&&
      bougie_corps(1,symbolName,Period)>bougie_corps(2,symbolName,Period)&&
      bougie_corps(1,symbolName,Period)>bougie_corps(3,symbolName,Period)&&
      bougie_corps(1,symbolName,Period)>bougie_corps(4,symbolName,Period)&&
      bougie_corps(1,symbolName,Period)>bougie_corps(5,symbolName,Period)&&
      bougie_close(1,symbolName,Period)>bougie_high(6,symbolName,Period)&&
      lower!=bougie_open(6,symbolName,Period)&&
      meche1<=bougie_corps(1,symbolName,Period)&&
      meche6<=bougie_corps(6,symbolName,Period))//porte drapeau
      {

         string content = "3 méthode ascendante à 4 bougie sur la paire :"+(string)symbolName+" en :"+(string)Period;
   
         if(!SendNotification(content))
         {
            Print(content);
         }
         return true;
         
      }
      return false;   
   
}
bool _3methodedescendante4b(string symbolName,ENUM_TIMEFRAMES Period){
  
   double higher=getHigherCandle(symbolName,Period,6,9);  
   double meche1=bougie_meche_B(1,symbolName,Period)*2;
   double meche6=bougie_meche_B(6,symbolName,Period)*2;
   if(bougie_close(6,symbolName,Period)<bougie_open(6,symbolName,Period)&&
      bougie_close(1,symbolName,Period)<bougie_open(1,symbolName,Period)&&
      bougie_high(6,symbolName,Period)>=bougie_high(5,symbolName,Period)&&
      bougie_high(6,symbolName,Period)>=bougie_high(4,symbolName,Period)&&
      bougie_high(6,symbolName,Period)>=bougie_high(3,symbolName,Period)&&
      bougie_high(6,symbolName,Period)>=bougie_high(2,symbolName,Period)&&
      bougie_low(6,symbolName,Period)<=bougie_low(5,symbolName,Period)&&
      bougie_low(6,symbolName,Period)<=bougie_low(4,symbolName,Period)&&
      bougie_low(6,symbolName,Period)<=bougie_low(3,symbolName,Period)&&
      bougie_low(6,symbolName,Period)<=bougie_low(2,symbolName,Period)&&
      bougie_corps(6,symbolName,Period)>bougie_corps(2,symbolName,Period)&&
      bougie_corps(6,symbolName,Period)>bougie_corps(3,symbolName,Period)&&
      bougie_corps(6,symbolName,Period)>bougie_corps(4,symbolName,Period)&&
      bougie_corps(6,symbolName,Period)>bougie_corps(5,symbolName,Period)&&
      bougie_corps(1,symbolName,Period)>bougie_corps(2,symbolName,Period)&&
      bougie_corps(1,symbolName,Period)>bougie_corps(3,symbolName,Period)&&
      bougie_corps(1,symbolName,Period)>bougie_corps(4,symbolName,Period)&&
      bougie_corps(1,symbolName,Period)>bougie_corps(5,symbolName,Period)&&
      bougie_close(1,symbolName,Period)<bougie_low(6,symbolName,Period)&&
      higher!=bougie_open(6,symbolName,Period)&&
      meche1<=bougie_corps(1,symbolName,Period)&&
      meche6<=bougie_corps(6,symbolName,Period))//porte drapeau
      {

         string content = "3 méthode descendante à 4 bougie sur la paire :"+(string)symbolName+" en :"+(string)Period;
   
         if(!SendNotification(content))
         {
            Print(content);
         }
         return true;    
           
      }
      return false;         
}
////////////////////////////////////////3 méthode asendanten 5 bougie////////////////////////////////////////////////////

bool _3methode_ascendante5b(string symbolName,ENUM_TIMEFRAMES Period){
   
   double lower=getlowerCandle(symbolName,Period,7,9);
   double meche1=bougie_meche_H(1,symbolName,Period)*2;
   double meche7=bougie_meche_H(7,symbolName,Period)*2;
   if(bougie_close(7,symbolName,Period)>bougie_open(7,symbolName,Period)&&
      bougie_close(1,symbolName,Period)>bougie_open(1,symbolName,Period)&&
      bougie_high(7,symbolName,Period)>=bougie_high(6,symbolName,Period)&&
      bougie_high(7,symbolName,Period)>=bougie_high(5,symbolName,Period)&&
      bougie_high(7,symbolName,Period)>=bougie_high(4,symbolName,Period)&&
      bougie_high(7,symbolName,Period)>=bougie_high(3,symbolName,Period)&&
      bougie_high(7,symbolName,Period)>=bougie_high(2,symbolName,Period)&&
      bougie_low(7,symbolName,Period)<=bougie_low(6,symbolName,Period)&&
      bougie_low(7,symbolName,Period)<=bougie_low(5,symbolName,Period)&&
      bougie_low(7,symbolName,Period)<=bougie_low(4,symbolName,Period)&&
      bougie_low(7,symbolName,Period)<=bougie_low(3,symbolName,Period)&&
      bougie_low(7,symbolName,Period)<=bougie_low(2,symbolName,Period)&&
      bougie_corps(7,symbolName,Period)>bougie_corps(2,symbolName,Period)&&
      bougie_corps(7,symbolName,Period)>bougie_corps(3,symbolName,Period)&&
      bougie_corps(7,symbolName,Period)>bougie_corps(4,symbolName,Period)&&
      bougie_corps(7,symbolName,Period)>bougie_corps(5,symbolName,Period)&&
      bougie_corps(7,symbolName,Period)>bougie_corps(6,symbolName,Period)&&
      bougie_corps(1,symbolName,Period)>bougie_corps(2,symbolName,Period)&&
      bougie_corps(1,symbolName,Period)>bougie_corps(3,symbolName,Period)&&
      bougie_corps(1,symbolName,Period)>bougie_corps(4,symbolName,Period)&&
      bougie_corps(1,symbolName,Period)>bougie_corps(5,symbolName,Period)&&
      bougie_corps(1,symbolName,Period)>bougie_corps(6,symbolName,Period)&&
      bougie_close(1,symbolName,Period)>bougie_high(7,symbolName,Period)&&
      lower!=bougie_open(7,symbolName,Period)&&
      meche1<=bougie_corps(1,symbolName,Period)&&
      meche7<=bougie_corps(7,symbolName,Period))//porte drapeau
      {

         string content = "3 méthode ascendante à 5 bougie sur la paire :"+(string)symbolName+" en :"+(string)Period;
   
         if(!SendNotification(content))
         {
            Print(content);
         }
         return true;

      }
      return false;    
   
}
bool _3methodedescendante5b(string symbolName,ENUM_TIMEFRAMES Period){
   
   double higher=getHigherCandle(symbolName,Period,7,9); 
   double meche1=bougie_meche_B(1,symbolName,Period)*2;
   double meche7=bougie_meche_B(7,symbolName,Period)*2;
   if(bougie_close(7,symbolName,Period)<bougie_open(7,symbolName,Period)&&
      bougie_close(1,symbolName,Period)<bougie_open(1,symbolName,Period)&&
      bougie_high(7,symbolName,Period)>=bougie_high(6,symbolName,Period)&&
      bougie_high(7,symbolName,Period)>=bougie_high(5,symbolName,Period)&&
      bougie_high(7,symbolName,Period)>=bougie_high(4,symbolName,Period)&&
      bougie_high(7,symbolName,Period)>=bougie_high(3,symbolName,Period)&&
      bougie_high(7,symbolName,Period)>=bougie_high(2,symbolName,Period)&&
      bougie_low(7,symbolName,Period)<=bougie_low(6,symbolName,Period)&&
      bougie_low(7,symbolName,Period)<=bougie_low(5,symbolName,Period)&&
      bougie_low(7,symbolName,Period)<=bougie_low(4,symbolName,Period)&&
      bougie_low(7,symbolName,Period)<=bougie_low(3,symbolName,Period)&&
      bougie_low(7,symbolName,Period)<=bougie_low(2,symbolName,Period)&&
      bougie_corps(7,symbolName,Period)>bougie_corps(2,symbolName,Period)&&
      bougie_corps(7,symbolName,Period)>bougie_corps(3,symbolName,Period)&&
      bougie_corps(7,symbolName,Period)>bougie_corps(4,symbolName,Period)&&
      bougie_corps(7,symbolName,Period)>bougie_corps(5,symbolName,Period)&&
      bougie_corps(7,symbolName,Period)>bougie_corps(6,symbolName,Period)&&
      bougie_corps(1,symbolName,Period)>bougie_corps(2,symbolName,Period)&&
      bougie_corps(1,symbolName,Period)>bougie_corps(3,symbolName,Period)&&
      bougie_corps(1,symbolName,Period)>bougie_corps(4,symbolName,Period)&&
      bougie_corps(1,symbolName,Period)>bougie_corps(5,symbolName,Period)&&
      bougie_corps(1,symbolName,Period)>bougie_corps(6,symbolName,Period)&&
      bougie_close(1,symbolName,Period)<bougie_low(7,symbolName,Period)&&
      higher!=bougie_open(4,symbolName,Period)&&
      meche1<=bougie_corps(1,symbolName,Period)&&
      meche7<=bougie_corps(7,symbolName,Period))//porte drapeau
      {

         string content = "3 méthode descendante à 5 bougie sur la paire :"+(string)symbolName+" en :"+(string)Period;
   
         if(!SendNotification(content))
         {
            Print(content);
         }
         return true; 
             
      }
      return false;           
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////Porte Drapeau////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////Porte-drapeau 2 bougie////////////////////////////////////////////////////
bool porte_drapeau_haussier_2b(string symbolName,ENUM_TIMEFRAMES Period){

   
   double ttpb1=bougie_corps(1,symbolName,Period)*0.5;//test toupie bougie 1
   double ttpb4=bougie_corps(4,symbolName,Period)*0.5;//test toupie bougie 4
   double lower=getlowerCandle(symbolName,Period,4,9);
   double meche1=bougie_meche_H(1,symbolName,Period)*2;
   double meche4=bougie_meche_H(4,symbolName,Period)*2;
   
   //Condition du porte drapeau haussier
   if(//sens des bougie
      bougie_close(4,symbolName,Period)>bougie_open(4,symbolName,Period)&&//La bougie 4 est haussiere
      bougie_close(1,symbolName,Period)>bougie_open(1,symbolName,Period)&&//La bougie 1 est haussiere
      //initialisation des toupie
      ttpb1>=bougie_corps(3,symbolName,Period)&&//bougie 1 est plus grande que la bougie 3
      ttpb1>=bougie_corps(2,symbolName,Period)&&//bougie 1 est plus grande que la bougie 2
      ttpb4>=bougie_corps(3,symbolName,Period)&&//bougie 4 est plus grande que la bougie 3
      ttpb4>=bougie_corps(2,symbolName,Period)&&//bougie 4 est plus grande que la bougie 2
      //bougie 1 doit cloturer en haut des autres bougies
      bougie_close(1,symbolName,Period)>bougie_close(4,symbolName,Period)&& //la bougie 1 est plus haute que la bougie 4
      bougie_close(1,symbolName,Period)>bougie_close(3,symbolName,Period)&& //la bougie 1 est plus haute que la bougie 3
      // on ne doit pas avoir de longue meche haute 
      meche1<=bougie_corps(1,symbolName,Period)&&
      meche4<=bougie_corps(4,symbolName,Period)&&
      //On doit être dans une tendance haussière
      lower!=bougie_open(4,symbolName,Period)) 
      {
         string content = "porte drapeau haussier à 2 bougie sur la paire :"+(string)symbolName+" en :"+(string)Period;
   
         if(!SendNotification(content))
         {
            Print(content);
         }
         return true; 

      }   
      return false;
}
bool porte_drapeau_baissier_2b(string symbolName,ENUM_TIMEFRAMES Period){

   double ttpb1=bougie_corps(1,symbolName,Period)*0.5;//test toupie bougie 1
   double ttpb4=bougie_corps(4,symbolName,Period)*0.5;//test toupie bougie 4
   double higher=getHigherCandle(symbolName,Period,4,9);
   double meche1=bougie_meche_B(1,symbolName,Period)*2;
   double meche4=bougie_meche_B(4,symbolName,Period)*2;; 
   
   //Condition porte drapeau baissier
   if(//sens des bougie
      bougie_close(4,symbolName,Period)<bougie_open(4,symbolName,Period)&&//La bougie 4 est baissière
      bougie_close(1,symbolName,Period)<bougie_open(1,symbolName,Period)&&//La bougie 1 est baissière
      //initialisation des toupie
      ttpb1>=bougie_corps(3,symbolName,Period)&&//bougie 1 est plus grande que la bougie 3
      ttpb1>=bougie_corps(2,symbolName,Period)&&//bougie 1 est plus grande que la bougie 2
      ttpb4>=bougie_corps(3,symbolName,Period)&&//bougie 4 est plus grande que la bougie 3
      ttpb4>=bougie_corps(2,symbolName,Period)&&//bougie 4 est plus grande que la bougie 2
      //bougie 1 doit cloturer en bas des autres bougie
      bougie_close(1,symbolName,Period)<bougie_close(4,symbolName,Period)&&
      bougie_close(1,symbolName,Period)<bougie_close(3,symbolName,Period)&&
      // on ne doit pas avoir de longue meche basse
      meche1<=bougie_corps(1,symbolName,Period)&&
      meche4<=bougie_corps(4,symbolName,Period)&&
      //On doit être dans une tendance baissière
      higher!=bougie_open(4,symbolName,Period))
      {

         string content = "porte drapeau baissier à 2 bougie sur la paire :"+(string)symbolName+" en :"+(string)Period;
   
         if(!SendNotification(content))
         {
            Print(content);
         }
         return true;     
           
      }
      return false;         
}


////////////////////////////////////////Porte-drapeau 3 bougie////////////////////////////////////////////////////
bool porte_drapeau_haussier_3b(string symbolName,ENUM_TIMEFRAMES Period){
 
   
   double ttpb1=bougie_corps(1,symbolName,Period)*0.5;//test toupie bougie 1
   double ttpb5=bougie_corps(5,symbolName,Period)*0.5;//test toupie bougie 5
   double lower=getlowerCandle(symbolName,Period,5,9);
   double meche1=bougie_meche_H(1,symbolName,Period)*2;
   double meche5=bougie_meche_H(5,symbolName,Period)*2;
   
   //Condition du porte drapeau haussier
   if(//sens des bougie
      bougie_close(5,symbolName,Period)>bougie_open(5,symbolName,Period)&&//La bougie 5 est haussiere
      bougie_close(1,symbolName,Period)>bougie_open(1,symbolName,Period)&&//La bougie 1 est haussiere
      //initialisation des toupie
      ttpb1>=bougie_corps(4,symbolName,Period)&&//bougie 1 est plus grande que la bougie 4
      ttpb1>=bougie_corps(3,symbolName,Period)&&//bougie 1 est plus grande que la bougie 3
      ttpb1>=bougie_corps(2,symbolName,Period)&&//bougie 1 est plus grande que la bougie 2
      ttpb5>=bougie_corps(4,symbolName,Period)&&//bougie 4 est plus grande que la bougie 4
      ttpb5>=bougie_corps(3,symbolName,Period)&&//bougie 4 est plus grande que la bougie 3
      ttpb5>=bougie_corps(2,symbolName,Period)&&//bougie 4 est plus grande que la bougie 2
      //bougie 1 doit cloturer en haut des autres bougies
      bougie_close(1,symbolName,Period)>bougie_close(5,symbolName,Period)&& //la bougie 1 est plus haute que la bougie 5
      bougie_close(1,symbolName,Period)>bougie_close(4,symbolName,Period)&& //la bougie 1 est plus haute que la bougie 4
      bougie_close(1,symbolName,Period)>bougie_close(3,symbolName,Period)&& //la bougie 1 est plus haute que la bougie 3
      // on ne doit pas avoir de longue meche haute 
      meche1<=bougie_corps(1,symbolName,Period)&&
      meche5<=bougie_corps(5,symbolName,Period)&&
      //On doit être dans une tendance haussière
      lower!=bougie_open(5,symbolName,Period)) 
      {
         string content = "porte drapeau haussier à 3 bougie sur la paire :"+(string)symbolName+" en :"+(string)Period;
   
         if(!SendNotification(content))
         {
            Print(content);
         }
         return true; 

      }   
      return false;
}
bool porte_drapeau_baissier_3b(string symbolName,ENUM_TIMEFRAMES Period){

   double ttpb1=bougie_corps(1,symbolName,Period)*0.5;//test toupie bougie 1
   double ttpb5=bougie_corps(5,symbolName,Period)*0.5;//test toupie bougie 5
   double higher=getHigherCandle(symbolName,Period,5,9);
   double meche1=bougie_meche_B(1,symbolName,Period)*2;
   double meche5=bougie_meche_B(5,symbolName,Period)*2;; 
   
   //Condition porte drapeau baissier
   if(//sens des bougie
      bougie_close(5,symbolName,Period)<bougie_open(5,symbolName,Period)&&//La bougie 5 est baissière
      bougie_close(1,symbolName,Period)<bougie_open(1,symbolName,Period)&&//La bougie 1 est baissière
      //initialisation des toupie
      ttpb1>=bougie_corps(4,symbolName,Period)&&//bougie 1 est plus grande que la bougie 4
      ttpb1>=bougie_corps(3,symbolName,Period)&&//bougie 1 est plus grande que la bougie 3
      ttpb1>=bougie_corps(2,symbolName,Period)&&//bougie 1 est plus grande que la bougie 2
      ttpb5>=bougie_corps(4,symbolName,Period)&&//bougie 5 est plus grande que la bougie 4
      ttpb5>=bougie_corps(3,symbolName,Period)&&//bougie 5 est plus grande que la bougie 3
      ttpb5>=bougie_corps(2,symbolName,Period)&&//bougie 5 est plus grande que la bougie 2
      //bougie 1 doit cloturer en bas des autres bougie
      bougie_close(1,symbolName,Period)<bougie_close(5,symbolName,Period)&&//la bougie 1 est plus basse que la bougie 5
      bougie_close(1,symbolName,Period)<bougie_close(4,symbolName,Period)&&//la bougie 1 est plus basse que la bougie 4
      bougie_close(1,symbolName,Period)<bougie_close(3,symbolName,Period)&&//la bougie 1 est plus basse que la bougie 3
      // on ne doit pas avoir de longue meche basse
      meche1<=bougie_corps(1,symbolName,Period)&&
      meche5<=bougie_corps(5,symbolName,Period)&&
      //On doit être dans une tendance baissière
      higher!=bougie_open(5,symbolName,Period))
      {

         string content = "porte drapeau baissier à 3 bougie sur la paire :"+(string)symbolName+" en :"+(string)Period;
   
         if(!SendNotification(content))
         {
            Print(content);
         }
         return true;     
           
      }
      return false;         
}

////////////////////////////////////////Porte-drapeau 4 bougie////////////////////////////////////////////////////
bool porte_drapeau_haussier_4b(string symbolName,ENUM_TIMEFRAMES Period){

   
   double ttpb1=bougie_corps(1,symbolName,Period)*0.5;//test toupie bougie 1
   double ttpb6=bougie_corps(6,symbolName,Period)*0.5;//test toupie bougie 5
   double lower=getlowerCandle(symbolName,Period,6,9);
   double meche1=bougie_meche_H(1,symbolName,Period)*2;
   double meche6=bougie_meche_H(6,symbolName,Period)*2;
   
   //Condition du porte drapeau haussier
   if(//sens des bougie
      bougie_close(6,symbolName,Period)>bougie_open(6,symbolName,Period)&&//La bougie 6 est haussiere
      bougie_close(1,symbolName,Period)>bougie_open(1,symbolName,Period)&&//La bougie 1 est haussiere
      //initialisation des toupie
      ttpb1>=bougie_corps(5,symbolName,Period)&&//bougie 1 est plus grande que la bougie 5
      ttpb1>=bougie_corps(4,symbolName,Period)&&//bougie 1 est plus grande que la bougie 4
      ttpb1>=bougie_corps(3,symbolName,Period)&&//bougie 1 est plus grande que la bougie 3
      ttpb1>=bougie_corps(2,symbolName,Period)&&//bougie 1 est plus grande que la bougie 2
      ttpb6>=bougie_corps(6,symbolName,Period)&&//bougie 6 est plus grande que la bougie 5
      ttpb6>=bougie_corps(4,symbolName,Period)&&//bougie 6 est plus grande que la bougie 4
      ttpb6>=bougie_corps(3,symbolName,Period)&&//bougie 6 est plus grande que la bougie 3
      ttpb6>=bougie_corps(2,symbolName,Period)&&//bougie 6 est plus grande que la bougie 2
      //bougie 1 doit cloturer en haut des autres bougies
      bougie_close(1,symbolName,Period)>bougie_close(6,symbolName,Period)&& //la bougie 1 est plus haute que la bougie 6
      bougie_close(1,symbolName,Period)>bougie_close(5,symbolName,Period)&& //la bougie 1 est plus haute que la bougie 5
      bougie_close(1,symbolName,Period)>bougie_close(4,symbolName,Period)&& //la bougie 1 est plus haute que la bougie 4
      bougie_close(1,symbolName,Period)>bougie_close(3,symbolName,Period)&& //la bougie 1 est plus haute que la bougie 3
      // on ne doit pas avoir de longue meche haute 
      meche1<=bougie_corps(1,symbolName,Period)&&
      meche6<=bougie_corps(6,symbolName,Period)&&
      //On doit être dans une tendance haussière
      lower!=bougie_open(6,symbolName,Period)) 
      {
         string content = "porte drapeau haussier à 4 bougie sur la paire :"+(string)symbolName+" en :"+(string)Period;
   
         if(!SendNotification(content))
         {
            Print(content);
         }
         return true; 

      }   
      return false;
}
bool porte_drapeau_baissier_4b(string symbolName,ENUM_TIMEFRAMES Period){

   double ttpb1=bougie_corps(1,symbolName,Period)*0.5;//test toupie bougie 1
   double ttpb6=bougie_corps(6,symbolName,Period)*0.5;//test toupie bougie 5
   double higher=getHigherCandle(symbolName,Period,6,9);
   double meche1=bougie_meche_B(1,symbolName,Period)*2;
   double meche6=bougie_meche_B(6,symbolName,Period)*2;; 
   
   //Condition porte drapeau baissier
   if(//sens des bougie
      bougie_close(6,symbolName,Period)<bougie_open(6,symbolName,Period)&&//La bougie 6 est baissière
      bougie_close(1,symbolName,Period)<bougie_open(1,symbolName,Period)&&//La bougie 1 est baissière
      //initialisation des toupie
      ttpb1>=bougie_corps(5,symbolName,Period)&&//bougie 1 est plus grande que la bougie 5
      ttpb1>=bougie_corps(4,symbolName,Period)&&//bougie 1 est plus grande que la bougie 4
      ttpb1>=bougie_corps(3,symbolName,Period)&&//bougie 1 est plus grande que la bougie 3
      ttpb1>=bougie_corps(2,symbolName,Period)&&//bougie 1 est plus grande que la bougie 2
      ttpb6>=bougie_corps(5,symbolName,Period)&&//bougie 6 est plus grande que la bougie 5
      ttpb6>=bougie_corps(4,symbolName,Period)&&//bougie 6 est plus grande que la bougie 4
      ttpb6>=bougie_corps(3,symbolName,Period)&&//bougie 6 est plus grande que la bougie 3
      ttpb6>=bougie_corps(2,symbolName,Period)&&//bougie 6 est plus grande que la bougie 2
      //bougie 1 doit cloturer en bas des autres bougie
      bougie_close(1,symbolName,Period)<bougie_close(6,symbolName,Period)&&//la bougie 1 est plus basse que la bougie 6
      bougie_close(1,symbolName,Period)<bougie_close(5,symbolName,Period)&&//la bougie 1 est plus basse que la bougie 5
      bougie_close(1,symbolName,Period)<bougie_close(4,symbolName,Period)&&//la bougie 1 est plus basse que la bougie 4
      bougie_close(1,symbolName,Period)<bougie_close(3,symbolName,Period)&&//la bougie 1 est plus basse que la bougie 3
      // on ne doit pas avoir de longue meche basse
      meche1<=bougie_corps(1,symbolName,Period)&&
      meche6<=bougie_corps(6,symbolName,Period)&&
      //On doit être dans une tendance baissière
      higher!=bougie_open(6,symbolName,Period))
      {

         string content = "porte drapeau baissier à 4 bougie sur la paire :"+(string)symbolName+" en :"+(string)Period;
   
         if(!SendNotification(content))
         {
            Print(content);
         }
         return true;   
           
      }
      return false;         
}

////////////////////////////////////////Porte-drapeau 5 bougie////////////////////////////////////////////////////
bool porte_drapeau_haussier_5b(string symbolName,ENUM_TIMEFRAMES Period){

   
   double ttpb1=bougie_corps(1,symbolName,Period)*0.5;//test toupie bougie 1
   double ttpb7=bougie_corps(7,symbolName,Period)*0.5;//test toupie bougie 5
   double lower=getlowerCandle(symbolName,Period,7,9);
   double meche1=bougie_meche_H(1,symbolName,Period)*2;
   double meche7=bougie_meche_H(7,symbolName,Period)*2;
   
   //Condition du porte drapeau haussier
   if(//sens des bougie
      bougie_close(7,symbolName,Period)>bougie_open(7,symbolName,Period)&&//La bougie 7 est haussiere
      bougie_close(1,symbolName,Period)>bougie_open(1,symbolName,Period)&&//La bougie 1 est haussiere
      //initialisation des toupie
      ttpb1>=bougie_corps(6,symbolName,Period)&&//bougie 1 est plus grande que la bougie 6
      ttpb1>=bougie_corps(5,symbolName,Period)&&//bougie 1 est plus grande que la bougie 5
      ttpb1>=bougie_corps(4,symbolName,Period)&&//bougie 1 est plus grande que la bougie 4
      ttpb1>=bougie_corps(3,symbolName,Period)&&//bougie 1 est plus grande que la bougie 3
      ttpb1>=bougie_corps(2,symbolName,Period)&&//bougie 1 est plus grande que la bougie 2
      ttpb7>=bougie_corps(6,symbolName,Period)&&//bougie 7 est plus grande que la bougie 6
      ttpb7>=bougie_corps(5,symbolName,Period)&&//bougie 7 est plus grande que la bougie 5
      ttpb7>=bougie_corps(4,symbolName,Period)&&//bougie 7 est plus grande que la bougie 4
      ttpb7>=bougie_corps(3,symbolName,Period)&&//bougie 7 est plus grande que la bougie 3
      ttpb7>=bougie_corps(2,symbolName,Period)&&//bougie 7 est plus grande que la bougie 2
      //bougie 1 doit cloturer en haut des autres bougies
      bougie_close(1,symbolName,Period)>bougie_close(7,symbolName,Period)&& //la bougie 1 est plus haute que la bougie 7
      bougie_close(1,symbolName,Period)>bougie_close(6,symbolName,Period)&& //la bougie 1 est plus haute que la bougie 6
      bougie_close(1,symbolName,Period)>bougie_close(5,symbolName,Period)&& //la bougie 1 est plus haute que la bougie 5
      bougie_close(1,symbolName,Period)>bougie_close(4,symbolName,Period)&& //la bougie 1 est plus haute que la bougie 4
      bougie_close(1,symbolName,Period)>bougie_close(3,symbolName,Period)&& //la bougie 1 est plus haute que la bougie 3
      // on ne doit pas avoir de longue meche haute 
      meche1<=bougie_corps(1,symbolName,Period)&&
      meche7<=bougie_corps(7,symbolName,Period)&&
      //On doit être dans une tendance haussière
      lower!=bougie_open(7,symbolName,Period)) 
      {
         string content = "porte drapeau haussier à 5 bougie sur la paire :"+(string)symbolName+" en :"+(string)Period;
   
         if(!SendNotification(content))
         {
            Print(content);
         }
         return true;

      }   
      return false;
}
bool porte_drapeau_baissier_5b(string symbolName,ENUM_TIMEFRAMES Period){
 
   double ttpb1=bougie_corps(1,symbolName,Period)*0.5;//test toupie bougie 1
   double ttpb7=bougie_corps(7,symbolName,Period)*0.5;//test toupie bougie 7
   double higher=getHigherCandle(symbolName,Period,7,9);
   double meche1=bougie_meche_B(1,symbolName,Period)*2;
   double meche7=bougie_meche_B(7,symbolName,Period)*2;; 
   
   //Condition porte drapeau baissier
   if(//sens des bougie
      bougie_close(7,symbolName,Period)<bougie_open(7,symbolName,Period)&&//La bougie 7 est baissière
      bougie_close(1,symbolName,Period)<bougie_open(1,symbolName,Period)&&//La bougie 1 est baissière
      //initialisation des toupie
      ttpb1>=bougie_corps(6,symbolName,Period)&&//bougie 1 est plus grande que la bougie 6
      ttpb1>=bougie_corps(5,symbolName,Period)&&//bougie 1 est plus grande que la bougie 5
      ttpb1>=bougie_corps(4,symbolName,Period)&&//bougie 1 est plus grande que la bougie 4
      ttpb1>=bougie_corps(3,symbolName,Period)&&//bougie 1 est plus grande que la bougie 3
      ttpb1>=bougie_corps(2,symbolName,Period)&&//bougie 1 est plus grande que la bougie 2
      ttpb7>=bougie_corps(6,symbolName,Period)&&//bougie 7 est plus grande que la bougie 6
      ttpb7>=bougie_corps(5,symbolName,Period)&&//bougie 7 est plus grande que la bougie 5
      ttpb7>=bougie_corps(4,symbolName,Period)&&//bougie 7 est plus grande que la bougie 4
      ttpb7>=bougie_corps(3,symbolName,Period)&&//bougie 7 est plus grande que la bougie 3
      ttpb7>=bougie_corps(2,symbolName,Period)&&//bougie 7 est plus grande que la bougie 2
      //bougie 1 doit cloturer en bas des autres bougie
      bougie_close(1,symbolName,Period)<bougie_close(7,symbolName,Period)&&//la bougie 1 est plus basse que la bougie 7
      bougie_close(1,symbolName,Period)<bougie_close(6,symbolName,Period)&&//la bougie 1 est plus basse que la bougie 6
      bougie_close(1,symbolName,Period)<bougie_close(5,symbolName,Period)&&//la bougie 1 est plus basse que la bougie 5
      bougie_close(1,symbolName,Period)<bougie_close(4,symbolName,Period)&&//la bougie 1 est plus basse que la bougie 4
      bougie_close(1,symbolName,Period)<bougie_close(3,symbolName,Period)&&//la bougie 1 est plus basse que la bougie 3
      // on ne doit pas avoir de longue meche basse
      meche1<=bougie_corps(1,symbolName,Period)&&
      meche7<=bougie_corps(7,symbolName,Period)&&
      //On doit être dans une tendance baissière
      higher!=bougie_open(7,symbolName,Period))
      {

         string content = "porte drapeau baissier à 5 bougie sur la paire :"+(string)symbolName+" en :"+(string)Period;
   
         if(!SendNotification(content))
         {
            Print(content);
         }
         return true;    
           
      }
      return false;         
}

bool Cassure_Kijun_Haussier_setup(string symbolName,ENUM_TIMEFRAMES Period){

   double meche1=bougie_meche_H(1,symbolName,Period)*3;
   double kijun1=kijun(Period,1,symbolName);
   double kijun2=kijun(Period,2,symbolName);
   double tenkan2= tenkan(Period,2,symbolName);
   double SSA1=SSA(Period,1,0,symbolName);
   double SSB1=SSB(Period,1,0,symbolName);
   if(bougie_close(1,symbolName,Period)>bougie_open(1,symbolName,Period)&&//La bougie 1 est haussiere
      meche1<=bougie_corps(1,symbolName,Period)&&
      bougie_corps(1,symbolName,Period)>bougie_corps(2,symbolName,Period)&&
      bougie_corps(1,symbolName,Period)>bougie_corps(3,symbolName,Period)&&
      bougie_corps(1,symbolName,Period)>bougie_corps(4,symbolName,Period)/*&&
      bougie_corps(1,symbolName,Period)>bougie_corps(5,symbolName,Period)*/){
      if(kijun1!=-1 && kijun1<=bougie_close(1,symbolName,Period)&& kijun1>=bougie_open(1,symbolName,Period)&&kijun1==kijun2&&tenkan2<kijun2&&(SSA1<kijun1||SSB1<kijun1))
      {       
         return true;  
      }
      
   }
   return false;

}

bool Cassure_Kijun_Baissier_setup(string symbolName,ENUM_TIMEFRAMES Period){

   double meche1=bougie_meche_B(1,symbolName,Period)*3;
   double kijun1=kijun(Period,1,symbolName);
   double kijun2=kijun(Period,2,symbolName);
   double tenkan2= tenkan(Period,1,symbolName);
   double SSA1=SSA(Period,1,0,symbolName);
   double SSB1=SSB(Period,1,0,symbolName);
   if(bougie_close(1,symbolName,Period)<bougie_open(1,symbolName,Period)&&//La bougie 1 est baissière
      meche1<=bougie_corps(1,symbolName,Period)&&
      bougie_corps(1,symbolName,Period)>bougie_corps(2,symbolName,Period)&&
      bougie_corps(1,symbolName,Period)>bougie_corps(3,symbolName,Period)&&
      bougie_corps(1,symbolName,Period)>bougie_corps(4,symbolName,Period)/*&&
      bougie_corps(1,symbolName,Period)>bougie_corps(5,symbolName,Period)*/){
      
      if(kijun1!=-1 && kijun1<=bougie_open(1,symbolName,Period)&& kijun1>=bougie_close(1,symbolName,Period)&&kijun1==kijun2&&tenkan2>kijun2&&(SSA1>kijun1||SSB1>kijun1))
      {
  
               
                  return true;
        
      }
      
   }
   return false;

}