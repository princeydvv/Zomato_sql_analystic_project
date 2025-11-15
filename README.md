# Zomato Food Delivery – SQL Analysis Project
📌 Project Overview

This project analyzes Zomato-style food delivery data using SQL to uncover insights about restaurant performance, customer behavior, cuisine popularity, and order trends.
It includes a complete database design, ER diagram, sample dataset, analytical SQL queries, and a final insights report.

## 📂 Repository Structure
```
zomato-sql-project/
│
├── schema/
│     └── create_tables.sql
│
├── data/
│     └── cuisines.sql
│     └── customers.sql
│     └── menu_items.sql
│     └── order_items.sql
│     └── orders.sql
│     └── ratings.sql
│     └── restaurant_cuisines.sql
│     └── restaurants.sql

│
├── queries/
│     └── analysis_queries.sql
│
├── images/
│     ├── er_diagram.png
│     ├── query_output_1.png
│     ├── query_output_2.png
│     ├── query_output_3.png
│     ├── query_output_4.png
│     ├── query_output_5.png
│     ├── query_output_6.png
│     ├── query_output_7.png
│     ├── query_output_8.png
│     ├── query_output_9.png
│     └── query_output_10.png
│
├── report/
│     └── Zomato_SQL_Project_Report.pdf
│
└── README.md 
```

## 🗄️ Database Schema

The project uses a normalized relational database with 8 tables:

* cuisines

* restaurants

* customers

* menu_items

* restaurant_cuisines

* orders

* order_items

* ratings



## 🛠 Technologies Used

* MySQL

* MySQL Workbench

* SQL (DDL, DML, JOINS, Aggregations)

* GitHub

* PDF Reporting

* Excel


  
## 🔍 Analysis Conducted

This project answers key business questions such as:

* Top restaurants by revenue

* Restaurants with highest order volume

* Best-selling menu items

* Most popular cuisines

* Customer order frequency

* Repeat vs first-time customer behavior

* Daily and hourly order trends

* Restaurant rating analysis

* High-rated and low-rated restaurants

* Revenue by city and area

* Average order value (AOV)

* Basket size (items per order)


The full SQL queries are available in:
```bash
queries/analysis_queries.sql

```

## 📓 Notebook
This project includes a Jupyter Notebook for demonstration:
```
[zomato_project_notebook.ipynb](zomato_project_notebook.ipynb)
```

## 📈 Key Insights

* Evening and weekend orders dominate the platform.

* North Indian and Chinese cuisines generate the highest order volume.

* A small set of restaurants contribute a major share of total revenue.

* Repeat customers drive strong long-term value.

* Non-veg items spike significantly on weekends.

* Average order value remains stable across most areas



## 📝 How to Run This Project

1. Import the schema:

```
schema/create_tables.sql

```
2. Load sample data:

```
data/

```
3. Execute analysis queries:

```
queries/analysis_queries.sql

```
## 📄 Final Report

The final PDF report containing the ER diagram, schema explanation, SQL queries, output screenshots, and insights is available here:

```
report/Zomato_SQL_Project_Report.pdf
```

## 📬 Contact

If you’d like to connect or discuss the project, feel free to reach out:

Name : Prince Yadav

Email: princeyadav5018@gmail.com

GitHub: https://github.com/princeydvv

LinkedIn: https://www.linkedin.com/in/prince-yadav-556438255/











