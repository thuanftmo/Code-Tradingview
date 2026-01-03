//+------------------------------------------------------------------+
//|                                                  ZIGZAG_Box.mq5  |
//|                                  Copyright 2026, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2026, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_chart_window
#property indicator_buffers 2
#property indicator_plots   2

//--- Plot ZigZag
#property indicator_label1  "ZigZag High"
#property indicator_type1   DRAW_LINE
#property indicator_color1  clrYellow
#property indicator_style1  STYLE_SOLID
#property indicator_width1  2

#property indicator_label2  "ZigZag Low"
#property indicator_type2   DRAW_LINE
#property indicator_color2  clrYellow
#property indicator_style2  STYLE_SOLID
#property indicator_width2  2

//--- Input parameters
input int      InpDepth      = 12;        // ZigZag Depth
input int      InpDeviation  = 5;         // ZigZag Deviation (%)
input int      InpBackstep   = 3;         // ZigZag Backstep
input bool     InpShowBoxes  = true;      // Show Boxes
input color    InpBoxColor   = clrBlue;   // Box Color
input color    InpBoxBorder  = clrBlue;   // Box Border Color
input int      InpBoxTransparency = 80;   // Box Transparency (0-100)

//--- Indicator buffers
double ZigZagHighBuffer[];
double ZigZagLowBuffer[];

//--- Global variables
int    lastDirection = 0;
double lastHigh = 0;
double lastLow = 0;
int    lastHighBar = -1;
int    lastLowBar = -1;
string boxPrefix = "ZigZagBox_";
int    boxCounter = 0;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- Indicator buffers mapping
   SetIndexBuffer(0, ZigZagHighBuffer, INDICATOR_DATA);
   SetIndexBuffer(1, ZigZagLowBuffer, INDICATOR_DATA);
   
//--- Set empty values
   PlotIndexSetDouble(0, PLOT_EMPTY_VALUE, 0.0);
   PlotIndexSetDouble(1, PLOT_EMPTY_VALUE, 0.0);
   
//--- Set indicator name
   IndicatorSetString(INDICATOR_SHORTNAME, "ZIGZAG+Box(" + 
                      IntegerToString(InpDepth) + "," + 
                      IntegerToString(InpDeviation) + "," + 
                      IntegerToString(InpBackstep) + ")");
   
//--- Initialize buffers
   ArraySetAsSeries(ZigZagHighBuffer, true);
   ArraySetAsSeries(ZigZagLowBuffer, true);
   ArrayInitialize(ZigZagHighBuffer, 0.0);
   ArrayInitialize(ZigZagLowBuffer, 0.0);
   
   return(INIT_SUCCEEDED);
  }

//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- Delete all objects created by indicator
   DeleteAllBoxes();
  }

//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//--- Set arrays as series
   ArraySetAsSeries(high, true);
   ArraySetAsSeries(low, true);
   ArraySetAsSeries(time, true);
   
//--- Calculate from the beginning
   int limit = rates_total - prev_calculated;
   if(limit > 1)
     {
      limit = rates_total - InpDepth - 1;
      ArrayInitialize(ZigZagHighBuffer, 0.0);
      ArrayInitialize(ZigZagLowBuffer, 0.0);
      lastDirection = 0;
      lastHigh = 0;
      lastLow = 0;
      lastHighBar = -1;
      lastLowBar = -1;
     }
   
//--- Main calculation loop
   for(int i = limit; i >= 0; i--)
     {
      ZigZagHighBuffer[i] = 0.0;
      ZigZagLowBuffer[i] = 0.0;
      
      //--- Skip if not enough data
      if(i + InpDepth > rates_total - 1)
         continue;
      
      //--- Calculate highest and lowest values
      double highValue = high[ArrayMaximum(high, i, InpDepth)];
      double lowValue = low[ArrayMinimum(low, i, InpDepth)];
      
      //--- Calculate deviation threshold
      double deviationThreshold = InpDeviation / 100.0;
      
      //--- Check for high pivot
      if(lastDirection <= 0 && high[i] >= highValue)
        {
         bool checkDeviation = false;
         if(lastLow == 0)
            checkDeviation = true;
         else if(lastLow > 0 && (high[i] - lastLow) / lastLow > deviationThreshold)
            checkDeviation = true;
         
         if(checkDeviation)
           {
            if(lastLow > 0 && (rates_total - 1 - i) - lastLowBar >= InpBackstep)
              {
               //--- New high pivot found
               if(lastHigh > 0 && lastLow > 0 && lastHighBar >= 0 && lastLowBar >= 0)
                 {
                  //--- Draw line from last high to last low
                  DrawZigZagLine(lastHighBar, lastHigh, lastLowBar, lastLow, ZigZagHighBuffer, ZigZagLowBuffer);
                  
                  //--- Draw box if enabled
                  if(InpShowBoxes)
                    {
                     DrawBox(lastHighBar, lastHigh, lastLowBar, lastLow, time);
                    }
                 }
               
               lastHigh = high[i];
               lastHighBar = rates_total - 1 - i;
               lastDirection = 1;
              }
           }
        }
      
      //--- Check for low pivot
      if(lastDirection >= 0 && low[i] <= lowValue)
        {
         bool checkDeviation = false;
         if(lastHigh == 0)
            checkDeviation = true;
         else if(lastHigh > 0 && (lastHigh - low[i]) / lastHigh > deviationThreshold)
            checkDeviation = true;
         
         if(checkDeviation)
           {
            if(lastHigh > 0 && (rates_total - 1 - i) - lastHighBar >= InpBackstep)
              {
               //--- New low pivot found
               if(lastHigh > 0 && lastLow > 0 && lastHighBar >= 0 && lastLowBar >= 0)
                 {
                  //--- Draw line from last low to last high
                  DrawZigZagLine(lastLowBar, lastLow, lastHighBar, lastHigh, ZigZagHighBuffer, ZigZagLowBuffer);
                  
                  //--- Draw box if enabled
                  if(InpShowBoxes)
                    {
                     DrawBox(lastLowBar, lastLow, lastHighBar, lastHigh, time);
                    }
                 }
               
               lastLow = low[i];
               lastLowBar = rates_total - 1 - i;
               lastDirection = -1;
              }
           }
        }
      
      //--- Update last high/low if current is more extreme
      if(lastDirection > 0 && high[i] > lastHigh)
        {
         lastHigh = high[i];
         lastHighBar = rates_total - 1 - i;
        }
      
      if(lastDirection < 0 && low[i] < lastLow)
        {
         lastLow = low[i];
         lastLowBar = rates_total - 1 - i;
        }
     }
   
