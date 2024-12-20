//+------------------------------------------------------------------+
//|                                       figure_retournement1.0.mqh |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, MetaQuotes Ltd."
#property link      "https://www.mql5.com"

#include <Riad\Candle.mqh>
#include <Riad/Ichimoku.mqh>


bool avalente_haussier(string symbolName,ENUM_TIMEFRAMES Period){


   //description de la figure
   if(etoile_du_matin(symbolName,Period)==false&&
      bougie_statut(2,symbolName,Period)==0&&//bougie baissière
      bougie_statut(1,symbolName,Period)==1&& //Bougie haussière
      bougie_open(2,symbolName,Period)<bougie_close(1,symbolName,Period)&&
      bougie_close(4,symbolName,Period)>bougie_close(2,symbolName,Period)&& //condition pour que la figure soit le seul point bas
      bougie_close(5,symbolName,Period)>bougie_close(2,symbolName,Period)//condition pour que la figure soit le seul point bas
      
      )
   {
      //Coefficient de la droite de tendance si elle est positif alors la tendance intèrieur est baissière.
      double coeff = bougie_corps(2,symbolName,Period);
      // calcule de la droite de tendance qui reprèsente le mouvement en prècedent la figure de retournement.
      for(int i=3;i<7;i++)
      {
         //si la bougie est baissière
         if(bougie_statut(i,symbolName,Period)==0)
         {
            coeff=coeff+bougie_corps(i,symbolName,Period);
         }
         //si la bougie est haussière
         else if(bougie_statut(i,symbolName,Period)==1)
         {
            coeff=coeff-bougie_corps(i,symbolName,Period);
         }
         if(coeff > (bougie_corps(2,symbolName,Period)*3) && coeff > (bougie_corps(1,symbolName,Period)*1) )
         {
         //Print("Le coefficient est :" + (string)coeff);
         return true; 
         }

      }
   
      if(coeff >= (bougie_corps(1,symbolName,Period)*1.5))
      {  
         //Print("Le coefficient est :" + (string)coeff);     
         return true; 
      }
      if(coeff > (bougie_corps(1,symbolName,Period)*1)&&coeff > (bougie_corps(2,symbolName,Period)*2))
      {
         return true;
      }

   }
   return false;   
   
}

