-- Respuestas de las preguntas
USE primerSprint;

-------------------------------------------------------------------
-- Departamento de Marketing:

-- ¿Cuál es el total de ventas por país/región?
SELECT Region, ROUND(SUM(ventas),2)
FROM supertienda
WHERE id_pedido NOT IN ('CA-2021-121465', 'CA-2022-130494')
GROUP BY Region;

-- ¿Cuál es la cantidad promedio de productos vendidos por pedido?
SELECT ROUND(AVG(T.Quantity_S),2)
FROM (  SELECT Order_ID, SUM(Quantity) AS Quantity_S
        FROM rawdata
        GROUP BY Order_ID ) AS T;
SELECT AVG(Quantity) FROM rawdata;

-- ¿Cuál es el método de envío más utilizado por los clientes?
SELECT Ship_Mode, COUNT(Ship_Mode) AS Ship_Mode_Count
FROM rawdata
GROUP BY Ship_Mode;
SELECT Ship_Mode, COUNT(Ship_Mode) AS Ship_Mode_Count
FROM (  SELECT DISTINCT Customer_Name, Ship_Mode
        FROM rawdata) AS T
GROUP BY Ship_Mode;

-- ¿Cuál es la ciudad con la mayor cantidad de ventas?
SELECT City, ROUND(SUM(Sales),2)
FROM rawdata
GROUP BY City;

-- ¿Cuál es la categoría de productos con la mayor cantidad de ventas?
SELECT Category, ROUND(SUM(Sales),2)
FROM rawdata
GROUP BY Category;

-- ¿Cuál es el nombre del cliente con el pedido más grande?
SELECT Customer_Name, Order_ID, ROUND(SUM(Sales),2)
FROM rawdata
GROUP BY Customer_Name, Order_ID
ORDER BY SUM(Sales) DESC;

-- ¿Qué porcentaje de descuento se ha aplicado en promedio a los pedidos?
SELECT ROUND(AVG(T.Discount_S),6)
FROM (  SELECT Order_ID, AVG(Discount) AS Discount_S
        FROM rawdata
        GROUP BY Order_ID) AS T;
SELECT AVG(Discount) FROM rawdata;

-- ¿Cuál es el segmento de clientes con la mayor cantidad de ventas?
SELECT Segment, ROUND(SUM(Sales),2)
FROM rawdata
GROUP BY Segment
ORDER BY SUM(Sales) DESC;

-- ¿Qué subcategoría de productos ha generado la mayor ganancia?
SELECT Sub_Category, ROUND(SUM(Profit),2)
FROM rawdata
GROUP BY Sub_Category
ORDER BY SUM(Profit) DESC;

-- ¿Cuál es la provincia/estado/departamento con la mayor cantidad de ventas?
SELECT State_Province, ROUND(SUM(Sales),2)
FROM rawdata
GROUP BY State_Province
ORDER BY SUM(Sales) DESC;

-- ¿Cuál es la región con la mayor cantidad de ventas?
SELECT Region, ROUND(SUM(Sales),2)
FROM rawdata
GROUP BY Region
ORDER BY SUM(Sales) DESC;

-- ¿Cuál es el producto más vendido?
SELECT Product_Name, ROUND(SUM(Quantity),2)
FROM rawdata
GROUP BY Product_Name
ORDER BY SUM(Quantity) DESC;

-- ¿Cuál es el cliente que ha comprado con más frecuencia?
SELECT Customer_Name, COUNT(Customer_Name) AS Customer_Name_Count
FROM rawdata
GROUP BY Customer_Name
ORDER BY COUNT(Customer_Name) DESC;
SELECT T.Customer_Name, COUNT(T.Order_ID) AS Num_Orders
FROM (  SELECT DISTINCT Order_ID, Customer_Name 
        FROM rawdata ) AS T
GROUP BY T.Customer_Name
ORDER BY COUNT(T.Customer_Name) DESC;

