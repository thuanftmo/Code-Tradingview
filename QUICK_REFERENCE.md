# Quick Reference Guide

## Visual Indicator Components

```
Price Chart
│
├─ ZigZag Lines (Gray)
│  └─ Connects swing highs and lows
│
├─ KCQT Zones (Major Critical Zones)
│  ├─ 🟩 Green Boxes = Bullish KCQT (Support)
│  │  └─ Formed at major swing lows (≥3% moves)
│  │
│  └─ 🟥 Red Boxes = Bearish KCQT (Resistance)
│     └─ Formed at major swing highs (≥3% moves)
│
└─ HTQT Zones (Trend Zones)
   ├─ 🟦 Blue Boxes = Bullish HTQT (Support)
   │  └─ Formed at intermediate swing lows (2-3% moves)
   │
   └─ 🟧 Orange Boxes = Bearish HTQT (Resistance)
      └─ Formed at intermediate swing highs (2-3% moves)
```

## How Zones Are Created

### KCQT Zone Formation:
```
Step 1: Price forms a swing high
        ↓
Step 2: Price reverses and forms a swing low (confirms the high)
        ↓
Step 3: Check if swing size ≥ KCQT threshold (3%)
        ↓
Step 4: Create red KCQT box around the swing high
        ↓
Step 5: Box extends to the right for future reference
```

### HTQT Zone Formation:
```
Step 1: Analyze recent swing history (up to 5 swings)
        ↓
Step 2: Find intermediate swings (2-3% range)
        ↓
Step 3: Create blue/orange HTQT box around swing point
        ↓
Step 4: Box extends to the right for future reference
```

## Parameter Quick Reference

| Parameter | Default | Purpose | Range |
|-----------|---------|---------|-------|
| show_KCQT_HTQT | false | Master toggle for zones | true/false |
| zigzag_length | 13 | Swing detection sensitivity | 1-100 |
| kcqt_threshold | 3.0% | Minimum for KCQT zones | 0.1%-20% |
| htqt_threshold | 2.0% | Minimum for HTQT zones | 0.1%-20% |

## Common Settings by Timeframe

### Scalping (1m - 5m)
```
zigzag_length: 5-8
kcqt_threshold: 1.5-2.0%
htqt_threshold: 0.8-1.2%
```

### Day Trading (15m - 1h)
```
zigzag_length: 10-13
kcqt_threshold: 2.5-3.5%
htqt_threshold: 1.5-2.5%
```

### Swing Trading (4h - Daily)
```
zigzag_length: 13-21
kcqt_threshold: 3.0-5.0%
htqt_threshold: 2.0-3.5%
```

### Position Trading (Weekly)
```
zigzag_length: 21-34
kcqt_threshold: 5.0-8.0%
htqt_threshold: 3.0-5.0%
```

## Trading Signals

### Strong Support/Resistance:
```
Multiple zones overlapping or close together
= Higher probability of price reaction
```

### Zone Breakout:
```
Price closes above/below zone with volume
= Potential trend continuation
```

### Zone Rejection:
```
Price enters zone and reverses (with wick)
= Potential reversal opportunity
```

## Color Guide

| Color | Zone Type | Direction | Meaning |
|-------|-----------|-----------|---------|
| 🟩 Green | KCQT | Bullish | Major support level |
| 🟥 Red | KCQT | Bearish | Major resistance level |
| 🟦 Blue | HTQT | Bullish | Intermediate support |
| 🟧 Orange | HTQT | Bearish | Intermediate resistance |
| ⬜ Gray | ZigZag | Neutral | Swing connections |

## Zone Hierarchy

```
Strength Level (Highest to Lowest):

1. KCQT Zones (Major)
   - Larger boxes (0.5% height)
   - Higher threshold (3%+)
   - More significant price levels
   - Better for stop-loss placement

2. HTQT Zones (Intermediate)
   - Smaller boxes (0.3% height)
   - Lower threshold (2%+)
   - Trend continuation/reversal
   - Better for profit targets
```

## Checklist for New Users

- [ ] Load indicator on chart
- [ ] Start with `show_KCQT_HTQT = false` to see ZigZag only
- [ ] Enable `show_KCQT_HTQT = true`
- [ ] Observe green/blue (support) and red/orange (resistance) zones
- [ ] Adjust `zigzag_length` to match your chart timeframe
- [ ] Fine-tune thresholds to control zone frequency
- [ ] Test on historical data before live trading
- [ ] Combine with other indicators for confirmation

## Tips for Best Results

### 1. Timeframe Matching
```
Match zigzag_length to your trading timeframe
Higher timeframe = higher length value
```

### 2. Threshold Tuning
```
Too many zones? → Increase thresholds
Too few zones? → Decrease thresholds
```

### 3. Confluence
```
Look for zones that align with:
- Fibonacci levels
- Round numbers (e.g., 50000, 100)
- Moving averages
- Volume profile POCs
```

### 4. Zone Age
```
Recent zones (fresh) > Old zones (stale)
Monitor how price reacts when revisiting zones
```

## Common Questions

**Q: Why aren't zones showing?**
A: Ensure `show_KCQT_HTQT` is enabled and thresholds aren't too high.

**Q: Too many zones on my chart?**
A: Increase threshold values or zigzag_length parameter.

**Q: Zones overlapping?**
A: The indicator prevents exact overlaps, but close zones indicate strong levels.

**Q: Can I use this for automated trading?**
A: The indicator provides visual zones. Automation requires additional scripting.

**Q: Does the indicator repaint?**
A: Yes, inherent to ZigZag as pivots are confirmed after the fact.

## Example Trade Setup

### Bullish Setup (Long Entry):
```
1. Price approaching green KCQT zone (major support)
2. Blue HTQT zone nearby for confluence
3. Wait for price reaction (rejection candle)
4. Enter long on confirmation
5. Stop-loss below KCQT zone
6. Target next KCQT/HTQT resistance zone
```

### Bearish Setup (Short Entry):
```
1. Price approaching red KCQT zone (major resistance)
2. Orange HTQT zone nearby for confluence
3. Wait for price reaction (rejection candle)
4. Enter short on confirmation
5. Stop-loss above KCQT zone
6. Target next KCQT/HTQT support zone
```

## Risk Warning

⚠️ **Important**: 
- Zones show historical support/resistance levels
- Past performance doesn't guarantee future results
- Always use proper risk management
- Never risk more than you can afford to lose
- Test thoroughly on demo account first
- Combine with other analysis methods
- Markets can change behavior over time

---

For detailed documentation, see **INDICATOR_GUIDE.md**
For implementation details, see **IMPLEMENTATION_SUMMARY.md**
