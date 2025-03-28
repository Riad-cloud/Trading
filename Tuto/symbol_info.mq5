//+------------------------------------------------------------------+
//|                                                  symbol_info.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//Dans ce programme nous verrons comment récupérer les information d'un symbol ou actif prédéterminé.
//Lien pour avoir les autres fonctions qui sert à récupérer les information du marché
//https://www.mql5.com/fr/docs/marketinformation

void OnTick(){
   Print(Symbol());//la fonction Symbol ()récupère les imformation du symbole actuelle(le nom du symbol où a été enclencher le bot)
   Print(_Symbol);//Cette variable fait la même chose que la fonction Symbol()

   //lien pour propriété https://www.mql5.com/fr/docs/constants/environment_state/marketinfoconstants#enum_symbol_info_double
   //SymbolInfoDouble, récupère la valeur d'un proprièté qui est un nombre décimal
   //récupère la valeur d'un proprièté qui est un nombre
   double ask = SymbolInfoDouble(_Symbol,SYMBOL_ASK);
   double bid = SymbolInfoDouble(_Symbol,SYMBOL_BID);
   double point = SymbolInfoDouble(_Symbol,SYMBOL_POINT);//le point est la dernière décimal du prix
   double minVolume = SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_MIN);//volume minimum a acheté pour pouvoir ouvrir une position sur ce symbol
   
   Print("Prix d'achat:" + (string)ask);
   Print("Prix de vente:" + (string)bid);
   Print("Point:" + (string)point);
   Print("Volume minimum:" + (string)minVolume);
   
   int spread = SymbolInfoInteger(_Symbol,SYMBOL_SPREAD);
   Print("Spread:" + (string)spread);
}