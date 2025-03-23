#include <Riad/Figure_indicateur_technique.mqh>
#include <Riad\Calculateur.mqh>
#include <Riad\Candle.mqh>
#include <Riad\figure_continuation.mqh>
#include <Riad\figure_retournement.mqh>
#include <Trade\Trade.mqh>
#include <Riad/entry.mqh>
//test des entrée définit

int capital = 20000;
CTrade trade;
ulong date_post_op = 0;
void  OnTick(void)
{
   
      if(date_post_op<=(ulong)TimeCurrent() ){
      
         if(PositionsTotal()<1){
            start();
         }
      }

   
   
   
}
void start (){

   if(Cassure_Kijun_Haussier(_Symbol,PERIOD_CURRENT,capital,0.5))
   {
      date_post_op= set_ope_bougie();
   }
   else if (Cassure_Kijun_Baissier(_Symbol,PERIOD_CURRENT,capital,0.5))
   {
      date_post_op= set_ope_bougie();
   }
   
}

//////////////////////////Fonction operation////////////////////////////////////////////////////////
//Cette fonction va nous permettre de ne pas prendre plusieurs position perdante dans une bougie qui a déja un trade perdant.
ulong set_ope_bougie(){
   
   MqlRates historyBuffer[];
   
   ArraySetAsSeries(historyBuffer,true);
   ulong UT = 0;
   if(CopyRates(_Symbol,_Period,0,3,historyBuffer)){
               ulong date1 = (ulong)historyBuffer[2].time;
               ulong date2 = (ulong)historyBuffer[1].time;
               UT = (ulong)TimeCurrent() +4*(date2-date1);
         
   }
   return UT;
     
}