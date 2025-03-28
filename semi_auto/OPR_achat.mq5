//+------------------------------------------------------------------+
//|                                                          OPR.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//Ce programme va nous permettre d'acheter dans l'OPR

#property copyright "Copyright 2023, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"

#include <Trade\Trade.mqh>//Accées à la librairie nous permettant d'ouvrir une position dont la class Ctrade
#include <Riad\Candle.mqh>

CTrade trade;
ulong Position_prise = 0;//si on a pris une position
double bas_OPR=NULL;
double haut_OPR=NULL;
int Signaux_m15=0;
int Signaux_m5=0;
int Signaux_m3=0;

input int Heure=16;
input int Minute=45;


/*void OnInit(){    //cette fonction est appelé au lancement d'un bot, elle est appelé une seule fois
   MqlDateTime now;
   TimeToStruct(TimeCurrent(), now);
   int Heure_fin=Heure + 3;
   //On doit être dans la pèriode de l'OPR'
   if(((now.hour = Heure && now.min>= Minute)||now.hour > Heure ) && now.hour =< Heure_fin){
      datetime date_start=D'2022.09.01 09:00:00';
      datetime date_end=D'2023.07.31 09:00:00';
      //à finir
    
   }

}
*/

void OnTick(){
   
   MqlDateTime now;
   TimeToStruct(TimeCurrent(), now);//On paramètre la variable au temps actuelle
//initialisation de l'OPR
   if(now.hour == Heure && now.min == Minute){
      haut_OPR = bougie_high(1,_Symbol,PERIOD_M15);  
      bas_OPR= bougie_low(1,_Symbol,PERIOD_M15);
      
     }
//Initialisation des bougie m3, m5 et m15
   //bougie m3
   double Bougie_cl_m3= bougie_close(1,_Symbol,PERIOD_M3);
   double Bougie_op_m3=bougie_open(1,_Symbol,PERIOD_M3);
   double Corps_m3 = bougie_corps(1;_Symbol,PERIOD_M3);
   
   
   //bougie m5
   double Bougie_cl_m5=bougie_close(1,_Symbol,PERIOD_M5);
   double Bougie_op_m5=bougie_open(1,_Symbol,PERIOD_M3);
   double Corps_m5 = bougie_corps(1;_Symbol,PERIOD_M5);
   
   //bougie m15
   double Bougie_cl_m15=bougie_close(1,_Symbol,PERIOD_M15);
   double Bougie_op_m15=bougie_open(1,_Symbol,PERIOD_M3);
   double Corps_m15 = bougie_corps(1;_Symbol,PERIOD_M15);
   
   
//Prise de Position
   if(Position_prise!=0 && haut_OPR != NULL && bas_OPR != NULL){
   //Cassure
      if(Bougie_m15> haut_OPR&&Bougie_op_m15< haut_OPR && Signaux_m15 ==0)
      {
         Signaux_m15=1;
         if(Corps_m15>bougie_corps(2;_Symbol,PERIOD_M15)){
            
            trade.BuyLimit()
               
         }        
         
      }
   //réintégration
      if()
        {
         
        }
   }

}

//si on est 16:30 on va acheter lorsque on casse l'OPR
//On va faire un include qui va nous donner l'heure de la bougie prècedente'

//Cette fonction va renvoyer le nombre de bougie entre les date par rapport au nombre de bougie
void fonction_date(ENUM_TIMEFRAMES PERIOD, ) {

   int i= NULL;
   
   switch(PERIOD)
     {
      case PERIOD_M15:
         i= 15;
         break;
      case PERIOD_M5:
         i= 5;
         break;
      case PERIOD_M3:
         i= 3;
         break;         
      default:
      i=0
        break;
     }

   MqlDateTime now;
   TimeToStruct(TimeCurrent(), now);
   
   //Initialisation de la date de l'OPR
   MqlDateTime str_date_OPR={};
   str_date_OPR.year= now.year;
   str_date_OPR.mon = now.mon;
   str_date_OPR.day = now.day;
   str_date_OPR.hour= 16;
   str_date_OPR.min = 45;
   str_date_OPR.sec = 00;
   
   MqlDateTime date2={};
   date2.year= now.year;
   date2.mon = now.mon;
   date2.day = now.day;
   date2.hour= 17;
   date2.min = 18;
   date2.sec = 22;

   //Date OPR en datetime
   datetime date_OPR = StructToTime(str_date_OPR);
   int index_date=0
   //calcul du nombre de chandelier depuis l'OPR
   for(dateOPR<date2;date_OPR=date_OPR+60*i)
   {
     index_date +1;
     Print("index=" +index_date);
     if(i=0)
       {
        index_date=0;
        break;
       }
   }
   Print("l'index est:"+index_date);
   
   
   /*Print("now=" + maintenant);
   Print("time1" + test1);
   Print("time2" + test2);
   //on change la datetime en nombre
   datetime test11=test1 +(60*i);
   datetime test12=test2 -(60*i);
   Print("time1 + 15 min" +test11);
   Print("time2  - 15 min" +test1);
   if(test1==test12&& test11==test2)
     {
      Print("Test Réussi");
     }
   */
 }
   