# 🛒 Global Electronics Retailer — Sales & Customer Analysis

---

## 📌 Project Overview

This project analyzes **6 years of transaction data (2016–2021)** from a global electronics retailer operating across multiple countries and currencies.

Using **SQL (PostgreSQL)**, the analysis uncovers revenue trends, customer segmentation, product profitability, and store-level performance to support data-driven business decisions.

---

## 📌 Business Problem

Retail businesses need to understand which customers drive the most value, which products and categories are most profitable, and how revenue trends shift over time.
This project aims to identify the key drivers of revenue and profit, and highlight where the business can improve.

---

## ❓ Key Business Questions Explored

1. Which customers contribute the most to total revenue?
2. How are customers segmented using RFM analysis?
3. How does revenue change month-over-month and quarter-over-quarter?
4. Which product categories generate the highest revenue and profit margin?
5. How does new vs returning customer revenue change over time?
6. Which age groups generate the most revenue per category?
7. Which brands are underperforming in terms of profit?

> ✨ *...and additional insights derived from 18+ SQL queries.*

---

## 📊 Dataset

| Property | Details |
|---|---|
| Source | Global Electronics Retailer Dataset (Kaggle) |
| Period | 2016 – 2021 |
| Tables | Sales, Customers, Products, Stores, Exchange Rates |
| Total Sales Records | 62,884 |
| Total Customers | 15,256 |
| Total Products | 2,517 |
| Total Stores | 66 |

---

## 🛠️ Tools Used

| Tool | Purpose |
|---|---|
| PostgreSQL | Data storage & SQL queries |
| pgAdmin 4 | Query execution & output |
| Python (Pandas) | Data cleaning & preprocessing |
| Power BI | Dashboard visualization *(in progress)* |

---

## 📁 Project Structure

```
retail-sales-analysis/
│
├── README.md
│
└── sql_queries/
    ├── 01_data_exploration.sql
    ├── 02_sales_analysis.sql
    ├── 03_customer_analysis.sql
    ├── 04_product_analysis.sql
    └── 05_store_analysis.sql
```

---

## 🔍 Key Findings

- ⭐ **508 customers generate 20% of total revenue** — mostly based in the United States
- 🎯 **Most customers fall into "At Risk" or "Needs Attention"** RFM segments — biggest opportunity for re-engagement
- 💻 **Computers & Home Appliances** are the highest revenue-generating categories
- 🎵 **Music, Movies & Audiobooks, Cameras, and TV/Video** have the lowest revenue but ~60% profit margin — highly profitable despite low sales volume
- 📉 **March & April consistently show negative MoM revenue growth** (2016–2020)
- 📅 **Q4 was historically the strongest quarter (2016–2019)**, but in 2020 this shifted — Q1 became the highest and Q4 the lowest
- 🔄 **Returning customers now drive more revenue than new customers** — a shift from earlier years
- 🏷️ **One specific brand consistently ranks as the lowest-profit brand** across almost every category

---

## 💡 Business Recommendations

1. **Offer free delivery to "At Risk" customers** based on their lifetime value, to encourage repeat purchases
2. **Give first-time buyers a discount on their next order** to convert them into loyal customers
3. **Promote high-margin categories** (Music/Movies, Cameras, TV/Video) more aggressively despite lower sales volume
4. **Investigate the March–April revenue drop** by breaking it down into orders, conversion rate, and AOV, and checking seasonal/promotional factors
5. **Re-evaluate the underperforming brand** identified across categories — consider renegotiating costs or discontinuing low-margin products
6. **Adjust quarterly strategy for 2020 onward** based on the shift in seasonal demand (Q1 vs Q4)

---

## ▶️ How to Run

1. Clone this repository
2. Create a new database in PostgreSQL named `global_electronics`
3. Create the 5 tables (`customers`, `products`, `stores`, `exchange_rates`, `sales`)
4. Import the cleaned CSV files into their respective tables
5. Run queries from `sql_queries/` folder in order (01 → 05)

---

## 🚀 Next Steps

- Build a 2-page Power BI dashboard (Overview + Deep Dive)
- Add DAX measures for revenue, profit margin, and YoY growth

---

## 📬 Connect With Me

**Rafat Khan** — Aspiring Data Analyst

- 💼 LinkedIn: https://www.linkedin.com/in/rafat-khan-7215953a1/
- 🐙 GitHub: https://github.com/Rafat-khan10
