# Code-Tradingview
ZIGZAG+Box Indicators for TradingView and MQL5

## Overview
This repository contains implementations of the ZIGZAG+Box indicator for both TradingView (Pine Script) and MetaTrader 5 (MQL5). The indicator identifies significant price swings and draws boxes around zigzag patterns for better visualization of market structure.

## Features
- **ZigZag Detection**: Automatically identifies significant highs and lows based on customizable parameters
- **Box Drawing**: Draws rectangular boxes between zigzag pivot points to highlight price ranges
- **Customizable Parameters**: Adjustable depth, deviation, and backstep settings
- **Visual Markers**: Triangle markers at pivot points for easy identification
- **Color Customization**: Fully customizable colors for lines, boxes, and borders

## TradingView Pine Script Indicator

### File Location
`TradingView/ZIGZAG_Box.pine`

### Installation
1. Open TradingView and navigate to the Pine Editor
2. Copy the contents of `ZIGZAG_Box.pine`
3. Paste into the Pine Editor
4. Click "Add to Chart"

### Parameters

#### ZigZag Settings
- **ZigZag Depth** (default: 12): Number of bars to look back for pivot points
- **ZigZag Deviation** (default: 5%): Minimum price movement percentage to create new pivot
- **ZigZag Backstep** (default: 3): Minimum bars between consecutive pivots

#### Box Settings
- **Show Boxes** (default: true): Enable/disable box drawing
- **Box Color**: Background color for boxes
- **Box Border Color**: Border color for boxes
- **Box Border Width** (default: 1): Width of box borders

#### Line Settings
- **ZigZag Line Color** (default: yellow): Color of zigzag lines
- **ZigZag Line Width** (default: 2): Width of zigzag lines

### Usage
- Green triangles mark low pivots
- Red triangles mark high pivots
- Yellow lines connect consecutive pivots
- Blue boxes highlight the range between pivots

## MQL5 Indicator

### File Location
`MQL5/ZIGZAG_Box.mq5`

### Installation
1. Copy `ZIGZAG_Box.mq5` to your MetaTrader 5 data folder:
   - Open MetaTrader 5
   - Click File → Open Data Folder
   - Navigate to `MQL5/Indicators/`
   - Paste the file
2. Restart MetaTrader 5 or compile the indicator
3. Find "ZIGZAG+Box" in the Navigator window under Indicators
4. Drag and drop onto a chart

### Parameters
- **ZigZag Depth** (default: 12): Number of bars for pivot detection
- **ZigZag Deviation** (default: 5%): Minimum price movement percentage
- **ZigZag Backstep** (default: 3): Minimum bars between pivots
- **Show Boxes** (default: true): Enable/disable box drawing
- **Box Color** (default: blue): Background color for boxes
- **Box Border Color** (default: blue): Border color for boxes
- **Box Transparency** (default: 80): Transparency level (0-100)

### Usage
The indicator will automatically:
- Draw zigzag lines connecting significant pivot points
- Create rectangular boxes between consecutive pivots
- Update in real-time as new bars form

## How It Works

The ZIGZAG+Box indicator works by:

1. **Pivot Detection**: Scans the price data to find significant highs and lows based on:
   - **Depth**: How many bars to analyze for finding local extremes
   - **Deviation**: Minimum percentage move required to confirm a new pivot
   - **Backstep**: Minimum distance between consecutive pivots

2. **Line Drawing**: Connects identified pivot points with lines to visualize the zigzag pattern

3. **Box Creation**: Draws rectangles between consecutive pivot points to highlight:
   - Price ranges
   - Support and resistance zones
   - Market structure

## Trading Applications

- **Trend Identification**: Identify the overall market direction
- **Support/Resistance**: Boxes highlight key price levels
- **Pattern Recognition**: Easier to spot chart patterns
- **Swing Trading**: Identify potential entry/exit points at pivots
- **Market Structure**: Understand higher highs, higher lows, etc.

## Tips for Best Results

1. **Adjust Depth**: Lower values (5-8) for more sensitive detection, higher values (15-20) for major swings
2. **Tune Deviation**: Higher values filter out minor moves, lower values catch smaller swings
3. **Backstep Setting**: Prevents the indicator from switching direction too frequently
4. **Timeframe Selection**: Works on all timeframes, but results vary
   - Lower timeframes: More pivots, more boxes
   - Higher timeframes: Fewer pivots, clearer major structure

## Version Information
- **TradingView Pine Script**: Version 5
- **MQL5**: Compatible with MetaTrader 5 build 2600+

## License
This code is provided for educational and trading purposes.

## Support
For issues, questions, or suggestions, please open an issue in this repository.
