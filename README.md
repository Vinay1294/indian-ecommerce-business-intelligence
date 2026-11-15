# Indian E-Commerce Business Intelligence & Customer Analytics

An end-to-end data analytics portfolio project exploring a **synthetic
Indian e-commerce dataset** using Python, MySQL, and Power BI. The
project covers data inspection and cleaning, relational data validation,
SQL-based business analysis, and interactive dashboard reporting.

> **Data disclaimer:** The datasets used in this project are synthetic
> sample data. They do not represent the actual transactions, customers,
> or performance of a real company.

## Project Objectives

-   Inspect and understand multiple related e-commerce datasets.
-   Assess data quality, including missing values, duplicates, primary
    keys, foreign keys, and business rules.
-   Prepare cleaned datasets for analysis.
-   Load the datasets into a relational MySQL database.
-   Analyse sales, products, customers, payments, delivery, returns,
    reviews, and marketing campaigns.
-   Present business metrics and findings through a six-page Power BI
    report.

## Tools and Technologies

  -----------------------------------------------------------------------
  Tool                                Project use
  ----------------------------------- -----------------------------------
  Python                              Dataset inspection, data cleaning,
                                      validation, and export

  Pandas                              Tabular data processing

  Jupyter Notebook                    Python analysis workflow

  MySQL 8.4                           Relational database, data
                                      validation, and SQL analysis

  Power BI                            Data model, DAX measures,
                                      interactive visuals, and dashboards

  GitHub                              Project versioning and portfolio
                                      presentation
  -----------------------------------------------------------------------

## Dataset Overview

The project contains nine business datasets:

  -----------------------------------------------------------------------
  Dataset                             Description
  ----------------------------------- -----------------------------------
  `customers`                         Customer attributes and
                                      customer-level metrics

  `orders`                            Order-level transaction details

  `order_items`                       Products and quantities included in
                                      orders

  `products`                          Product attributes, categories, and
                                      pricing

  `payments`                          Payment methods, statuses, amounts,
                                      and refunds

  `shipments`                         Shipment and delivery information

  `returns`                           Returned items/orders and refund
                                      information

  `customer_reviews`                  Customer ratings and review
                                      sentiment

  `marketing_campaigns`               Campaign channels, conversions,
                                      costs, and revenue
  -----------------------------------------------------------------------

Two supporting files are also provided with the raw data:
`data_dictionary` and `dataset_validation_report`.

## Data Preparation and Validation

The Python workflow was used to inspect the nine datasets, check data
quality, convert date fields, handle selected missing values, and export
cleaned CSV files.

Recorded validation results:

-   9 datasets inspected.
-   0 full-row duplicates found across the datasets.
-   9 primary-key checks passed.
-   11 foreign-key reference checks passed.
-   9 business-rule checks passed.
-   **38 checks passed and 0 failed** in the recorded validation
    summary.

Missing values were handled according to the data context. Some values
were retained as missing when they represented meaningful situations or
could not be reliably inferred; selected categorical fields were
labelled `Unknown`, `No Coupon`, or `No Campaign` where appropriate.

## SQL Analysis

The cleaned datasets were loaded into the `indian_ecommerce` MySQL
database.

Imported row counts:

  Table                            Rows
  ----------------------- -------------
  `customers`                    25,000
  `orders`                      100,000
  `order_items`                 254,331
  `products`                        550
  `payments`                    100,000
  `shipments`                    89,681
  `returns`                      12,075
  `customer_reviews`             77,530
  `marketing_campaigns`             151
  **Total**                 **659,318**

SQL analysis covered:

-   Overall business metrics and order status
-   Monthly and annual revenue trends
-   Revenue and profit by product category
-   Revenue by state
-   Best-selling and most profitable products
-   Customer segments, gender, and acquisition channels
-   Payment methods and payment statuses
-   Delivery performance and shipping methods
-   Return reasons and category return rates
-   Marketing campaign performance

