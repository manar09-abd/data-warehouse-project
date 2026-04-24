# # 🏗️ SQL Data Warehouse Project

## 📌 Overview
This project demonstrates the design and implementation of a modern Data Warehouse using SQL Server, following industry best practices in data engineering and analytics.

It covers the full pipeline:
- Data ingestion from multiple sources (ERP & CRM)
- Data transformation and cleaning
- Dimensional modeling (Star Schema)
- Analytical querying for business insights  

---

## 🎯 Project Objectives
The goal of this project is to:

- Build a scalable Data Warehouse architecture
- Ensure data quality and consistency
- Create business-ready datasets
- Support decision-making through analytics

---

## 🏛️ Architecture
This project follows the Medallion Architecture:

```
Sources (CRM & ERP)
        │
        ▼
Bronze Layer  → Raw Data
        │
        ▼
Silver Layer  → Cleaned & Standardized Data
        │
        ▼
Gold Layer    → Analytical Data (Star Schema)
```

### 🔹 Layers Description
- **Bronze Layer**
  - Raw data ingestion from CSV files
  - No transformation (data stored as-is)

- **Silver Layer**
  - Data cleaning & validation
  - Standardization (dates, formats, types)
  - Handling missing values

- **Gold Layer**
  - Business-ready data
  - Fact & Dimension tables
  - Optimized for reporting and BI  

---

## ⚙️ Technologies Used
- Microsoft SQL Server  
- SQL Server Management Studio (SSMS)  
- Draw.io (Data Modeling & Architecture)  
- Git & GitHub  
- CSV Data Sources  

---

## 📂 Project Structure
```
sql-data-warehouse-project/
│
├── datasets/                 
│
├── docs/                     
│   ├── data_architecture.drawio
│   ├── data_models.drawio
│   └── data_catalog.md
│
├── scripts/                  
│   ├── bronze/
│   │   ├── create_bronze.sql
│   │   └── load_data.sql
│   │
│   ├── silver/
│   │   ├── create_silver.sql
│   │   └── transform_data.sql
│   │
│   └── gold/
│       └── build_star_schema.sql
│
├── tests/                    
│   └── data_tests.sql
│
├── README.md
└── LICENSE
```

## 📊 Analytics Goals
The main analytical goals of this project are:

- Analyze sales performance  
- Understand customer behavior  
- Evaluate product performance  
- Identify trends and patterns in business data  

These insights help support data-driven decision-making.

---

## 📜 License
This project is licensed under the MIT License.

You are free to use, modify, and distribute this project with proper attribution.

---
## 👨‍💼 About Me
I am currently a student in Audit, Control, and Business Intelligence with a strong interest in Data Engineering and Analytics.

I am developing skills in building data pipelines, designing data warehouses, and transforming raw data into reliable, business-ready information.

My focus areas include:
- Data Warehousing  
- ETL Pipeline Development  
- SQL & Data Modeling  
- Business Intelligence
  
I am continuously improving my skills through hands-on projects in data warehousing and analytics.
I aim to become a Data Engineer while leveraging my business background to create data-driven solutions.

## 📬 Contact
- LinkedIn: www.linkedin.com/in/manar-abdellaoui  
- GitHub:  https://github.com/manar09-abd

---

## ⭐ Support
If you find this project useful, feel free to ⭐ the repository!

