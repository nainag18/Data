# Steps for Assignment
- Install Postgresql and pgAdmin 4
- Install Python3 and Jupyter Notebook
# Part 1 SQL
## Section 1.1: Query SQL Code for database and associated tables
- Created a user named 'admin' and database named 'test'. Granted all privileges to the 'admin' user to 'test' database
- For database creation- **Check DatabaseandTable.sql**

          hostname: localhost
          port: 5432
          username: admin
          password: admin
          db: test

Due to large file size and to avoid data loss, the **tableimport.ipynb** is used to import csv files and 
convert to postgresql tables.

### spend table
- Total imported number of rows : 102

### installs table

- Total imported number of rows : 81752 
### revenue table

- Total imported number of rows : 2126539
  
## Section 1.2: SQL code and Summary Table csv


Check **Summary.sql**

This query calculates metrics for install cohorts between December 1–15, 2021, grouped by client and country. It computes total installs, ad spend, and revenue on Day 1 and Day 14 using subqueries. Then it derives key KPIs like CPI, ARPI_D1/D14, and ROAS_D14 by joining the subqueries on install dates and client-country details.

#### We want to capture all revenue events that occur within 14 days of a user's install date. Therefore, when calculating total revenue for ARPI_D[N], not restricting the revenue date to just '2021-12-01' to '2021-12-15'.
- Filtering revenue by this range would exclude valid revenue from users who installed on '2021-12-15' but generated revenue on later dates, like '2021-12-16' or beyond but still within their 14-day window.
- This would result in underreporting ARPI_D1 and ARPI_D14 metrics, particularly for users who installed near the end of the selected install period (e.g., Dec 15 installs would have D14 revenue up to Dec 29).

**Summary2.sql**  - Alternate Query

This SQL query calculates daily marketing performance metrics (like installs, ad spend, CPI, ARPI, and ROAS) by client and country from Dec 1 to Dec 15, 2021. It joins installs, spend, and revenue tables to compute user acquisition cost and revenue within 1 and 14 days of install.

- As the days subtraction (revenue day - install day) doesn't lead to negative values  as the last day is Dec 15th and 14 days ahead is still in the same year 2021 and not extending to next month. 
- If the data asked is between 1 Dec and Dec 28th 2021 and revenue for next 14 days, then summary_alternative query would not work and only summary.sql works, as days substraction will give negative values.


Check **summary.csv** file for Summary Table

 Summary table shows Ad Spend, Installs, CPI, ARPI_D1, ARPI_D14, and ROAS_D14 grouped by app (client), country, and install date.

# Part 2 EDA
In Jupyter Notebook install libraries such as pandas matplotlib seaborn numpy by using pip install command

Check **eda.ipynb** for visualization and recommendations

This script analyzes the top 3 countries for the Fruit Battle app by average ARPI_D14 within a specific install period, summarizing key metrics like installs, ad spend, ROAS, and CPI. It then visualizes these metrics over time and provides recommendations based on ROAS performance.

# Part 3 LTV prediction

Check **ltv.ipynb** for visualization

This script loads Fruit Battle data for the US, calculates average ARPI on Day 1 and Day 14, and uses linear regression to estimate ARPI on Day 28 (LTV). It then visualizes ARPI progression and prints the estimated LTV value.

**Approach**:
- Load and filter data: Use summary.csv, filter for fruit_battle, country == US, and install dates between 2021-12-01 and 2021-12-15.
- Prepare ARPI values: For each install date, get arpi_d1 and arpi_d14 (average revenue per install at day 1 and day 14) and caluclate the mean arpi_d1 and arpi_d14.
- Use linear regression with points (1, ARPI_D1) and (14, ARPI_D14). 
- Extrapolate to predict overall ARPI at day 28, which serves as the estimated LTV.
- Visualize: Plot ARPI over time and show the regression line extended to day 28 to visualize the LTV estimate.

 **Estimated LTV (ARPI_D28) for US: 0.528**

# Part 4. AB Testing

Check **abtesting.ipynb** for recommendations

This script calculates ARPI_D1 and Day 1 retention rates for control and test groups in an A/B test, then performs statistical tests to de check for significant differences. It computes effect sizes and power to evaluate if the sample size is adequate. Also, it summarizes the test results and gives rollout recommendations based on significance and power thresholds.

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
