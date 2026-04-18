# World Layoffs Data Analysis(SQL + Power BI)
Cleaned and transformed world layoffs dataset using SQL by removing duplicates, standardizing data and handling missing values for analysis

## Project Overview 
This project focuses on cleaning a real-world layoffs dataset using SQL.
The goal is to uncover insights about layoffs across companies,industries,countries and time

## Tools Used
-- MySQL
-- Power BI

## Data Cleaning Steps (SQL)
-- Removed duplicates records using row_number()
-- Standardized text fields (company, industry, country)
-- Handled inconsistent date formats
-- Managed missing values using self- joins and filtering 
-- Created a cleaned table: clean_layoffs

## Exploratoty Data Analysis (SQl)
-- Total layoffs across dataset
-- Maximum layoffs and Percentage laid off
-- Top 10 companies by layoffs
-- Layoffs by industry
-- Layoffs by company
-- Year-wise and Month-wise trends
-- Companies with 100% layoffs
-- Relationship between funding and layoffs

## Dashboard Features (Power BI)
1. KPI Cards:
   -Total layoffs
   -Max Layoffs
   -Total Companies
3. Visualizations:
   -Layoffs by Year(Trend)
   -Layoffs by Month
   -Top 10 Companies
   -Layoffs by Industries
   -Layoffs by Country
   -Funding vs Layoffs(Scatter Plot)
5. Filters(Slicers):
   -Year
   -Industry
   -Country
   
## Key Insights
  -Layoffs peaked in 2022, indicating post-pandemic economic correction.
  -Counsumer and Retail industries were most effected
  -United States had highest layoffs
  -Some companies had 100% workforce layoffs
  -Higher funding does not always prevent layoffs
  
## Conclusion
The analysis shows that layoffs are influenced by economic conditions,industry trends, and company-level decisions. This project demonstrates
strong skills in SQL, data cleaning, and Dashboard creation

## Dashboard Preview
![Dashboard](Dashboard(Power BI).png)
