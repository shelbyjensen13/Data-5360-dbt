# 📊 Eco Essentials Data Warehouse & Marketing Analytics Dashboard

## 📌 Project Overview
This project focuses on designing and implementing a modern data warehouse for Eco Essentials, an eco-friendly cookware company. The goal was to transform raw operational data into a structured, analytics-ready format to support business intelligence and reporting.

Using Snowflake and dbt, a dimensional data model was developed to enable efficient analysis of key business processes. A live-connected dashboard was then built to visualize sales performance and marketing campaign effectiveness for Eco Essentials leadership.

---

## 🎯 Business Problem
Eco Essentials is seeking to improve its data infrastructure to better understand its operations and customer behavior.

The company specifically wants to analyze:

- **Sales Performance:** Identify trends in revenue and product performance over time  
- **Marketing Effectiveness:** Measure how marketing emails (via Salesforce Marketing Cloud) convert into actual sales  

This project provides a centralized data warehouse and dashboard to answer these questions and support data-driven decision making.

---

## 🛠️ Tech Stack
- **Data Warehouse:** Snowflake  
- **Transformation:** dbt (data build tool)  
- **Visualization:** (Tableau / Snowsight / Metabase — replace with what you used)  
- **Language:** SQL  
- **Version Control:** GitHub  

---

## 🏗️ Data Pipeline Architecture
The project follows a modern ELT (Extract, Load, Transform) architecture:

1. Raw data is ingested into Snowflake staging tables  
2. dbt is used to clean, transform, and model the data  
3. Dimensional models (fact and dimension tables) are created  
4. Analytics-ready tables are built for reporting  
5. A visualization tool connects **live to Snowflake** to power the dashboard  

---

## 🧮 Data Modeling
A dimensional modeling approach was used to structure the data warehouse.

### Fact Tables
- **Sales Fact Table:** Contains transaction-level data such as revenue, units sold, and purchase details  

### Dimension Tables
- **Date Dimension:** Enables time-based analysis  
- **Product Dimension:** Contains product attributes and categories  
- **Customer Dimension:** Stores customer-related information  
- **Marketing Campaign Dimension:** Tracks marketing email events and campaign data  

This structure follows a **star schema design**, allowing for efficient querying and reporting.

---

## 📈 Dashboard Overview
The final dashboard was designed for Eco Essentials leadership and includes:

- Performance ranking per marketing campaign
- Most efficient campaign on conversion rate  
- New customer vs loyalty subscribers 

The dashboard uses a **live connection to Snowflake**, ensuring real-time access to updated data.

---

## 🔑 Key Insights
*(Update these based on your actual dashboard findings)*

- Marketing campaigns vary significantly in their conversion effectiveness  
- A small number of campaigns drive a large portion of total sales  
- Sales trends show patterns over time that can inform future business strategy  
- Customer engagement through email marketing has a measurable impact on revenue  

---

## 🎥 Demo Video
[Insert your video link here]

---

## 📂 Repository Structure
/models -> dbt transformation models (Eco Essentials warehouse)
/tests -> data quality checks
/macros -> resuable SQL logic

---

## 🚀 How to Reproduce
1. Connect to Snowflake  
2. Run dbt models to build the data warehouse  
3. Connect a visualization tool to Snowflake  
4. Open and explore the dashboard  

---

## 💡 Key Takeaways
- Designed and implemented a full data warehousing solution using Snowflake and dbt  
- Applied dimensional modeling techniques to support business analytics  
- Transformed raw data into actionable insights for decision makers  
- Built a live-connected dashboard to analyze sales and marketing performance  

---

## 🔗 Additional Resources
- Snowflake Documentation  
- dbt Documentation  
- Tableau / Visualization Tool Documentation  
