# ZigZag with KCQT and HTQT Zones - Indicator Guide

## Overview

This Pine Script indicator combines a traditional ZigZag pattern detector with two types of critical trading zones:
- **KCQT (Key Critical Zones)**: Major support/resistance levels based on confirmed swing points
- **HTQT (Trend Zones)**: Intermediate trend zones based on smaller swing movements

## Features

### 1. ZigZag Pattern Detection
- Automatically identifies swing highs and lows in price movement
- Configurable sensitivity through length and depth parameters
- Visual line drawing between pivot points
- Maintains swing history for zone calculations

### 2. KCQT (Key Critical Zones)
- **Purpose**: Identify critical price levels where major reversals occurred
- **Calculation**: Based on confirmed swings that meet a minimum threshold percentage
- **Visual**: Displayed as colored boxes around major swing points
  - Green boxes: Bullish KCQT (support zones from swing lows)
  - Red boxes: Bearish KCQT (resistance zones from swing highs)
- **Characteristics**:
  - Larger zone height (0.5% of price)
  - Higher threshold requirement (default 3%)
  - Represents more significant price levels

### 3. HTQT (Trend Zones)
- **Purpose**: Identify intermediate trend zones and potential reversal areas
- **Calculation**: Based on intermediate swings smaller than KCQT but above minimum threshold
- **Visual**: Displayed as colored boxes around intermediate swing points
  - Blue boxes: Bullish HTQT (support zones)
  - Orange boxes: Bearish HTQT (resistance zones)
- **Characteristics**:
  - Smaller zone height (0.3% of price)
  - Lower threshold requirement (default 2%)
  - Represents intermediate trend changes

## Input Parameters

### ZigZag Settings
- **ZigZag Length** (default: 13)
  - Number of bars to look left and right for pivot detection
  - Higher values = fewer, more significant pivots
  - Lower values = more frequent, smaller pivots

- **ZigZag Depth** (default: 5.0%)
  - Minimum price change percentage to form a new swing
  - Higher values = filter out smaller price movements
  - Lower values = more sensitive to price changes

### Zone Settings
- **Show KCQT/HTQT Zones** (default: false)
  - Master toggle to enable/disable zone display
  - When disabled, only ZigZag lines are shown
  - When enabled, displays both KCQT and HTQT zones

- **KCQT Threshold** (default: 3.0%)
  - Minimum swing size to qualify as a Key Critical Zone
  - Higher values = fewer, more significant KCQT zones
  - Should be larger than HTQT threshold

- **HTQT Threshold** (default: 2.0%)
  - Minimum swing size to qualify as a Trend Zone
  - Higher values = fewer HTQT zones
  - Should be smaller than KCQT threshold

### Visual Settings
- **KCQT Bullish Color** (default: transparent green)
  - Color for bullish KCQT support zones
  
- **KCQT Bearish Color** (default: transparent red)
  - Color for bearish KCQT resistance zones

- **HTQT Bullish Color** (default: transparent blue)
  - Color for bullish HTQT support zones

- **HTQT Bearish Color** (default: transparent orange)
  - Color for bearish HTQT resistance zones

- **Show ZigZag Lines** (default: true)
  - Toggle to show/hide ZigZag connecting lines

- **ZigZag Line Color** (default: gray)
  - Color of ZigZag lines connecting pivots

## How to Use

### Installation
1. Open TradingView and create a new chart
2. Click on "Pine Editor" at the bottom of the screen
3. Copy the contents of `zigzag_kcqt_htqt.pine`
4. Paste into the Pine Editor
5. Click "Add to Chart"

### Basic Usage
1. **Start with ZigZag only**: Keep `show_KCQT_HTQT` disabled initially
   - Observe how the indicator identifies swing points
   - Adjust `ZigZag Length` to match your timeframe and trading style

2. **Enable KCQT/HTQT Zones**: Set `show_KCQT_HTQT` to true
   - Green/blue boxes indicate support zones (potential buy areas)
   - Red/orange boxes indicate resistance zones (potential sell areas)

3. **Adjust Thresholds**: Fine-tune zone sensitivity
   - Increase thresholds to see only major zones
   - Decrease thresholds to see more frequent zones

### Trading Applications

#### Support and Resistance
- **KCQT zones** (green/red) mark major support/resistance levels
- Price often reacts when approaching these zones
- Look for price rejection or breakthrough at these levels

#### Trend Analysis
- **HTQT zones** (blue/orange) show intermediate trend levels
- Useful for identifying trend continuation or reversal points
- Can be used for entry/exit points in trending markets

#### Zone Confluence
- When multiple zones overlap or are close together, it indicates a stronger level
- The indicator prevents exact overlaps but close zones suggest importance

#### Risk Management
- Use KCQT zones to set stop-loss levels
- Use HTQT zones for profit targets in swing trades
- Zones extending to the right help anticipate future price reactions

## Technical Details

### Swing Detection Algorithm
- Uses TradingView's built-in `ta.pivothigh()` and `ta.pivotlow()` functions
- Maintains arrays of historical swing points (up to 50 swings)
- Updates zones dynamically as new pivots are confirmed

### Zone Creation Logic
- **KCQT**: Created when a swing is confirmed by opposite swing formation
- **HTQT**: Created from intermediate swings in recent history
- Zones extend to the right of the chart to show ongoing relevance

### Overlap Prevention
- Checks for existing zones before creating new ones
- Prevents clutter by avoiding duplicate zones at similar price levels
- Maintains a maximum of 20 boxes per zone type

### Performance Optimization
- Limited swing history (50 maximum)
- Limited box count (20 per zone type)
- Efficient array operations using shift() for old data removal

## Best Practices

1. **Timeframe Selection**: 
   - Higher timeframes (4H, Daily) = more reliable zones
   - Lower timeframes (5m, 15m) = more frequent but less significant zones

2. **Parameter Tuning**:
   - Volatile markets: Increase thresholds
   - Range-bound markets: Decrease thresholds
   - Match ZigZag length to your trading timeframe

3. **Confirmation**:
   - Don't trade zones in isolation
   - Combine with other indicators (volume, momentum, etc.)
   - Wait for price action confirmation at zones

4. **Zone Age**:
   - Older zones may be less relevant
   - Fresh zones from recent swings are often more significant
   - Monitor how price reacts when revisiting zones

## Limitations

- Zones are based on historical price action and don't predict future movements
- Requires sufficient price history to generate meaningful zones
- The indicator repaints as new pivots are confirmed (inherent to ZigZag)
- Maximum of 500 boxes and 500 lines can be displayed at once

## Troubleshooting

**Problem**: No zones appearing
- **Solution**: Enable `show_KCQT_HTQT` input
- **Solution**: Decrease threshold percentages
- **Solution**: Ensure enough historical data is loaded

**Problem**: Too many zones cluttering the chart
- **Solution**: Increase KCQT and HTQT threshold values
- **Solution**: Increase ZigZag length parameter
- **Solution**: Switch to a higher timeframe

**Problem**: Zones don't extend far enough
- **Solution**: Zones automatically extend to the right
- **Solution**: Check if boxes have been deleted (max 20 per type)

## Version History

- **v1.0**: Initial release with ZigZag, KCQT, and HTQT zones
  - Full swing detection and tracking
  - Dynamic zone creation and management
  - Overlap prevention
  - Comprehensive input controls

## Support

For issues or questions about this indicator:
1. Review this documentation thoroughly
2. Check input parameters are configured correctly
3. Verify the indicator is added to the correct chart
4. Ensure you're using Pine Script version 5

## License

This indicator is provided as-is for educational and trading purposes.