The main SQL analysis script is stored in `SQL_Analysis`.

## Power BI Report

The Power BI report contains six pages:

1.  **Overview** --- high-level business KPIs and trends.
2.  **Sales & Revenue Analysis** --- revenue, profit, product category,
    state, customer segment, and acquisition-channel views.
3.  **Operations, Payments & Customer Experience** --- shipment,
    delivery, payment, returns, and product-rating analysis.
4.  **Marketing & Campaign Performance** --- campaign revenue,
    conversions, conversion rates, ROI, campaign costs, and campaign
    types.
5.  **Customer Experience & Reviews** --- review sentiment,
    verification, ratings, and review trends.
6.  **Customer Behaviour & Retention** --- customer segments, gender,
    spending, order activity, and acquisition channels.

The report includes interactive slicers and visual interactions. The
Power BI file is in `PowerBI_Analysis`.

## Selected Findings

The following figures are based on the SQL analysis completed for this
synthetic dataset:

-   100,000 orders were loaded.
-   Order-level revenue (`orders.final_amount`) was approximately
    **₹257.26 crore**.
-   Average order value was approximately **₹25,725.92**.
-   Total units sold were **585,640**.
-   Profit calculated from `order_items.profit` was approximately
    **₹19.73 crore**.
-   The calculated item-level profit margin was approximately **8.05%**.
-   The highest-revenue month in the analysed period was December 2025.
-   Electronics had the highest product-category revenue in the category
    analysis.
-   Footwear had the highest category return rate in the category return
    analysis (**3.70%**).
-   UPI was the most frequently used payment method in the payment
    analysis.

### Metric reconciliation note

Different tables contain different business measures and record grains.
During analysis, totals from orders, order items, customers, payments,
shipments, and returns did not always match. For example, order-level
revenue and item-level revenue are different measures, and a single
order may have multiple return records. These differences should be
investigated and explained before using the figures as reconciled
financial statements. Do not interpret these measures as
interchangeable.

## Repository Structure

``` text
indian-ecommerce-business-intelligence/
├── Python_Analysis/
│   └── 01_data_inventory.ipynb
├── SQL_Analysis/
│   └── 01_Indian_Ecommerce_Business_Analysis.sql
├── Excel_Analysis/
├── PowerBI_Analysis/
│   └── Indian_Ecommerce_Business_Intelligence.pbix
├── Project_Reports/
│   ├── data_inventory
│   ├── date_missing_report
│   ├── duplicate_report
│   ├── export_verification
│   ├── foreign_key_validation
│   ├── overall_validation_report
│   ├── primary_key_validation
│   ├── remaining_missing_report
│   └── validation_summary
├── Cleaned_Dataset/
│   ├── customers.csv
│   ├── orders.csv
│   ├── order_items.csv
│   ├── products.csv
│   ├── payments.csv
│   ├── shipments.csv
│   ├── returns.csv
│   ├── customer_reviews.csv
│   └── marketing_campaigns.csv
├── Raw_Dataset/
│   ├── original CSV datasets
│   ├── data_dictionary
│   └── dataset_validation_report
├── Images/
└── README.md
```

## How to Explore the Project

1.  Start with this README to understand the project and dataset.
2.  Review `Python_Analysis/01_data_inventory.ipynb` for the Python
    workflow.
3.  Review the SQL script in `SQL_Analysis` for database checks and
    business queries.
4.  Open the `.pbix` file in Power BI Desktop to explore the six report
    pages and slicers.
5.  Refer to `Project_Reports` for the recorded validation outputs.

## Notes

-   This is an educational portfolio project built with synthetic data.
-   The results are descriptive analyses of the supplied sample data,
    not claims about the Indian e-commerce market as a whole.
-   The `Excel_Analysis` and `Images` folders may be populated with
    supporting work and dashboard screenshots as those materials are
    finalized.
