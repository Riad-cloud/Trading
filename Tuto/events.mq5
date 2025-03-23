//+------------------------------------------------------------------+
//|                                                       events.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//Dans ce programme nous verrons les fonctions principal et leurs caractéristiques.


void OnInit(){    //cette fonction est appelé au lancement d'un bot, elle est appelé une seule fois
                  //elle permet d'initialiser des paramètre ou d'afficher un message au lancement pour l'utilisateur
                  //Ou encore récupérer des information du compte pour par exemple mettre à jour sa stratégie
Print("start");//affiche start à l'initialisation sur le terminal
}
void OnTick(){    //cette fonction va être appelé à chaque tick suite à une transaction jusqu'à une dizaine de fois par seconde
   Comment("RUNNING");//Commente running à chaque tick sur le graphique
  }
 
 void OnDeinit(const int reason)  //Cette fonction est appelé lorsque on enlève notre bot du graphique, elle est appelé une seule fois.
   {                      //Elle prend pour paramètre une variable du nom de reason et qui va être la reaon de la désinstalation de notre bot
    Print((string)reason);//va afficher la variable reason 
                          //Pour comprendre la valeur de reason il faudra regarder la doc, elle sera utile pour trouver les bug.
   }           