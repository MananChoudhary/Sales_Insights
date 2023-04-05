# Exploratory data analysis using SQL

This project contains the insights of the sales data containing multiple tables. The exploration of data is performed using multiple functionalities of sql comprising of -
1. Windows Functions
2. CTE
3. Aggregation functions
4. Joins
5. Subqueries

There are 5 tables used for this project
The description of the data tables are as follows:-

## 1. Customer's table

Columns:-
1. customer_code- Unique code for each customer #(primary key)
2. customer type- The type of customer as in specific to which stream- Brick & Mortar and E-commerce
3. custmer name- The name of customer.

![alt text](https://user-images.githubusercontent.com/78897321/230070476-632bbdfc-e7c1-495f-bd0f-6521ccef3eca.png)

## 2. Date 
Columns:-
1. date
2. cy_date- Current date #(primary key)
3. year
4. month_name
5. date_yy_mm- Short date

![alt text](https://user-images.githubusercontent.com/78897321/230073140-776aee2f-9e3f-4ea7-94c8-e09cda065410.png)

## 3. Markets

Columns:-
1. markets_code- The code of market.  #(primary key)
2. markets_name- The name of market(Name of the city as market).
3. zone- The zones of the market is divided into (central,north,south).

![alt text](https://user-images.githubusercontent.com/78897321/230074025-3c695737-e950-4f2f-9fbd-b50453809413.png)


## 4. products
Columns:-
1. product_code- The product code #(primary key)
2. product_type- The type of product(Own distribution,Own Brand)

![alt text](https://user-images.githubusercontent.com/78897321/230074211-1dd23fe9-5729-4f89-bb8f-1bd75505f38f.png)

## 5. Transaction 

Columns:-
1. product_code- The product code of the products in the transaction #(Foreign key).
2. customer_code- The code of the customer in the transaction #(Foreign key) (Referenced customer table- customer_code).
3. market_code- The code of the market under which the transaction belongs. #(Foreign key) (Referenced markets table- market_code).
4. order_date- The date of order #(Foreign key) (Referenced date table - cy_date)
5. sales_qty - The quantity sold.
6. sales_amount - The amount of sales generated in the transaction.
7. currency- The currency denotion
8. profit_margin_percentage- (Revenue-Cost)/Total Revenue*100
9. profit_margin- (Revenue-Cost)/Total Revenue
10. cost_price- The cost price of the product in making.


![alt text](https://user-images.githubusercontent.com/78897321/230075896-19aea994-300d-47db-a1c5-20a77e6afd45.png)





