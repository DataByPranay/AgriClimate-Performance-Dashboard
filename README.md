# 🌱 AgriClimate Performance Dashboard

## 📌 Project Overview

The **AgriClimate Performance Dashboard** is an end-to-end data analytics project designed to analyze agricultural and climate data to generate meaningful insights. This project demonstrates data engineering, ETL, and data visualization skills using SQL, Snowflake, and Power BI.

The dashboard helps monitor agricultural performance, climate conditions, and trends that impact productivity. It transforms raw agricultural datasets into structured, analysis-ready data and presents insights through an interactive dashboard.

---

## 🎯 Objectives

* Analyze agricultural performance using climate-related data
* Build an ETL pipeline using SQL and Snowflake
* Design a structured data model for analytics
* Create an interactive Power BI dashboard
* Demonstrate data engineering and data analysis workflow

---

## 🛠️ Tech Stack

**Data Engineering & Storage**

* Snowflake (Data Warehouse)
* SQL (ETL and data transformation)

**Data Visualization**

* Power BI (.pbix dashboard file)

**Tools & Platform**

* GitHub (Version control)
* Power BI Desktop

---

## 📂 Project Structure

```
AgriClimate-Performance-Dashboard/
│
├── dataset/                             # Raw datasets
├── Agriculture Data Report.pbix        # Power BI dashboard file
├── Snowflake_ETL_Agriculture.sql      # SQL ETL scripts
├── README.md                           # Project documentation
└── LICENSE                             # MIT License
```

---

## ⚙️ ETL Process

The ETL pipeline includes the following steps:

1. **Extract**

   * Load raw agricultural and climate data from source files

2. **Transform**

   * Clean and standardize data
   * Handle missing values
   * Create calculated fields
   * Prepare fact and dimension tables

3. **Load**

   * Load transformed data into Snowflake data warehouse

---

## 📊 Dashboard Features

The Power BI dashboard provides:

* Agricultural performance metrics
* Climate impact analysis
* Trend analysis
* Interactive filters and visuals
* KPI monitoring

---

## 🚀 How to Use

### Step 1: Clone the repository

```bash
git clone https://github.com/DataByPranay/AgriClimate-Performance-Dashboard.git
```

### Step 2: Setup Snowflake

* Open Snowflake
* Run the SQL script:

```
Snowflake_ETL_Agriculture.sql
```

### Step 3: Open Dashboard

* Open `Agriculture Data Report.pbix` in Power BI Desktop
* Connect to your Snowflake database (if required)

---

## 📈 Key Skills Demonstrated

* Data Engineering
* ETL Pipeline Development
* SQL
* Snowflake
* Data Modeling
* Power BI Dashboard Development
* Data Analysis

---

## 🔮 Future Improvements

* Add real-time data integration
* Deploy dashboard to Power BI Service
* Automate ETL using Airflow or dbt
* Add advanced analytics and forecasting

---

## 👨‍💻 Author

**Pranay Birangade**
Aspiring Data Engineer | Data Analyst

GitHub: [https://github.com/DataByPranay](https://github.com/DataByPranay)

---

## 📜 License

This project is licensed under the MIT License.

---

## ⭐ If you found this project useful, please consider giving it a star!