//--- Return value of prev_calculated for next call
   return(rates_total);
  }

//+------------------------------------------------------------------+
//| Draw ZigZag line between two points                              |
//+------------------------------------------------------------------+
void DrawZigZagLine(int bar1, double price1, int bar2, double price2,
                    double &highBuffer[], double &lowBuffer[])
  {
   int startBar = MathMax(bar1, bar2);
   int endBar = MathMin(bar1, bar2);
   
   //--- Avoid division by zero
   if(startBar == endBar)
      return;
   
   for(int i = startBar; i >= endBar; i--)
     {
      double ratio = (double)(startBar - i) / (double)(startBar - endBar);
      double price = price1 + (price2 - price1) * ratio;
      
      if(price1 < price2)
         highBuffer[i] = price;
      else
         lowBuffer[i] = price;
     }
  }

//+------------------------------------------------------------------+
//| Draw rectangle box between two points                            |
//+------------------------------------------------------------------+
void DrawBox(int bar1, double price1, int bar2, double price2, const datetime &time[])
  {
   int leftBar = MathMax(bar1, bar2);
   int rightBar = MathMin(bar1, bar2);
   
   datetime timeLeft = time[leftBar];
   datetime timeRight = time[rightBar];
   
   double topPrice = MathMax(price1, price2);
   double bottomPrice = MathMin(price1, price2);
   
   string objName = boxPrefix + IntegerToString(boxCounter++);
   
   //--- Create rectangle object
   if(ObjectCreate(0, objName, OBJ_RECTANGLE, 0, timeLeft, topPrice, timeRight, bottomPrice))
     {
      //--- Set rectangle properties
      ObjectSetInteger(0, objName, OBJPROP_COLOR, InpBoxBorder);
      ObjectSetInteger(0, objName, OBJPROP_STYLE, STYLE_SOLID);
      ObjectSetInteger(0, objName, OBJPROP_WIDTH, 1);
      ObjectSetInteger(0, objName, OBJPROP_BACK, true);
      ObjectSetInteger(0, objName, OBJPROP_FILL, true);
      
      //--- Set background color with transparency
      //--- Extract RGB components
      int r = (int)((InpBoxColor >> 0) & 0xFF);
      int g = (int)((InpBoxColor >> 8) & 0xFF);
      int b = (int)((InpBoxColor >> 16) & 0xFF);
      //--- Calculate alpha from transparency (0=opaque, 255=transparent)
      int alpha = (int)((100 - InpBoxTransparency) * 255 / 100);
      //--- Combine into ARGB color
      long colorWithAlpha = (alpha << 24) | (b << 16) | (g << 8) | r;
      ObjectSetInteger(0, objName, OBJPROP_BGCOLOR, colorWithAlpha);
      
      //--- Set selection properties
      ObjectSetInteger(0, objName, OBJPROP_SELECTABLE, false);
      ObjectSetInteger(0, objName, OBJPROP_SELECTED, false);
     }
  }

//+------------------------------------------------------------------+
//| Delete all boxes created by indicator                            |
//+------------------------------------------------------------------+
void DeleteAllBoxes()
  {
   int totalObjects = ObjectsTotal(0, 0, OBJ_RECTANGLE);
   
   for(int i = totalObjects - 1; i >= 0; i--)
     {
      string objName = ObjectName(0, i, 0, OBJ_RECTANGLE);
      
      if(StringFind(objName, boxPrefix) >= 0)
        {
         ObjectDelete(0, objName);
        }
     }
  }
//+------------------------------------------------------------------+