-- ¿Qué porcentaje de las ventas proviene de cada país/región?
SELECT REGION, 
ROUND(SUM(Sales),2), 
ROUND(SUM(Sales)/SUM(SUM(Sales)) OVER(),4)
-- Como funciona Over? R: Over() es una función que permite hacer cálculos sobre un conjunto de datos.
FROM rawdata
GROUP BY REGION
ORDER BY SUM(Sales) DESC;

-- ¿Cuáles son los días y horas con la mayor cantidad de ventas?
SELECT DAYNAME(Order_Date) AS Day, ROUND(SUM(Sales),2) AS Sales
FROM rawdata
GROUP BY DAYNAME(Order_Date)
ORDER BY SUM(Sales) DESC;

-------------------------------------------------------------------
-- Departamento de Ventas:

-- ¿Cuál es el total de ventas por país/región?
SELECT Region, ROUND(SUM(Sales),2)
FROM rawdata
GROUP BY Region;

-- ¿Cuál es la cantidad promedio de productos vendidos por pedido?
SELECT ROUND(AVG(T.Quantity_S),2)
FROM (  SELECT Order_ID, SUM(Quantity) AS Quantity_S
        FROM rawdata
        GROUP BY Order_ID ) AS T;

-- ¿Cuáles son los métodos de envío más utilizados por los clientes?
SELECT Ship_Mode, COUNT(Ship_Mode) AS Ship_Mode_Count
FROM (  SELECT DISTINCT Customer_Name, Ship_Mode
        FROM rawdata) AS T
GROUP BY Ship_Mode;

SELECT Ship_Mode, COUNT(Ship_Mode) AS Ship_Mode_Count
FROM rawdata
GROUP BY Ship_Mode;

-- ¿Cuál es la ciudad con la mayor cantidad de ventas?
SELECT City, ROUND(SUM(Sales),2)
FROM rawdata
GROUP BY City;

-- ¿Cuál es la categoría de productos con la mayor cantidad de ventas?
SELECT Category, ROUND(SUM(Sales),2)
FROM rawdata
GROUP BY Category;

-- ¿Quién es el cliente con el pedido más grande?
SELECT Customer_Name, Order_ID, ROUND(SUM(Sales),2)
FROM rawdata
GROUP BY Customer_Name, Order_ID
ORDER BY SUM(Sales) DESC;

-- ¿Qué porcentaje de descuento se ha aplicado en promedio a los pedidos?
SELECT ROUND(AVG(T.Discount_S),6)
FROM (  SELECT Order_ID, AVG(Discount) AS Discount_S
        FROM rawdata
        GROUP BY Order_ID) AS T;

-- ¿Cuál es el segmento de clientes con la mayor cantidad de ventas?
SELECT Segment, ROUND(SUM(Sales),2)
FROM rawdata
GROUP BY Segment
ORDER BY SUM(Sales) DESC;

-- ¿Qué subcategoría de productos ha generado la mayor ganancia?
SELECT Sub_Category, ROUND(SUM(Profit),2)
FROM rawdata
GROUP BY Sub_Category
ORDER BY SUM(Profit) DESC;

-- ¿Cuál es la provincia/estado/departamento con la mayor cantidad de ventas?
SELECT State_Province, ROUND(SUM(Sales),2)
FROM rawdata
GROUP BY State_Province
ORDER BY SUM(Sales) DESC;

-- ¿Cuál es la región con la mayor cantidad de ventas?
SELECT Region, ROUND(SUM(Sales),2)
FROM rawdata
GROUP BY Region
ORDER BY SUM(Sales) DESC;

-- ¿Cuál es el producto más vendido?
SELECT Product_Name, ROUND(SUM(Quantity),2)
FROM rawdata
GROUP BY Product_Name
ORDER BY SUM(Quantity) DESC;

-- ¿Cuál es el cliente que ha comprado con más frecuencia?
SELECT T.nombre_Cliente, COUNT(T.id_pedido) AS Num_Orders
FROM (  SELECT DISTINCT id_pedido, nombre_Cliente 
        FROM supertienda ) AS T
