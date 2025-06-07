# Steps for Assignment
- Install Postgresql and pgAdmin 4
- Install Python3 and Jupyter Notebook
# Part 1 SQL
**1.1 Query SQL Code for database and table creation**
- Created a user named 'admin' and database named 'test'. Granted all privileges to the 'admin' user to 'test' database
- Created 3 Tables - installs, revenue and spend
- Load each CSV file into each table by right click on Import/Export Data... on table created. Example - On revenue table right click on Import/Export Data... Choose file name revenue and Click OK 
- Refer **DatabaseandTable.sql** file for database and table creation

  
**1.2 Summary Table & SQL code**


Check **summary.sql**

#### We want all revenue events for a given installed user within 14 days after their install date. So in total revenue calculation which is used for ARPI_D[N], the revenue date is not filtered BETWEEN '2021-12-01' AND '2021-12-15'. 
- That would exclude revenue for users who installed on 2021-12-15 but earned revenue on 2021-12-16 or later (which is within D14). 
- It would cut off valid D1 and D14 revenue, especially toward the end of your install window. eg: 2021-12-15 → 2021-12-29 (D14)

### summary2.sql  also works
- as the days subtraction (revenue day - install day) doesn't lead to negative values  as the last day is Dec 15th and 14 days ahead is still in the same year 2021 and not extending to next month. 
- If the data asked is between 1 dec and Dec 28th 2021 and revenue for next 14 days, then summary_alternative query would not work and only summary.sql works, as days substraction will give negative values.

## Section 1.2: Summary table - csv
Check **summary.csv** file

# Part 2 EDA
In Python3 install libraries such as pandas matplotlib seaborn by using pip install command

Check **eda.ipynb** for visualization and recommendations

# Part 3 LTV prediction

Check **ltv.ipynb** for visualization

**Approach**:
- Load and filter data: Use summary.csv, filter for fruit_battle, country == US, and install dates between 2021-12-01 and 2021-12-15.
- Prepare ARPI values: For each install date, get arpi_d1 and arpi_d14 (average revenue per install at day 1 and day 14) and caluclate the mean arpi_d1 and arpi_d14.
- Use linear regression with points (1, ARPI_D1) and (14, ARPI_D14). 
- Extrapolate to predict overall ARPI at day 28, which serves as the estimated LTV.
- Visualize: Plot ARPI over time and show the regression line extended to day 28 to visualize the LTV estimate.

**Estimated LTV (ARPI_D28) for US: 0.528*

# Part 4. AB Testing

Check **abtest.ipynb** for recommendations

Explanation:
- Calculates ARPI_D1 and D1 Retention rates for both groups.
- Performs a two-sample t-test for ARPI_D1 and a z-test for proportions for D1 Retention.
- Calculates statistical power for both metrics.
- Recommendation is based on significance and power.

#### Recommendation

- **Statistical Significance:**
    - ARPI_D1: Significant
    - D1 Retention: Significant
- **Power:**
    - ARPI_D1: Insufficient
    - D1 Retention: Sufficient

- **Should the feature be rolled out?**
    -  No, more data or further testing is needed.

- **Is there enough evidence?**
    - No

- **If not significant, what next?**
    - Increase sample size to achieve sufficient power and statistical significance.
