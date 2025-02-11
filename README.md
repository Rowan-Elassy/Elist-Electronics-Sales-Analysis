# Elist Electronics Sales Analysis 2019-2022

### Table of Content
- [Project Background](#Project-Background)
- [Data Structure Overview](#Data-Structure-Overview)
- [Executive Summary](#Executive-Summary)
- [Insights Deep Dive](#Insights-DeepDive)
  - [Sales Trends](#Sales-Trends)
  - [Product Performance](#Product-Performance)
  - [Loyalty Program Evaluation](#Loyalty-Program-Evaluation)
  - [Regional-Comparisons](#Regional-Comparisons)
  - [Platform and Marketing Performance](#Platform-and-Marketing-Performance)
- [Recommendations](#Recommendations)

## Project Background
Elist Electronics is a global e-commerce company that was established in 2018 and sells electronic products worldwide from different brands via its website and mobile app.
The company has over 78K records of data on its sales, product offerings, loyalty program and marketing efforts across different regions.
This project thoroughly analyzes and synthesizes this data in order to uncover critical insights that will improve Elist's commercial success.

Insights and recommendations are provided on the following key areas:
- Sales Trends Analysis: Evaluation of historical sales patterns focusing on Revenue, Order Volume, and Average Order Value (AOV).
- Product Level Performance: An analysis of Elist's various product lines, understanding their impact on sales and returns.
- Loyalty Program Insights: An assessment of the loyalty program on customer retention and sales.
- Regional Comparisons: An evaluation of sales, AOV, and order volume by region.
-Platform and marketing performance: An evaluation of the company’s platforms and marketing channels performance

An interactive PowerBI dashboard can be downloaded [here](elist_analysis.pbix).

The SQL queries utilized to load and organize the data can be found [here](loading_and_organizing.sql).

The SQL queries utilized to clean, perform quality checks and prepare data can be found [here](initial_checks_&_cleaning.sql).

Targeted SQL queries inspecting key metrics can be found [here](key_metrics.sql).

## Data Structure Overview
Elist's database structure as seen below consists of four tables: orders, customers, products, geo_lookup, and orders_refunded, with a total row count of 78,843 records.

![ERD](https://github.com/user-attachments/assets/37223cd1-8a5c-4194-bc1d-8a0f3240f198)


Prior to beginning the analysis, a variety of checks were conducted for quality control and familiarization with the datasets. 

The SQL queries utilized to load and organize the data can be found [here](loading_and_organizing.sql).

The SQL queries utilized to clean, perform quality checks and prepare data can be found [here](initial_checks_&_cleaning.sql).

## Executive Summary
After peaking in early 2020, the company's sales have continued to decline, with significant drops in 2022. After increasing by 23% , 26.5% and 20% on average across the past years, Revenues, orders volume and number of customers started decreasing rapidly by 45%, 40% and 30 % respectively by the beginning of 2022.  Additionally, average order value (AOV) decreased by 10% which is a big jumb after an average decrease of 2.7% across the years. While this decline can be broadly attributed to a return to pre-pandemic normalcy, the following sections will explore additional contributing factors and highlight key opportunity areas for improvement.

Below is the overview page from the Power BI dashboard and more examples are included throughout the report. The entire interactive dashboard can be downloaded [here](elist_analysis.pbix).

![Screenshot 2025-02-11 180113](https://github.com/user-attachments/assets/54cb8d25-7103-4cc0-8942-b1313e435467)

Targeted SQL queries inspecting key metrics can be found [here](key_metrics.sql).

## Insights Deep Dive:
### Sales Trends:
The company's sales peaked in January 2020 and reached the highest order count of 4,019 orders totaling 797K monthly revenue in May of the same year. This corresponds with the boom in economy-wide spending due to pandemic-induced changing consumer behavior.

Beginning in April 2021, revenue declined on a year-over-year basis for 21 consecutive months. Revenue hit a company lifetime low in October 2022, with the company earning just over $180K. In the following months, revenue and order volume recovered slightly, while AOV started increasing again following normal holiday seasonality patterns. Average order value saw a one-month year-over-year increase in September 2022, this can be attributed to an increased share of high-cost laptop orders. Despite the downward trend, full-year 2022 remained above the pre-COVID 2019 baseline in all three key performance indicators, revenues, order volume, AOV. 

### Product Performance:
85% of the company's orders are from just accessories and headphones contributing just over 5.5M in revenues. However, computers and headphones alone account for 65% of the company’s revenues amounting for $11.5M on average.

In the headphones category, the Bose SoundSport Headphones have underperformed, contributing to less than 1% of total revenues and orders despite being, on average, $40 cheaper than the well-performing AirPods. The accessory category continues to grow as a share of orders, now at 32% in 2022, up from 21% in 2020. However, accessories remain less than 4% of total revenue.
The company is heavily reliant on the continued popularity of Apple products, with the brand accounting for 47% of total revenue in 2022. Apple's iPhone has yet to make an impact though, registering less than 1% of orders in 2022.

### Loyalty Program Evaluation:
The loyalty program has grown in popularity since its implementation in 2019. Members as a share of revenue peaked in April 2022 at 62%. On an annual basis, members have increased to 60% of revenue, up from 5% in 2019.

In 2022, loyalty members spent almost $35 more on average than non-members ($251 to $216). Average order value (AOV) for members has steadily increased year-over-year, climbing 1.1% from 2021 while non-member AOV declined 18.7%. Non-members have historically outspent on their first orders with the company, but on returning orders members outspent by nearly $60 in 2022.

### Regional Comparisons:
North America grew in importance in 2022, increasing revenue share to 55% and order share to 53% among known region sales.

Sales and average order value (AOV) fell across all regions in 2022. North America remains the largest AOV with $242, 39% above Latin America, the lowest performer.

Europe, the Middle East, and Africa saw a significant increase in order volume share in 4Q22, climbing from 26% to 33% quarter-over-quarter among known region sales.

### Platform and Marketing Performance:
Orders made via the company’s website account for the vast majority of revenues and orders across all years. Also, customers using the website spend about 6 times what the customers using the app would spend. As for marketing channels, direct marketing is the most influential across all channels as it contributes to 80% of the company’s revenues and 77% of total orders. However, affiliate marketing amount to higher AOV than direct marketing with a difference of 32$.

## Recommendations:
Based on the uncovered insights, the following recommendations have been provided to the sales and marketing teams:

- With 85% of orders and 70% of revenue coming from just three products, diversifying the product portfolio is crucial. Expanding the accessory category with new product lines, particularly Apple charging cables, would provide upsell opportunities.

- Despite the general sales success of Apple products, iPhone sales have been disappointingly low (1% of revenue in 2022). Enhancing marketing efforts to previous Apple product buyers could boost sales.

- Look to capitalize on the growing share of Samsung accessories (32% of order count in 2022) by introducing higher-cost Samsung products in already carried product categories such as laptops and cellphones.

- Re-evaluate Bose SoundSport Headphones. As the product has never made up more than 1% of annual revenue, attempt to sell through the product by implementing bundle offers and flash sales to non-Apple ecosystem loyalty members before discontinuing.

- Continue and push forward the loyalty program. In order to convert non-members, consider offering a one-time sign-up discount paired with increased general marketing of membership benefits and savings. Focus targeted and personalized ads to previous customers, and utilize past order data to increase marketing efforts when previously purchased products may need replacing.

- Prioritize website optimization and enhancements, as it generates the majority of revenues and orders and increase investment in direct marketing, as it contributes 80% of revenue and 77% of orders
