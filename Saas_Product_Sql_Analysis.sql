CREATE DATABASE PRODUCT;

USE PRODUCT;

SELECT TOP 50  * FROM SalesTB;

---1.Revenue Breakdown
    --Find total sales and profit by country and segment.
    --Sort descending by total sales.

SELECT Country, Segment, 
ROUND(SUM(Sales),2) AS TotalSales, 
ROUND(SUM(Profit),2) AS TotalProfit
FROM SalesTB
GROUP BY Country, Segment
ORDER BY TotalSales DESC;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

---2.Growth Trend
    ---Write a query to calculate monthly revenue trend for the past 12 months.

SELECT FORMAT([Order Date], 'yyyy-MM-MMM') AS [Month], 
SUM(Sales) AS TotalMonthlyRevenue
FROM SalesTB
WHERE [Order Date] >= DATEADD(MONTH, -11, '2023-12-01') AND [Order Date] <= '2023-12-31' --- (last order date '2023-12-31' and past 12 months (till '2023-01-01'))
GROUP BY FORMAT([Order Date], 'yyyy-MM-MMM')
ORDER BY [Month];

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

---3.Top Performers
   ---Identify the top 5 products by total revenue.
   ---For each product, show total quantity sold and average discount.

SELECT TOP 5 Product ,
SUM(Quantity) AS TotalQuantitySold, 
ROUND(SUM(Sales),2) AS TotalRevenue, 
ROUND(AVG(Discount),3) AS AvgDiscount 
FROM SalesTB
GROUP BY Product 
ORDER BY TotalRevenue DESC;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

---4.Profitability Analysis
   ---Find which country–segment combination yields the highest profit margin.

SELECT TOP 1 Country, Segment, 
SUM(Sales) AS TotalSales, 
SUM(Profit) AS TotalProfit, 
(ROUND((SUM(Sales) / SUM(Profit)) * 100,4)) AS Profit_Margin_Percent ---profit margin = (Net income / revenue) * 100
FROM SalesTB
GROUP BY Country , Segment
ORDER BY Profit_Margin_Percent DESC;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

---5.Revenue Contribution
   ---Find each product’s revenue contribution % to the overall total revenue.

SELECT Product, 
SUM(Sales) AS ProductRevenue, 
(ROUND(SUM(Sales) * 100 / (SELECT SUM(Sales) FROM SalesTb),2)) AS RevenueContributionPercent 
FROM SalesTB
GROUP BY Product
ORDER BY RevenueContributionPercent DESC;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
