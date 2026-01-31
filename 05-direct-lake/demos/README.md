# Demos: Direct Lake

[← Back to Section 5: Direct Lake](../README.md)

---

## Demo 1: Create a Direct Lake Semantic Model

### Setup Required
- Lakehouse with data (from Section 3-4)
- Multiple tables with relationships possible

### Demo Script

1. **Create semantic model from Lakehouse**
   - Open your `sales_lakehouse`
   - Click **New semantic model** (top toolbar)
   - Select tables to include
   - Click **Confirm**

2. **Open in modeling view**
   - The model opens automatically
   - Notice: It's Direct Lake mode by default
   - No "Import" option - data stays in Lakehouse

3. **Create relationships**
   - Drag to connect related tables
   - Configure cardinality
   - Same experience as traditional modeling

4. **Add measures**
   - Select a table
   - New measure:
   ```dax
   Total Sales = SUM(Sales[Amount])
   ```
   - Add another:
   ```dax
   YoY Growth = 
   VAR CurrentYear = [Total Sales]
   VAR PreviousYear = CALCULATE([Total Sales], SAMEPERIODLASTYEAR('Date'[Date]))
   RETURN DIVIDE(CurrentYear - PreviousYear, PreviousYear)
   ```

5. **Build a test report**
   - Click **New report**
   - Add some visuals
   - "It just works - but no refresh needed!"

### Key Points to Highlight
- Model creation is familiar
- Direct Lake is automatic (not a setting)
- No scheduled refresh configuration

---

## Demo 2: Performance Comparison

### Setup Required
- Direct Lake model from Demo 1
- Optional: Import model with same data (for comparison)
- DAX Studio or Performance Analyzer

### Demo Script

1. **Set up comparison**
   - Have both models open (if possible)
   - Or use timestamps/stopwatch

2. **Run equivalent queries**
   - Simple aggregation
   - Complex calculation with filters
   - Large result set

3. **Compare timings**
   - Direct Lake: First query may be slower (warming)
   - Subsequent queries: Near-import speed
   - Show caching effect

4. **Discuss tradeoffs**
   - Import: Fastest queries, but stale data
   - DirectQuery: Live data, but slowest queries
   - Direct Lake: Live data, near-import speed

### Key Points to Highlight
- First query "warms" the cache
- Subsequent queries are fast
- No ETL/refresh time to account for

---

## Demo 3: Monitor Fallback Behavior

### Setup Required
- Direct Lake model
- Query that triggers fallback (prepared)
- SQL Server Profiler or equivalent

### Demo Script

1. **Explain fallback**
   - "Sometimes Direct Lake can't handle a query"
   - "It 'falls back' to DirectQuery mode"
   - "This is slower - we want to avoid it"

2. **Create a fallback scenario**
   - Use unsupported DAX (varies by version)
   - Or query that exceeds memory
   - Examples that may cause fallback:
     - Very wide tables
     - Certain calculated columns
     - Specific DAX patterns

3. **Show detection**
   - Use Performance Analyzer in Power BI
   - Look for DirectQuery indicators
   - Show the query took longer

4. **Fix the issue**
   - Refactor DAX
   - Move calculation to Lakehouse
   - Re-run and verify no fallback

### Key Points to Highlight
- Fallback isn't an error - but impacts performance
- Monitor for unexpected fallbacks
- DAX skills still matter!

---

## Demo Tips

- Have a "warm" model ready (pre-queried) for faster demo
- If you don't have two models for comparison, use estimated timings
- Fallback behavior changes with Fabric updates - test beforehand