GROUP BY T.nombre_Cliente
ORDER BY COUNT(T.nombre_Cliente) DESC;

-- ¿Qué porcentaje de las ventas proviene de cada país/región?
SELECT REGION, 
ROUND(SUM(ventas),2), 
ROUND(SUM(ventas)/SUM(SUM(ventas)) OVER(),4)
FROM supertienda
GROUP BY REGION
ORDER BY SUM(ventas) DESC;

-- ¿Cuáles son los días y horas con la mayor cantidad de ventas?
SELECT DAYNAME(Order_Date) AS Day, ROUND(SUM(Sales),2) AS Sales
FROM rawdata
GROUP BY DAYNAME(Order_Date)
ORDER BY SUM(Sales) DESC;

-------------------------------------------------------------------
-- Departamento de Logística:

-- ¿Cuántos pedidos se han realizado en total?
SELECT COUNT(DISTINCT Order_ID)
FROM rawdata;

-- ¿Cuál es el tiempo promedio de entrega desde la fecha de pedido hasta la fecha de envío?
SELECT ROUND(AVG(DATEDIFF(Ship_Date, Order_Date)),2)
FROM (SELECT DISTINCT Order_ID, Ship_Date, Order_Date
        FROM rawdata) AS T;

-- ¿Cuáles son los métodos de envío más utilizados por los clientes?
SELECT Ship_Mode, COUNT(Ship_Mode) AS Ship_Mode_Count
FROM (  SELECT DISTINCT Customer_Name, Ship_Mode
        FROM rawdata) AS T
GROUP BY Ship_Mode;

-- ¿Cuál es la ciudad con la mayor cantidad de pedidos realizados?
SELECT City, COUNT(City) AS Order_Count
FROM (  SELECT DISTINCT Order_ID, City
        FROM rawdata) AS T
GROUP BY City
ORDER BY COUNT(City) DESC;

-- ¿Cuál es la categoría de productos con la mayor cantidad de pedidos realizados?
SELECT Category, COUNT(Category) AS Order_Count
FROM (  SELECT DISTINCT Order_ID, Category
        FROM rawdata) AS T
GROUP BY Category
ORDER BY COUNT(Category) DESC;

-- ¿Quién es el cliente con el pedido más grande?
SELECT Customer_Name, Order_ID, ROUND(SUM(Sales),2)
FROM rawdata
GROUP BY Customer_Name, Order_ID
ORDER BY SUM(Sales) DESC;

-- ¿Qué provincia/estado/departamento tiene la mayor cantidad de pedidos?
SELECT State_Province, COUNT(State_Province) AS Order_Count
FROM (  SELECT DISTINCT Order_ID, State_Province
        FROM rawdata) AS T
GROUP BY State_Province
ORDER BY COUNT(State_Province) DESC;

-- ¿Cuál es el segmento de clientes con la mayor cantidad de pedidos realizados?
SELECT Segment, COUNT(Order_ID) AS Order_Count
FROM (  SELECT DISTINCT Order_ID, Segment
        FROM rawdata) AS T
GROUP BY Segment
ORDER BY COUNT(Order_ID) DESC;

-- ¿Qué país/región tiene la mayor cantidad de pedidos realizados?
SELECT Region, COUNT(Region) AS Order_Count
FROM (  SELECT DISTINCT Order_ID, Region
        FROM rawdata) AS T
GROUP BY Region
ORDER BY COUNT(Region) DESC;

-- ¿Cuál es la región con la mayor cantidad de pedidos realizados?
SELECT Region, COUNT(Region) AS Order_Count
FROM (  SELECT DISTINCT Order_ID, Region
        FROM rawdata) AS T
GROUP BY Region
ORDER BY COUNT(Region) DESC;

-- ¿Cuál es el producto más pedido?
SELECT Product_Name, SUM(Quantity) AS Quantity
FROM rawdata
GROUP BY Product_Name
ORDER BY SUM(Quantity) DESC;

