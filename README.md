# Steps for Assignment
- Install Postgresql and pgAdmin 4
- Install Python3 and Jupyter Notebook
# Part 1 SQL
**1.1 Query SQL Code for database and table creation**
- Created a user named 'admin' and database named 'test'. Granted all privileges to the 'admin' user to 'test' database
- Created 3 Tables - installs, revenue and spend
- Load each CSV file into each table by right click on Import/Export Data... on table created. Example - On revenue table right click on Import/Export Data... Choose file name revenue and Click OK 
- Refer **DatabaseandTable.sql** file for database and table creation

  
**1.2 Summary Table**
  - Refer **Summary.sql** for SQL code and **Summary.csv** which contains columns for Ad Spend, Installs, CPI, ARPI_D1, ARPI_D14, ROAS_D14 for each client(app), country and install date between 01-12-2021 and 15-12-2021.

# Part 2 EDA
In Python3 install libraries such as pandas matplotlib seaborn by using pip install command
- Check **eda.ipynb** for visualization and recommendations

# Part 3 LTV
Check **ltv.ipynb** for LTV prediction. Below is 
**LTV Estimation Approach**
- Used ARPI_D1 and ARPI_D14 from summary.csv for US users in Fruit Battle.
- Fitted a linear regression to extrapolate ARPI to day 28 (assumed user lifetime).
- Estimated LTV as ARPI_D28 from the regression.
- Visualized the ARPI curve and regression fit.

# Part 4. AB Testing
Check **abtest.ipynb**

**Explanation**
- Calculates ARPI_D1 and D1 Retention rates for both groups.
- Performs two-sample t-test for ARPI_D1 and z-test for proportions for D1 Retention.

**Recommendation**
- Statistical Significance:
  
           ARPI_D1: Significant
           D1 Retention: Significant

- Power:

          ARPI_D1: Insufficient
          D1 Retention: Sufficient

- Should the feature be rolled out?

         No, more data or further testing is needed.

  
- Is there enough evidence?
  
          No

          
- If not significant, what next?
  
         Increase sample size or run the test longer to achieve sufficient power and statistical significance.
  
