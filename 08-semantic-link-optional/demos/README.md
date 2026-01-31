# Demos: Semantic Link

## Demo 1: Connect to Semantic Model from Notebook

### Setup Required
- Fabric workspace with semantic model (from Section 5)
- Access to Fabric notebooks

### Demo Script

1. **Create a new notebook**
   - In workspace, click **+ New** → **Notebook**
   - Name: `Semantic Link Demo`

2. **Import the library**
   ```python
   import sempy.fabric as fabric
   ```
   - Run the cell
   - Note: sempy is pre-installed in Fabric notebooks

3. **List available semantic models**
   ```python
   # List all semantic models you can access
   datasets = fabric.list_datasets()
   display(datasets)
   ```
   - Show the output
   - Point out your model in the list

4. **Read a table**
   ```python
   # Read Products table into a DataFrame
   products_df = fabric.read_table(
       dataset="Sales Analytics Model",
       table="Products"
   )
   display(products_df.head(10))
   ```
   - "This is now a pandas DataFrame!"
   - "All the normal pandas operations work"

### Key Points to Highlight
- No connection string needed
- Uses your Fabric identity
- Semantic model is now a data source

---

## Demo 2: Run DAX Query, Get DataFrame

### Setup Required
- Notebook from Demo 1
- Semantic model with measures

### Demo Script

1. **Execute a simple DAX query**
   ```python
   # Run DAX and get results
   results = fabric.evaluate_dax(
       dataset="Sales Analytics Model",
       dax_string="""
           EVALUATE
           SUMMARIZECOLUMNS(
               'Products'[Category],
               "Total Sales", [Total Sales],
               "Avg Sale", [Average Sale]
           )
       """
   )
   display(results)
   ```
   - "The DAX runs server-side"
   - "Results come back as a DataFrame"
   - "Your measures are preserved!"

2. **Add filtering**
   ```python
   # DAX with filters
   filtered_results = fabric.evaluate_dax(
       dataset="Sales Analytics Model",
       dax_string="""
           EVALUATE
           FILTER(
               SUMMARIZECOLUMNS(
                   'Products'[Category],
                   "Total Sales", [Total Sales]
               ),
               [Total Sales] > 10000
           )
       """
   )
   display(filtered_results)
   ```

3. **Use the DataFrame for analysis**
   ```python
   # Now use pandas!
   import matplotlib.pyplot as plt
   
   # Sort and plot
   results_sorted = results.sort_values('Total Sales', ascending=False)
   
   plt.figure(figsize=(10, 6))
   plt.bar(results_sorted['Category'], results_sorted['Total Sales'])
   plt.title('Sales by Category')
   plt.xticks(rotation=45)
   plt.tight_layout()
   plt.show()
   ```

### Key Points to Highlight
- Measures calculate on server (efficient)
- Results are normal DataFrames
- Can immediately visualize or analyze

---

## Demo 3: Simple ML/Analysis Example *(optional)*

### Setup Required
- Notebook with data from Demo 2
- Basic ML libraries (pre-installed in Fabric)

### Demo Script

1. **Get historical data for analysis**
   ```python
   # Get sales over time
   sales_by_month = fabric.evaluate_dax(
       dataset="Sales Analytics Model",
       dax_string="""
           EVALUATE
           SUMMARIZECOLUMNS(
               'Date'[Year],
               'Date'[Month],
               "Total Sales", [Total Sales]
           )
           ORDER BY 'Date'[Year], 'Date'[Month]
       """
   )
   display(sales_by_month)
   ```

2. **Simple trend analysis**
   ```python
   # Calculate month-over-month change
   sales_by_month['MoM_Change'] = sales_by_month['Total Sales'].pct_change()
   sales_by_month['Rolling_Avg'] = sales_by_month['Total Sales'].rolling(3).mean()
   
   display(sales_by_month)
   ```

3. **Basic forecasting (if time)**
   ```python
   from sklearn.linear_model import LinearRegression
   import numpy as np
   
   # Simple linear trend
   X = np.arange(len(sales_by_month)).reshape(-1, 1)
   y = sales_by_month['Total Sales'].values
   
   model = LinearRegression()
   model.fit(X, y)
   
   # Predict next 3 months
   future_X = np.arange(len(sales_by_month), len(sales_by_month) + 3).reshape(-1, 1)
   predictions = model.predict(future_X)
   
   print("Forecasted sales:", predictions)
   ```

### Key Points to Highlight
- Business logic (measures) from semantic model
- ML/analysis in Python
- No need to rebuild calculations

---

## Demo Tips

- Pre-run the notebook to ensure libraries load
- Use a simple semantic model (fewer tables = clearer demo)
- Have DAX queries written and tested beforehand
