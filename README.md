# TradingView Pine Script Indicator

## ZigZag with KCQT and HTQT Zones

A comprehensive Pine Script indicator for TradingView that combines ZigZag pattern detection with Key Critical Zones (KCQT) and Trend Zones (HTQT) visualization.

### Features

- **ZigZag Pattern Detection**: Automatically identifies swing highs and lows
- **KCQT (Key Critical Zones)**: Major support/resistance levels from confirmed swings
- **HTQT (Trend Zones)**: Intermediate trend zones from smaller swing movements
- **Dynamic Zone Updates**: Zones update in real-time as new price data arrives
- **Overlap Prevention**: Smart algorithm prevents cluttered zone displays
- **Customizable Visualization**: Full control over colors, thresholds, and display options

### Files

- `zigzag_kcqt_htqt.pine` - Main indicator script (Pine Script v5)
- `INDICATOR_GUIDE.md` - Comprehensive user guide with usage instructions

### Quick Start

1. Open TradingView and create a chart
2. Open Pine Editor
3. Copy contents from `zigzag_kcqt_htqt.pine`
4. Click "Add to Chart"
5. Configure settings as needed (see INDICATOR_GUIDE.md)

### Configuration

Key input parameters:
- `show_KCQT_HTQT` - Toggle zones on/off (default: false)
- `kcqt_threshold` - Minimum swing size for KCQT zones (default: 3.0%)
- `htqt_threshold` - Minimum swing size for HTQT zones (default: 2.0%)
- `zigzag_length` - Pivot detection sensitivity (default: 13)

### Documentation

For detailed documentation, configuration options, and usage examples, see [INDICATOR_GUIDE.md](INDICATOR_GUIDE.md)

### Requirements

- TradingView account (free or paid)
- Pine Script version 5
- Chart with sufficient historical data

### License

This project is provided as-is for educational and trading purposes.
