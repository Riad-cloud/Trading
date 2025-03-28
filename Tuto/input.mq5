//+------------------------------------------------------------------+
//|                                                        input.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//Dans ce fichier nous allons voir comment mettre des input(entrée utilisateur) et les utilisées.

//On doit toujours definir les inputs hors des fonctions

enum DAY_OF_WEEK{
//L'enumeration pour les jours de la semaine existe déja dans la doc  
   LUNDI,
   MARDI,
   MERCREDI,
   JEUDI,
   VENDREDI,
   SAMEDI,
   DIMANCHE,   
};
  
input group "TRADE";
input string SYMBOL= "EUR/USD";
input double TAKEPROFIT = 3.0;
input bool FRIDAY_TRADE = true;

input group "CALCUL";
input ENUM_TIMEFRAMES PERIOD = PERIOD_H1;
input ENUM_MA_METHOD METHOD = MODE_SMA;

input group "LOG";
input DAY_OF_WEEK LOG_DAY = LUNDI;


void OnInit() {
   
   Print(SYMBOL);
   Print(TAKEPROFIT);
   Print(FRIDAY_TRADE);
   Print(PERIOD);
   Print(LOG_DAY);
   Print(METHOD);
}