bool avalente_baissiere(string symbolName,ENUM_TIMEFRAMES Period){


   //description de la figure
   if(etoile_du_soir(symbolName,Period)==false&&
      bougie_statut(2,symbolName,Period)==1&&//bougie haussiére
      bougie_statut(1,symbolName,Period)==0&& //Bougie baissière
      bougie_open(2,symbolName,Period)>bougie_close(1,symbolName,Period)&&
      bougie_close(4,symbolName,Period)<bougie_close(2,symbolName,Period)&& //condition pour que la figure soit le seul point bas
      bougie_close(5,symbolName,Period)<bougie_close(2,symbolName,Period) //condition pour que la figure soit le seul point bas
      )
   {
      //Coefficient de la droite de tendance si elle est positif alors la tendance intèrieur est baissière.
      double coeff= bougie_corps(2,symbolName,Period) ;
      
      // calcule de la droite de tendance qui reprèsente le mouvement en prècedent la figure de retournement.
      for(int i=3;i<7;i++)
      {
         //si la bougie est baissière
         if(bougie_statut(i,symbolName,Period)==0)
         {
            coeff=coeff-bougie_corps(i,symbolName,Period);
         }
         //si la bougie est haussière
         else if(bougie_statut(i,symbolName,Period)==1)
         {
            coeff=coeff+bougie_corps(i,symbolName,Period);
         }
         if(coeff > (bougie_corps(2,symbolName,Period)*3) && coeff > (bougie_corps(1,symbolName,Period)*1) )
         {
         //Print("Le coefficient est :" + (string)coeff);
         return true; 
         }
         

      }
   
      if(coeff >= (bougie_corps(1,symbolName,Period)*1.5))
      {
         //Print("Le coefficient est :" + (string)coeff);
         return true; 
      }
      if(coeff > (bougie_corps(1,symbolName,Period)*1)&&coeff > (bougie_corps(2,symbolName,Period)*2))
      {
         return true;
      }

   }
   return false;   
   
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////étoile du soir et du matin//////////////////////////////////////////////////

bool etoile_du_matin(string symbolName,ENUM_TIMEFRAMES Period){

   bool varBougie2TailleCorrecte=true; //Indique si la taille de la bougie 2 est correcte par rapport à la bougie 1
   if(bougie_statut(2,symbolName,Period)==0)
     {
      if((bougie_corps(1,symbolName,Period)/3)<bougie_corps(2,symbolName,Period))//si la bougie 1 est incorrecte
      {
      varBougie2TailleCorrecte=false;
      }
      
     }
   //description de la figure
   if(bougie_statut(3,symbolName,Period)==0&&                                       //bougie 3 baissière
      bougie_statut(1,symbolName,Period)==1&&                                       //Bougie 1 haussière
      varBougie2TailleCorrecte==true&&                                              //taille bougie 2 correcte
      (bougie_corps(2,symbolName,Period)*2)<bougie_corps(1,symbolName,Period)&&     //1er vérification de la taille de la bougie 1
      (bougie_corps(2,symbolName,Period)*2.5)<bougie_corps(3,symbolName,Period)&&   //1er vérification de la taille de la bougie 3
      (bougie_corps(1,symbolName,Period)/3)<bougie_corps(3,symbolName,Period)&&     //condition pour que la bougie 1 ne soit pas le triple de la bougie 3(2eme verif de la bougie 1)
      (bougie_corps(3,symbolName,Period)/3)<bougie_corps(1,symbolName,Period)&&     //condition pour que la bougie 3 ne soit pas le triple de la bougie 1(2eme verif de la bougie 3)
      bougie_close(5,symbolName,Period)>bougie_close(3,symbolName,Period)&&         //condition pour que la figure soit le seul point bas
      bougie_close(6,symbolName,Period)>bougie_close(3,symbolName,Period)&&         //condition pour que la figure soit le seul point bas
      bougie_meche_H(1,symbolName,Period)<(bougie_corps(1,symbolName,Period)*1.5))  //évite les grosse mèche haute sur la bougie 1
   {
      //Coefficient de la droite de tendance si elle est positif alors la tendance intèrieur est baissière.
      double coeff = bougie_corps(3,symbolName,Period);
      // calcule de la droite de tendance qui reprèsente le mouvement en prècedent la figure de retournement.
      for(int i=4;i<8;i++)
      {
         //si la bougie est baissière
         if(bougie_statut(i,symbolName,Period)==0)
         {
            coeff=coeff+bougie_corps(i,symbolName,Period);
         }
         //si la bougie est haussière
         else if(bougie_statut(i,symbolName,Period)==1)
         {
            coeff=coeff-bougie_corps(i,symbolName,Period);
         }
         if(coeff > (bougie_corps(3,symbolName,Period)*2))
         {  
 
         return true; 
         }
         if(bougie_open(3,symbolName,Period)>bougie_close(1,symbolName,Period)&&coeff > (bougie_corps(3,symbolName,Period)*1.5))
         {
            return true;
         }

      }
   
      if(coeff > (bougie_corps(3,symbolName,Period)*1))
      {  
 
         return true; 
      }

   }
   return false;   
   
}

bool etoile_du_soir(string symbolName,ENUM_TIMEFRAMES Period){
   
   bool varBougie2TailleCorrecte=true; //Indique si la taille de la bougie 2 est correcte par rapport à la bougie 1
   if(bougie_statut(2,symbolName,Period)==1)
     {
      if((bougie_corps(1,symbolName,Period)/3)<bougie_corps(2,symbolName,Period))//si la bougie 1 est incorrecte
      {
      varBougie2TailleCorrecte=false;
      }
      
     }
   //description de la figure
   if(bougie_statut(3,symbolName,Period)==1&&                                       //Bougie 3 haussière
      bougie_statut(1,symbolName,Period)==0&&                                       //bougie 1 baissière
      varBougie2TailleCorrecte==true&&                                              //taille bougie 2 correcte
      (bougie_corps(2,symbolName,Period)*2)<bougie_corps(1,symbolName,Period)&&     //1er vérification de la taille de la bougie 1
      (bougie_corps(2,symbolName,Period)*2.5)<bougie_corps(3,symbolName,Period)&&   //1er vérification de la taille de la bougie 3
      (bougie_corps(1,symbolName,Period)/3)<bougie_corps(3,symbolName,Period)&&     //condition pour que la bougie 1 ne soit pas le triple de la bougie 3(2eme verif de la bougie 1)
      (bougie_corps(3,symbolName,Period)/3)<bougie_corps(1,symbolName,Period)&&     //condition pour que la bougie 3 ne soit pas le triple de la bougie 1(2eme verif de la bougie 1)
      bougie_close(5,symbolName,Period)<bougie_close(3,symbolName,Period)&&         //condition pour que la figure soit le seul point haut
      bougie_close(6,symbolName,Period)<bougie_close(3,symbolName,Period)&&         //condition pour que la figure soit le seul point haut
      (bougie_meche_B(1,symbolName,Period)*1.5)<=bougie_corps(1,symbolName,Period)) //évite les grosse mèche haute sur la bougie 1 
   {
      //Coefficient de la droite de tendance si elle est positif alors la tendance intèrieur est baissière.
      double coeff= bougie_corps(3,symbolName,Period) ;
      
      // calcule de la droite de tendance qui reprèsente le mouvement en prècedent la figure de retournement.
      for(int i=4;i<8;i++)
      {
         //si la bougie est baissière
         if(bougie_statut(i,symbolName,Period)==0)
         {
            coeff=coeff-bougie_corps(i,symbolName,Period);
         }
         //si la bougie est haussière
         else if(bougie_statut(i,symbolName,Period)==1)
         {
            coeff=coeff+bougie_corps(i,symbolName,Period);
         }
         if(coeff > (bougie_corps(3,symbolName,Period)*2))
         {  
 
         return true; 
         }
         if(bougie_open(3,symbolName,Period)<bougie_close(1,symbolName,Period)&&coeff > (bougie_corps(3,symbolName,Period)*1.5))
         {
            return true;
         }

      }
   
      if(coeff > (bougie_corps(3,symbolName,Period)*1))
      {
      
         //Print( "corps 3:"+ (string)bougie_corps(3,symbolName,Period));
         //Print( "corps 1:"+ (string)bougie_corps(1,symbolName,Period));
         return true; 
      }

   }
   return false;   
   
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////Pénétrante//////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


bool penetrante_haussier(string symbolName,ENUM_TIMEFRAMES Period){


   //description de la figure
   double B2_F61=bougie_open(2,symbolName,Period)-bougie_corps(2,symbolName,Period)*0.382;//Niveau des 61.8 fibonnacci de la bougie 2
   
   if(bougie_statut(2,symbolName,Period)==0&&//bougie baissière
      bougie_statut(1,symbolName,Period)==1&& //Bougie haussière
      bougie_close(1,symbolName,Period) >= B2_F61&&//la bougie 1 dois dépasser les 61.8
      bougie_close(1,symbolName,Period)<=bougie_open(2,symbolName,Period)&&//la bougie1 ne dois pas dépasser la bougie 2
      bougie_close(4,symbolName,Period)>bougie_close(2,symbolName,Period)&& //condition pour que la figure soit le seul point bas
      bougie_close(5,symbolName,Period)>bougie_close(2,symbolName,Period)//condition pour que la figure soit le seul point bas
      
      )
   {
      //Coefficient de la droite de tendance si elle est positif alors la tendance intèrieur est baissière.
      double coeff = bougie_corps(2,symbolName,Period);
      // calcule de la droite de tendance qui reprèsente le mouvement en prècedent la figure de retournement.
      for(int i=3;i<7;i++)
      {
         //si la bougie est baissière
         if(bougie_statut(i,symbolName,Period)==0)
         {
            coeff=coeff+bougie_corps(i,symbolName,Period);
         }
         //si la bougie est haussière
         else if(bougie_statut(i,symbolName,Period)==1)
         {
            coeff=coeff-bougie_corps(i,symbolName,Period);
         }
         if( coeff > (bougie_corps(1,symbolName,Period)*2) )
         {
         
         return true; 
         }

      }
   
      if(coeff >= (bougie_corps(1,symbolName,Period)*1.5))
      {  
         //Print("Le coefficient est :" + (string)coeff);     
         return true; 
      }

   }
   return false;   
   
}

bool penetrante_baissiere(string symbolName,ENUM_TIMEFRAMES Period){


   //description de la figure
   double B2_F61=bougie_open(2,symbolName,Period)+bougie_corps(2,symbolName,Period)*0.382;//Niveau des 61.8 fibonnacci de la bougie 2
   if(bougie_statut(2,symbolName,Period)==1&&//bougie haussiére
      bougie_statut(1,symbolName,Period)==0&& //Bougie baissière
      bougie_close(1,symbolName,Period)<= B2_F61&&//la bougie 1 dois dépasser les 61.8
      bougie_close(1,symbolName,Period)>=bougie_open(2,symbolName,Period)&&//la bougie1 ne dois pas dépasser la bougie 2
      bougie_close(4,symbolName,Period)<bougie_close(2,symbolName,Period)&& //condition pour que la figure soit le seul point bas
      bougie_close(5,symbolName,Period)<bougie_close(2,symbolName,Period) //condition pour que la figure soit le seul point bas
      )
   {
      //Coefficient de la droite de tendance si elle est positif alors la tendance intèrieur est baissière.
      double coeff= bougie_corps(2,symbolName,Period) ;
      
      // calcule de la droite de tendance qui reprèsente le mouvement en prècedent la figure de retournement.
      for(int i=3;i<7;i++)
      {
         //si la bougie est baissière
         if(bougie_statut(i,symbolName,Period)==0)
         {
            coeff=coeff-bougie_corps(i,symbolName,Period);
         }
         //si la bougie est haussière
         else if(bougie_statut(i,symbolName,Period)==1)
         {
            coeff=coeff+bougie_corps(i,symbolName,Period);
         }
         
         if( coeff > (bougie_corps(1,symbolName,Period)*2) )
         {
         
         return true; 
         }

      }
   
      if(coeff > (bougie_corps(1,symbolName,Period)*1.5))
      {
         //Print("Le coefficient est :" + (string)coeff);
         return true; 
      }

   }
   return false;   
   
}