-- ¿Cuál es la provincia/estado/departamento con la mayor cantidad de envíos realizados?
SELECT State_Province, COUNT(Order_ID) AS Ship_Count
FROM (  SELECT DISTINCT Order_ID, State_Province
        FROM rawdata) AS T
GROUP BY State_Province
ORDER BY COUNT(Order_ID) DESC;

-- ¿Qué porcentaje de los pedidos se envía a cada país/región?
SELECT REGION, 
COUNT(Order_ID), 
ROUND(COUNT(Order_ID)/SUM(COUNT(Order_ID)) OVER(),4)
FROM (  SELECT DISTINCT Order_ID, Region
        FROM rawdata) AS T
GROUP BY REGION
ORDER BY COUNT(Order_ID) DESC;

-- ¿Cuál es el método de envío más rápido y cuál es el más lento?
SELECT Ship_Mode, ROUND(AVG(DATEDIFF(Ship_Date, Order_Date)),2) AS Ship_Days
FROM (  SELECT DISTINCT Order_ID, Ship_Date, Order_Date, Ship_Mode
        FROM rawdata) AS T
GROUP BY Ship_Mode
ORDER BY AVG(DATEDIFF(Ship_Date, Order_Date)) ASC;

-- ¿Cuáles son los días y horas con la mayor cantidad de pedidos realizados?
SELECT DAYNAME(Order_Date) AS Day, COUNT(Order_ID) AS Order_Count
FROM (  SELECT DISTINCT Order_ID, Order_Date
        FROM rawdata) AS T
GROUP BY DAYNAME(Order_Date)
ORDER BY COUNT(Order_ID) DESC;

-------------------------------------------------------------------
-- Departamento Financiero:

-- ¿Cuántas ventas se han realizado en total?
SELECT COUNT(DISTINCT Order_ID)
FROM rawdata;

-- ¿Cuál es la cantidad total de productos vendidos?
SELECT SUM(Quantity)
FROM rawdata;

-- ¿Cuál es la ganancia total generada por las ventas?
SELECT ROUND(SUM(Profit),2)
FROM rawdata;

-- ¿Cuál es el producto más vendido en términos de ventas y cantidad?
SELECT Product_Name, SUM(Quantity) AS Quantity, ROUND(SUM(Sales),2) AS Sales
FROM rawdata
GROUP BY Product_Name
ORDER BY SUM(Sales) DESC, SUM(Quantity) DESC;

-- ¿Cuál es el segmento de clientes que genera la mayor cantidad de ventas?
SELECT Segment, ROUND(SUM(Sales),2) AS Sales
FROM rawdata
GROUP BY Segment
ORDER BY SUM(Sales) DESC;

-- ¿Qué porcentaje de los pedidos tienen descuentos?
SELECT COUNT(DISTINCT Order_ID) AS Order_Count,
COUNT(DISTINCT CASE WHEN Discount > 0 THEN Order_ID END) AS Discount_Order_Count,
ROUND(COUNT(DISTINCT CASE WHEN Discount > 0 THEN Order_ID END)/COUNT(DISTINCT Order_ID),4) AS Discount_Order_Percent
FROM rawdata;

-- ¿Cuál es el descuento promedio en términos de porcentaje y cantidad?
SELECT ROUND(AVG(Discount),2), ROUND(SUM(Discount),2)
FROM rawdata;


-- ¿Cuál es el segmento de clientes que tiene la mayor cantidad de descuentos?
SELECT Segment, ROUND(SUM(Discount),2) AS Discount
FROM rawdata
GROUP BY Segment
ORDER BY SUM(Discount) DESC;

-- ¿Cuál es el país/región con la mayor cantidad de ventas y ganancias?
SELECT Region, ROUND(SUM(Sales),2) AS Sales, ROUND(SUM(Profit),2) AS Profit
FROM rawdata
GROUP BY Region
ORDER BY SUM(Sales) DESC, SUM(Profit) DESC;

