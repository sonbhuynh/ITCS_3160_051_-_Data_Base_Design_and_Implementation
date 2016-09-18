/*1. List all customer along with their address, city, state and zip*/
SELECT customer_name, customer_add, customer_city, customer_state, customer_zip
FROM customers;

/*2. List all customers and their phone numbers that live in GA*/
SELECT customer_name, customer_phone
FROM customers
WHERE customer_state = 'GA';

/*3. List all customers along with their zip codes that live in NC or SC*/
SELECT customer_name, customer_zip
FROM customers
WHERE customer_state = 'NC'
OR customer_state = 'SC';

/*4. List all titles that have been sold along with the artist , order date, and ship date*/
SELECT items.title, items.artist, orders.order_date, orders.ship_date
FROM items
INNER JOIN orders;

SELECT items.title, items.artist, orders.order_date, orders.ship_date
FROM items
INNER JOIN orders;

/*5. List all item id, title, artist, unit price, and on hand by ascending order by price*/
SELECT item_id, title, artist, unit_price, on_hand
FROM items
ORDER BY unit_price;

/*6. List all item id, title, artist, unit price, and on hand for all items with a unit price that is more than $100*/
SELECT item_id, title, artist, unit_price, on_hand
FROM items
WHERE unit_price > 100.00;

/*7. List all item id, title, artist, unit price, and on hand for all items where there are more than 300 on hand*/
SELECT item_id, title, artist, unit_price, on_hand
FROM items
WHERE on_hand > 300;

/*8. List all titles along with their unit price and retail price (retail price is unit price doubled)*/
SELECT title, unit_price, unit_price * 2 AS retail_price
FROM items;

/*9. List all customers that have placed an order in 2014 along with their phone numbers*/
SELECT customers.customer_id, customers.customer_name, customers.customer_phone, orders.order_date
FROM customers, orders
WHERE customers.customer_id=orders.customer_id AND YEAR(orders.order_date)=2014;

/*10. List all artists wth the number of their prints that have been sold*/
SELECT items.artist, orderline.order_qty
FROM items, orderline
WHERE items.item_id=orderline.item_id
GROUP BY items.item_id;

/*11. List all titles that have a unit price between $40.00 and $100.00*/
SELECT title
FROM items
WHERE unit_price BETWEEN 40.00 and 100.00;

/*12. List all customers, title, artist, quantity ordered*/
SELECT customers.customer_name, items.title, items.artist, orderline.order_qty
FROM customers 
	JOIN orders 
		ON customers.customer_id = orders.customer_id
	JOIN orderline
		ON orders.order_id = orderline.order_id
	JOIN items
		ON orderline.item_id = items.item_id;

/*13. List all customers along with the total revenue received from that customer(revenue wold be total retail price)*/
SELECT customers.customer_name, items.unit_price
FROM customers
	JOIN orders
		ON customers.customer_id = orders.customer_id
	JOIN orderline
		ON orders.order_id = orderline.order_id
	JOIN items
		ON orderline.item_id = items.item_id;
        
/*14. List each state and the number of each customers from that state*/
SELECT customer_state, COUNT(*)
FROM customers
GROUP BY customers.customer_state;