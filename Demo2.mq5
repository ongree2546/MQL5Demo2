//+------------------------------------------------------------------+
//|                                                        Demo2.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#include <Trade\Trade.mqh>
CTrade trade;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
Comment("Bar shift back : ",bartype(),"Balance :", AccountInfoDouble(ACCOUNT_EQUITY));
}
   string bartype() {
   
   int stoplossPoint = 500;
   double cl = iClose(_Symbol, PERIOD_CURRENT, 1);
   double ema = iMA(_Symbol, PERIOD_CURRENT, 10, 0, MODE_EMA, PRICE_CLOSE);
   string type = "none";
   double stoploss = ema - (stoplossPoint * SymbolInfoDouble(_Symbol, SYMBOL_POINT));
   double takeprofit = (cl <= ema);
   if (cl > ema && cl >= ema) {
      type = "BullishCrossover";
      if (PositionsTotal() <= 1) {
         trade.Buy(0.1,NULL,cl,stoploss,takeprofit,NULL);
      }
   }
   if (cl < ema && cl<= ema) {
      type = "BearishCrossover";
      if (PositionsTotal() <= 1) {
       stoploss = ema + (stoplossPoint * SymbolInfoDouble(_Symbol, SYMBOL_POINT));
       takeprofit = (cl >= ema);
         trade.Sell(0.1,NULL,cl,stoploss,takeprofit,NULL);
      }
   }

   return type;
}

//+------------------------------------------------------------------+
