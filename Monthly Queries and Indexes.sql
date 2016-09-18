/*1. Create a view named Under_100. It consists of the item_id, title, artist, unit_price and order_qty for every print with a unit_price under 100 dollars. */
CREATE VIEW Under_100 AS
SELECT items.item_id AS item_id, items.artist AS artist,
	items.unit_price AS unit_price, SUM(orderline.order_qty) AS order_qty
FROM (items JOIN orderline)
WHERE ((items.item_id = orderline.item_id) AND (items.unit_price < 100))
GROUP BY items.item_id;

/*2. Create a view named Allen. It consists of the customer_id, customer_name, customer_phone, title, and artist of each print ordered*/
CREATE VIEW Allen AS
SELECT customers.customer_id AS customer_id, customers.customer_name AS customer_name,
	customers.customer_phone AS customer_phone, items.artist AS artist
FROM (((customers JOIN items) JOIN orderline) JOIN orders)
WHERE ((customers.customer_id = orders.customer_id) AND (orders.order_id = orderline.order_id) AND (orderline.item_id = items.item_id))
GROUP BY items.item_id;

/*3. Create a view named orders. It consists of the item_id, title, artist, unit_price and order_qty for every print ordered in the range of 2014-01-01 and 2014-02-28*/
CREATE VIEW OrderView AS
SELECT items.item_id AS item_id, items.title AS title, items.artist AS artist,
        items.unit_price AS unit_price,
        SUM(orderline.order_qty) AS Orders
FROM ((items JOIN orderline) JOIN orders)
WHERE ((items.item_id = orderline.item_id) AND (orderline.order_id = orders.order_id) AND (order_date BETWEEN '2014-01-01' AND '2014-02-28'))
GROUP BY orders.order_id;

/*4. Create a view named zip_27. It consists of the customer_name, customer_phone, title, artist and date_shipped of each print ordered by a customer whose zip code begins with 27*/
CREATE VIEW zip_27 AS
SELECT customers.customer_name AS customer_name, customers.customer_phone AS customer_phone,
	items.title AS title, items.artist AS artist, orders.ship_date AS ship_date
FROM (((customers JOIN items) JOIN orders) JOIN orderline)
WHERE ((orderline.item_id = items.item_id) AND (customers.customer_id = orders.customer_id) AND (orders.order_id = orderline.order_id)
	AND (customers.customer_zip LIKE '27%'));

/*5. Create the following indexes. Use the indicated index name.
	a.	Create an index named customer_id on the customer_id field in the customers table.
	b.	Create an index named name on the customer_name field in the customers table.
	c.	Create an index named shipped on the customer_id and ship_date in the orders table.*/
CREATE INDEX customer_id
ON customers(customer_id);

CREATE INDEX name
ON customers(customer_name);

CREATE INDEX shipped
ON orders(customer_id, ship_date);

/*6. Drop the name index*/
ALTER TABLE customers DROP INDEX name;

/*7. Specify the integrity constraint that the unit_price of any print must be more than $35.*/
ALTER TABLE items
ADD CONSTRAINT chk_unitprice CHECK (unit_price > 35.00);

/*8. Ensure that the following are foreign keys (that is, specify referential integrity) within the prints database.
	a. customer_id is a foreign key in the orders table.
    b. Item_id is a foreign key in the orderline table.*/
ALTER TABLE `prints`.`customers` 
ADD PRIMARY KEY (`customer_id`)  COMMENT 'Assigns Primary to customers.customer_ID';

ALTER TABLE `prints`.`orders` 
ADD INDEX `customer_id_idx` (`customer_id` ASC);
ALTER TABLE `prints`.`orders` 
ADD CONSTRAINT `customer_id`
  FOREIGN KEY (`customer_id`)
  REFERENCES `prints`.`customers` (`customer_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


ALTER TABLE `prints`.`items` 
ADD PRIMARY KEY (`item_id`) COMMENT 'Assigns Primary to items.item_ID';
ALTER TABLE `prints`.`orderline` 
ADD CONSTRAINT `item_id`
  FOREIGN KEY (`item_id`)
  REFERENCES `prints`.`items` (`item_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

/*9. Add to the items table a new character field named type that is one character in length.*/
ALTER TABLE items
ADD type CHAR(1);

/*10. Change the type field in the items table to M for the print titled Skies Above.*/
UPDATE items
SET type = 'M'
WHERE title = 'Skies Above';

/*11. Change the length of the artist field in the items table to 30.*/
ALTER TABLE items
MODIFY artist CHAR(30);

/*12. What command would you use to delete the orders table from the prints database? (Do not delete the
orders table.)*/
DROP TABLE orders;