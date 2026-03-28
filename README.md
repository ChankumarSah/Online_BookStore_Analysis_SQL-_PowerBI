# 📊 Online Bookstore Sales Analysis | Advanced SQL + Power BI

📊 Business-Focused Data Analysis Project with SQL-Driven Insights & Interactive BI Dashboard  
📌 End-to-End Data Analytics Project: Data Exploration → SQL Analysis → Power BI Dashboard → Business Insights  
⭐ Highlight: Identified top 20% customers contributing ~65–70% of total revenue

---

## 🚀 Project Overview

This project analyzes real-world **online bookstore transaction data** using **SQL for deep analysis** and **Power BI for interactive visualization**.

📊 Dataset Size: 10,000+ transactions analyzed  

The objective is to uncover:
- Revenue drivers  
- Customer purchasing behavior  
- Product performance  
- Growth opportunities  

👉 Transforms raw data into **actionable business insights**

---

## 🎯 Business Problem

The bookstore lacks visibility into:
- High-value customers  
- Sales trends & seasonality  
- Top-performing genres and books  
- Regional purchasing behavior  

👉 Key Question:  
**How to increase revenue and optimize customer targeting?**

---

## 🛠 Tools & Technologies

- SQL (MySQL)  
- Power BI (DAX, Data Modeling)  
- Data Analysis  

---

## 📊 Dataset

- Books.csv → Book details  
- Customers.csv → Customer data  
- Orders.csv → Transactions  

---

## 🔍 SQL Analysis

### ✔ Revenue
- Monthly trends & growth  
- ~25–30% seasonal spike observed  

### ✔ Customers
- Top 10% customers contribute ~65–70% revenue  
- Customer Lifetime Value (LTV)  

### ✔ Products
- Top genres & best-selling books  
- Pareto Analysis (Top 20% drive majority revenue)  

### ✔ Techniques
JOINs • CTEs • Window Functions • Aggregations  

---

## 🧠 Sample SQL Query

```sql
WITH customer_revenue AS (
    SELECT 
        c.customer_id,
        SUM(o.total_amount) AS total_revenue
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id
)
SELECT *,
       RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
FROM customer_revenue;
```
---


## 📈 Power BI Dashboard Features

- Total Revenue, Orders, Customers  
- Average Order Value (AOV)  
- Revenue by Genre  
- Top Customers  
- Monthly Trends  
- City-wise Sales  

📌 **Filters:**  
- Genre  
- Year  

---

## 📊 Key Insights

- Top 20% customers contribute ~65–70% revenue  
- Romance, Mystery, Sci-Fi are top genres  
- Revenue spikes ~25–30% in peak months  
- Few products drive majority of sales  

---

## 💡 Recommendations

- Target high-value customers  
- Increase stock for top genres  
- Run campaigns during peak months  
- Optimize pricing strategy  

---

## 📷 Dashboard Preview

![Dashboard](online_bookstore.png)

---

## 🎯 Impact

- Analyzed 10,000+ transactions  
- Identified revenue drivers  
- Built end-to-end SQL + BI solution  
- Enabled data-driven decisions  

---

## ⭐ Future Enhancements

- Cohort Analysis  
- Sales Forecasting  
- Cloud Integration (AWS)  

---

## 👨‍💻 Author

**Chandan Kumar Sah**  
Data Analyst | SQL • Power BI • Python • Machine Learning