-- ¿Cuál es la región con la mayor cantidad de ventas y ganancias?
SELECT Region, ROUND(SUM(Sales),2) AS Sales, ROUND(SUM(Profit),2) AS Profit
FROM rawdata
GROUP BY Region
ORDER BY SUM(Sales) DESC, SUM(Profit) DESC;

-- ¿Cuál es la provincia/estado/departamento con la mayor cantidad de ventas y ganancias?
SELECT State_Province, ROUND(SUM(Sales),2) AS Sales, ROUND(SUM(Profit),2) AS Profit
FROM rawdata
GROUP BY State_Province
ORDER BY SUM(Sales) DESC, SUM(Profit) DESC;

-- ¿Qué porcentaje de las ventas se realiza en cada país/región?
SELECT Region,
ROUND(SUM(Sales),2),
ROUND(SUM(Sales)/SUM(SUM(Sales)) OVER(),4)
FROM rawdata
GROUP BY Region
ORDER BY SUM(Sales) DESC;

-- ¿Cuáles son las categorías de productos con las mayores ventas y ganancias?
SELECT Category, ROUND(SUM(Sales),2) AS Sales, ROUND(SUM(Profit),2) AS Profit
FROM rawdata
GROUP BY Category
ORDER BY SUM(Sales) DESC, SUM(Profit) DESC;

-- ¿Cuál es la relación entre el descuento y las ventas y la ganancia?
SELECT Discount, 
ROUND(SUM(Sales),2) AS Sales, 
ROUND(SUM(Profit),2) AS Profit
FROM rawdata
GROUP BY Discount
ORDER BY Discount ASC;

-- ¿Qué porcentaje de las ganancias es generado por cada segmento de clientes?
SELECT Segment,
ROUND(SUM(Profit),2),
ROUND(SUM(Profit)/SUM(SUM(Profit)) OVER(),4)
FROM rawdata
GROUP BY Segment
ORDER BY SUM(Profit) DESC;

-------------------------------------------------------------------
-- Departamento de Desarrollo de Productos:

-- ¿Cuáles son las categorías y subcategorías de productos más vendidos?
SELECT Category, Sub_Category, ROUND(SUM(Quantity),2) AS Quantity
FROM rawdata
GROUP BY Category, Sub_Category
ORDER BY SUM(Quantity) DESC;

-- ¿Cuál es el producto más vendido en términos de ventas y cantidad?
SELECT Product_Name, SUM(Quantity) AS Quantity, ROUND(SUM(Sales),2) AS Sales
FROM rawdata
GROUP BY Product_Name
ORDER BY SUM(Sales) DESC, SUM(Quantity) DESC;

-- ¿Qué porcentaje de las ventas se realiza en cada categoría de productos?
SELECT Category,
ROUND(SUM(Sales),2),
ROUND(SUM(Sales)/SUM(SUM(Sales)) OVER(),4)
FROM rawdata
GROUP BY Category
ORDER BY SUM(Sales) DESC;

-- ¿Qué porcentaje de las ganancias es generado por cada categoría de productos?
SELECT Category,
ROUND(SUM(Profit),2),
ROUND(SUM(Profit)/SUM(SUM(Profit)) OVER(),4)
FROM rawdata
GROUP BY Category
ORDER BY SUM(Profit) DESC;

-- ¿Hay alguna tendencia en términos de popularidad de las categorías y subcategorías de productos a lo largo del tiempo?
SELECT 
Category, Sub_Category, 
YEAR(Order_Date), MONTH(Order_Date), WEEK(Order_Date),
ROUND(SUM(Quantity),2) AS Quantity,
ROUND(SUM(Sales),2) AS Sales
FROM rawdata
GROUP BY Category, Sub_Category, YEAR(Order_Date), MONTH(Order_Date), WEEK(Order_Date)
ORDER BY WEEK(Order_Date) ASC;
