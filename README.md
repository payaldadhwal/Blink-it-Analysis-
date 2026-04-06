🛒 Blinkit Grocery Analysis

Welcome to the Blinkit Grocery Analysis project! ✨

This project explores a grocery dataset from Blinkit, focusing on data cleaning, exploration, and SQL-driven insights. The goal? To understand product pricing, sales trends, and outlet performance using SQL queries.

🔹 Project Overview
Dataset: 8,523 grocery item records with outlet details
Columns include product info:
item_identifier, item_type, item_fat_content, item_MRP, item_outlet_sales
Columns include outlet info:
outlet_identifier, outlet_size, outlet_type, outlet_establishment_year
Workflow: Load CSV → Clean → Explore → Analyze ✅

Clean data is half the analysis! 🧹

🔹 Data Cleaning Highlights ✨
Standardized item fat content:
REG → Regular
LF → Low Fat
Cleaned outlet sizes: Small, Medium, Large (replaced 0 with Medium)
Verified there were no null values
Trimmed text columns to remove hidden spaces ✂️

🔹 Key SQL Analysis 📝

Here’s what I explored using SQL:

💰 High MRP items:
Top products like FD15 (Dairy, MRP: 249.81) and FBO02 (Dairy, MRP: 230.54)
🏆 Top-selling items: Best performers across all outlets
🏬 Outlet trends: Total sales comparison by outlet size and type
🥛 Category analysis: Sales by fat content and item type
📊 Ranking insights: Top items in each category

SQL was used for filtering, aggregation, ranking, and window functions, turning raw data into actionable business insights. ⚡

🔹 Key Takeaways 💡
Premium products mostly belong to Dairy and Canned items 🥛🥫
Medium outlets are the most common and generate higher total sales 🏬
Data standardization (fat content & outlet size) is critical for accurate insights ✨
This dataset can help with inventory planning, sales predictions, and targeted promotions 📈

🔹 How to Explore This Project 🔍
Open Blinkit_grocery_raw.csv to see the raw dataset 🗂️
Run Blinkit_grocery_queries.sql to replicate all cleaning & analysis steps ⚡
Explore queries like:
Top MRP items 💎
Sales ranking by category 🏆
Outlet performance by size 🏬
