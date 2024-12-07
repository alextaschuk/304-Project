CREATE DATABASE orders;
go

USE orders;
go

DROP TABLE review;
DROP TABLE shipment;
DROP TABLE productinventory;
DROP TABLE warehouse;
DROP TABLE orderproduct;
DROP TABLE incart;
DROP TABLE product;
DROP TABLE category;
DROP TABLE ordersummary;
DROP TABLE paymentmethod;
DROP TABLE customer;

CREATE TABLE customer (
    customerId          INT IDENTITY,
    firstName           VARCHAR(40),
    lastName            VARCHAR(40),
    email               VARCHAR(50),
    phonenum            VARCHAR(20),
    address             VARCHAR(50),
    city                VARCHAR(40),
    state               VARCHAR(20),
    postalCode          VARCHAR(20),
    country             VARCHAR(40),
    userid              VARCHAR(20),
    password            VARCHAR(30),
    PRIMARY KEY (customerId)
);

CREATE TABLE paymentmethod (
    paymentMethodId     INT IDENTITY,
    paymentType         VARCHAR(20),
    paymentNumber       VARCHAR(30),
    paymentExpiryDate   DATE,
    customerId          INT,
    PRIMARY KEY (paymentMethodId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE ordersummary (
    orderId             INT IDENTITY,
    orderDate           DATETIME,
    totalAmount         DECIMAL(10,2),
    shiptoAddress       VARCHAR(50),
    shiptoCity          VARCHAR(40),
    shiptoState         VARCHAR(20),
    shiptoPostalCode    VARCHAR(20),
    shiptoCountry       VARCHAR(40),
    customerId          INT,
    PRIMARY KEY (orderId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE category (
    categoryId          INT IDENTITY,
    categoryName        VARCHAR(50),    
    PRIMARY KEY (categoryId)
);

CREATE TABLE product (
    productId           INT IDENTITY,
    productName         VARCHAR(40),
    productPrice        DECIMAL(10,2),
    productImageURL     VARCHAR(100),
    productImage        VARBINARY(MAX),
    productDesc         VARCHAR(1000),
    categoryId          INT,
    PRIMARY KEY (productId),
    FOREIGN KEY (categoryId) REFERENCES category(categoryId)
);

CREATE TABLE orderproduct (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE incart (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE warehouse (
    warehouseId         INT IDENTITY,
    warehouseName       VARCHAR(30),    
    PRIMARY KEY (warehouseId)
);

CREATE TABLE shipment (
    shipmentId          INT IDENTITY,
    shipmentDate        DATETIME,   
    shipmentDesc        VARCHAR(100),   
    warehouseId         INT, 
    PRIMARY KEY (shipmentId),
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE productinventory ( 
    productId           INT,
    warehouseId         INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (productId, warehouseId),   
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE review (
    reviewId            INT IDENTITY,
    reviewRating        INT,
    reviewDate          DATETIME,   
    customerId          INT,
    productId           INT,
    reviewComment       VARCHAR(1000),          
    PRIMARY KEY (reviewId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO category(categoryName) VALUES ('Cool Plushies');
INSERT INTO category(categoryName) VALUES ('Silly Plushies');
INSERT INTO category(categoryName) VALUES ('Smart Plushies');
INSERT INTO category(categoryName) VALUES ('Funny Plushies');
INSERT INTO category(categoryName) VALUES ('Cute Plushies');
INSERT INTO category(categoryName) VALUES ('Fancy Plushies');
INSERT INTO category(categoryName) VALUES ('Sporty Plushies');
INSERT INTO category(categoryName) VALUES ('Casual Plushies');

INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Cool Professor Lawrence', 1, 'A cool plushie of Professor Lawrence', 18.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Silly Professor Lawrence', 2, 'A silly plushie of Professor Lawrence', 19.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Smart Professor Lawrence', 3, 'A smart plushie of Professor Lawrence', 10.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Funny Professor Lawrence', 4, 'A funny plushie of Professor Lawrence', 22.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Cute Professor Lawrence', 5, 'A cute plushie of Professor Lawrence', 21.35);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Fancy Professor Lawrence', 6, 'A fancy plushie of Professor Lawrence', 25.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Sporty Professor Lawrence', 7, 'A sporty plushie of Professor Lawrence', 30.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Casual Professor Lawrence', 8, 'A casual plushie of Professor Lawrence', 40.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Adventurous Professor Lawrence', 1, 'An adventurous plushie of Professor Lawrence', 97.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Sleepy Professor Lawrence', 2, 'A sleepy plushie of Professor Lawrence', 31.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Happy Professor Lawrence', 3, 'A happy plushie of Professor Lawrence', 21.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Grumpy Professor Lawrence', 4, 'A grumpy plushie of Professor Lawrence', 38.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Excited Professor Lawrence', 5, 'An excited plushie of Professor Lawrence', 23.25);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Curious Professor Lawrence', 6, 'A curious plushie of Professor Lawrence', 15.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Brave Professor Lawrence', 7, 'A brave plushie of Professor Lawrence', 17.45);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Shy Professor Lawrence', 8, 'A shy plushie of Professor Lawrence', 39.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Energetic Professor Lawrence', 1, 'An energetic plushie of Professor Lawrence', 62.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Mischievous Professor Lawrence', 2, 'A mischievous plushie of Professor Lawrence', 9.20);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Thoughtful Professor Lawrence', 3, 'A thoughtful plushie of Professor Lawrence', 81.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Playful Professor Lawrence', 4, 'A playful plushie of Professor Lawrence', 10.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Serious Professor Lawrence', 5, 'A serious plushie of Professor Lawrence', 21.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Joyful Professor Lawrence', 6, 'A joyful plushie of Professor Lawrence', 14.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Calm Professor Lawrence', 7, 'A calm plushie of Professor Lawrence', 18.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Friendly Professor Lawrence', 8, 'A friendly plushie of Professor Lawrence', 19.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Wise Professor Lawrence', 1, 'A wise plushie of Professor Lawrence', 18.40);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Gentle Professor Lawrence', 2, 'A gentle plushie of Professor Lawrence', 9.65);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Bold Professor Lawrence', 3, 'A bold plushie of Professor Lawrence', 14.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Charming Professor Lawrence', 4, 'A charming plushie of Professor Lawrence', 21.05);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Adorable Professor Lawrence', 5, 'An adorable plushie of Professor Lawrence', 14.00);

INSERT INTO warehouse(warehouseName) VALUES ('Main warehouse');
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (1, 1, 5, 18);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (2, 1, 10, 19);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (3, 1, 3, 10);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (4, 1, 2, 22);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (5, 1, 6, 21.35);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (6, 1, 3, 25);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (7, 1, 1, 30);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (8, 1, 0, 40);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (9, 1, 2, 97);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (10, 1, 3, 31);

INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Arnold', 'Anderson', 'a.anderson@gmail.com', '204-111-2222', '103 AnyWhere Street', 'Winnipeg', 'MB', 'R3X 45T', 'Canada', 'arnold' , '304Arnold!');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Bobby', 'Brown', 'bobby.brown@hotmail.ca', '572-342-8911', '222 Bush Avenue', 'Boston', 'MA', '22222', 'United States', 'bobby' , '304Bobby!');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Candace', 'Cole', 'cole@charity.org', '333-444-5555', '333 Central Crescent', 'Chicago', 'IL', '33333', 'United States', 'candace' , '304Candace!');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Darren', 'Doe', 'oe@doe.com', '250-807-2222', '444 Dover Lane', 'Kelowna', 'BC', 'V1V 2X9', 'Canada', 'darren' , '304Darren!');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Elizabeth', 'Elliott', 'engel@uiowa.edu', '555-666-7777', '555 Everwood Street', 'Iowa City', 'IA', '52241', 'United States', 'beth' , '304Beth!');

-- Order 1 can be shipped as have enough inventory
DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (1, '2019-10-15 10:25:55', 91.70)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 1, 1, 18)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 2, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 10, 1, 31);

INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-16 18:00:00', 106.75)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 5, 21.35);

-- Order 3 cannot be shipped as do not have enough inventory for item 7
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (3, '2019-10-15 3:30:22', 140)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 6, 2, 25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 7, 3, 30);

INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-17 05:45:11', 327.85)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 3, 4, 10)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 8, 3, 40)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 13, 3, 23.25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 28, 2, 21.05)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 29, 4, 14);

INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (5, '2019-10-15 10:25:55', 277.40)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 4, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 19, 2, 81)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 20, 3, 10);

-- New SQL DDL for lab 8
UPDATE Product SET productImageURL = 'img/1.jpg' WHERE ProductId = 1;
UPDATE Product SET productImageURL = 'img/2.jpg' WHERE ProductId = 2;
UPDATE Product SET productImageURL = 'img/3.jpg' WHERE ProductId = 3;
UPDATE Product SET productImageURL = 'img/4.jpg' WHERE ProductId = 4;
UPDATE Product SET productImageURL = 'img/5.jpg' WHERE ProductId = 5;

-- Loads image data for product 1
UPDATE Product SET productImage = 0xffd8ffe000104a46494600010100000100010000ffdb00840009060712131215131313151515171817171515171717181718171717161717171517181d2820181a251d151721312125292b2e2e2e171f3338332d37282d2e2b010a0a0a0e0d0e1a10101b2d251f252b2d2d2d2d2f2d2d2b2e2d2d2d2d2d2d2b2b2b2d2d2d2d2d2d2d2d2d2b2d2d2d2d2d2d2d2b2d2d2b2d2d2d2d2b2d2d2d2d2bffc000110800c2010303012200021101031101ffc4001b00000105010100000000000000000000000200010304050607ffc4004010000103020304080403060505010000000100021103210431410512516106132232718191a152b1c1d14272f0236282b2e1f11415163392345373a2d207ffc4001a010002030101000000000000000000000000010203040506ffc4002a1100020201040201020603000000000000000102031104122131134151226105323342819171a1d1ffda000c03010002110311003f00810945099672c1932772125002052053129a54931325053ca865105222c9779284011a004d6a2081a51b5458c508d81353289ed82900aa051c2900285c80037522d44122efCREATE DATABASE orders;
go

USE orders;
go

DROP TABLE review;
DROP TABLE shipment;
DROP TABLE productinventory;
DROP TABLE warehouse;
DROP TABLE orderproduct;
DROP TABLE incart;
DROP TABLE product;
DROP TABLE category;
DROP TABLE ordersummary;
DROP TABLE paymentmethod;
DROP TABLE customer;

CREATE TABLE customer (
    customerId          INT IDENTITY,
    firstName           VARCHAR(40),
    lastName            VARCHAR(40),
    email               VARCHAR(50),
    phonenum            VARCHAR(20),
    address             VARCHAR(50),
    city                VARCHAR(40),
    state               VARCHAR(20),
    postalCode          VARCHAR(20),
    country             VARCHAR(40),
    userid              VARCHAR(20),
    password            VARCHAR(30),
    PRIMARY KEY (customerId)
);

CREATE TABLE paymentmethod (
    paymentMethodId     INT IDENTITY,
    paymentType         VARCHAR(20),
    paymentNumber       VARCHAR(30),
    paymentExpiryDate   DATE,
    customerId          INT,
    PRIMARY KEY (paymentMethodId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE ordersummary (
    orderId             INT IDENTITY,
    orderDate           DATETIME,
    totalAmount         DECIMAL(10,2),
    shiptoAddress       VARCHAR(50),
    shiptoCity          VARCHAR(40),
    shiptoState         VARCHAR(20),
    shiptoPostalCode    VARCHAR(20),
    shiptoCountry       VARCHAR(40),
    customerId          INT,
    PRIMARY KEY (orderId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE category (
    categoryId          INT IDENTITY,
    categoryName        VARCHAR(50),    
    PRIMARY KEY (categoryId)
);

CREATE TABLE product (
    productId           INT IDENTITY,
    productName         VARCHAR(40),
    productPrice        DECIMAL(10,2),
    productImageURL     VARCHAR(100),
    productImage        VARBINARY(MAX),
    productDesc         VARCHAR(1000),
    categoryId          INT,
    PRIMARY KEY (productId),
    FOREIGN KEY (categoryId) REFERENCES category(categoryId)
);

CREATE TABLE orderproduct (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE incart (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE warehouse (
    warehouseId         INT IDENTITY,
    warehouseName       VARCHAR(30),    
    PRIMARY KEY (warehouseId)
);

CREATE TABLE shipment (
    shipmentId          INT IDENTITY,
    shipmentDate        DATETIME,   
    shipmentDesc        VARCHAR(100),   
    warehouseId         INT, 
    PRIMARY KEY (shipmentId),
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE productinventory ( 
    productId           INT,
    warehouseId         INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (productId, warehouseId),   
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE review (
    reviewId            INT IDENTITY,
    reviewRating        INT,
    reviewDate          DATETIME,   
    customerId          INT,
    productId           INT,
    reviewComment       VARCHAR(1000),          
    PRIMARY KEY (reviewId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO category(categoryName) VALUES ('Cool Plushies');
INSERT INTO category(categoryName) VALUES ('Silly Plushies');
INSERT INTO category(categoryName) VALUES ('Smart Plushies');
INSERT INTO category(categoryName) VALUES ('Funny Plushies');
INSERT INTO category(categoryName) VALUES ('Cute Plushies');
INSERT INTO category(categoryName) VALUES ('Fancy Plushies');
INSERT INTO category(categoryName) VALUES ('Sporty Plushies');
INSERT INTO category(categoryName) VALUES ('Casual Plushies');

INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Cool Professor Lawrence', 1, 'A cool plushie of Professor Lawrence', 18.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Silly Professor Lawrence', 2, 'A silly plushie of Professor Lawrence', 19.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Smart Professor Lawrence', 3, 'A smart plushie of Professor Lawrence', 10.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Funny Professor Lawrence', 4, 'A funny plushie of Professor Lawrence', 22.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Cute Professor Lawrence', 5, 'A cute plushie of Professor Lawrence', 21.35);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Fancy Professor Lawrence', 6, 'A fancy plushie of Professor Lawrence', 25.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Sporty Professor Lawrence', 7, 'A sporty plushie of Professor Lawrence', 30.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Casual Professor Lawrence', 8, 'A casual plushie of Professor Lawrence', 40.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Adventurous Professor Lawrence', 1, 'An adventurous plushie of Professor Lawrence', 97.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Sleepy Professor Lawrence', 2, 'A sleepy plushie of Professor Lawrence', 31.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Happy Professor Lawrence', 3, 'A happy plushie of Professor Lawrence', 21.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Grumpy Professor Lawrence', 4, 'A grumpy plushie of Professor Lawrence', 38.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Excited Professor Lawrence', 5, 'An excited plushie of Professor Lawrence', 23.25);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Curious Professor Lawrence', 6, 'A curious plushie of Professor Lawrence', 15.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Brave Professor Lawrence', 7, 'A brave plushie of Professor Lawrence', 17.45);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Shy Professor Lawrence', 8, 'A shy plushie of Professor Lawrence', 39.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Energetic Professor Lawrence', 1, 'An energetic plushie of Professor Lawrence', 62.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Mischievous Professor Lawrence', 2, 'A mischievous plushie of Professor Lawrence', 9.20);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Thoughtful Professor Lawrence', 3, 'A thoughtful plushie of Professor Lawrence', 81.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Playful Professor Lawrence', 4, 'A playful plushie of Professor Lawrence', 10.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Serious Professor Lawrence', 5, 'A serious plushie of Professor Lawrence', 21.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Joyful Professor Lawrence', 6, 'A joyful plushie of Professor Lawrence', 14.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Calm Professor Lawrence', 7, 'A calm plushie of Professor Lawrence', 18.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Friendly Professor Lawrence', 8, 'A friendly plushie of Professor Lawrence', 19.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Wise Professor Lawrence', 1, 'A wise plushie of Professor Lawrence', 18.40);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Gentle Professor Lawrence', 2, 'A gentle plushie of Professor Lawrence', 9.65);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Bold Professor Lawrence', 3, 'A bold plushie of Professor Lawrence', 14.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Charming Professor Lawrence', 4, 'A charming plushie of Professor Lawrence', 21.05);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Adorable Professor Lawrence', 5, 'An adorable plushie of Professor Lawrence', 14.00);

INSERT INTO warehouse(warehouseName) VALUES ('Main warehouse');
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (1, 1, 5, 18);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (2, 1, 10, 19);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (3, 1, 3, 10);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (4, 1, 2, 22);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (5, 1, 6, 21.35);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (6, 1, 3, 25);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (7, 1, 1, 30);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (8, 1, 0, 40);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (9, 1, 2, 97);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (10, 1, 3, 31);

INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Arnold', 'Anderson', 'a.anderson@gmail.com', '204-111-2222', '103 AnyWhere Street', 'Winnipeg', 'MB', 'R3X 45T', 'Canada', 'arnold' , '304Arnold!');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Bobby', 'Brown', 'bobby.brown@hotmail.ca', '572-342-8911', '222 Bush Avenue', 'Boston', 'MA', '22222', 'United States', 'bobby' , '304Bobby!');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Candace', 'Cole', 'cole@charity.org', '333-444-5555', '333 Central Crescent', 'Chicago', 'IL', '33333', 'United States', 'candace' , '304Candace!');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Darren', 'Doe', 'oe@doe.com', '250-807-2222', '444 Dover Lane', 'Kelowna', 'BC', 'V1V 2X9', 'Canada', 'darren' , '304Darren!');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Elizabeth', 'Elliott', 'engel@uiowa.edu', '555-666-7777', '555 Everwood Street', 'Iowa City', 'IA', '52241', 'United States', 'beth' , '304Beth!');

-- Order 1 can be shipped as have enough inventory
DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (1, '2019-10-15 10:25:55', 91.70)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 1, 1, 18)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 2, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 10, 1, 31);

INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-16 18:00:00', 106.75)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 5, 21.35);

-- Order 3 cannot be shipped as do not have enough inventory for item 7
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (3, '2019-10-15 3:30:22', 140)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 6, 2, 25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 7, 3, 30);

INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-17 05:45:11', 327.85)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 3, 4, 10)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 8, 3, 40)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 13, 3, 23.25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 28, 2, 21.05)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 29, 4, 14);

INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (5, '2019-10-15 10:25:55', 277.40)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 4, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 19, 2, 81)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 20, 3, 10);

-- New SQL DDL for lab 8
UPDATE Product SET productImageURL = 'img/1.jpg' WHERE ProductId = 1;
UPDATE Product SET productImageURL = 'img/2.jpg' WHERE ProductId = 2;
UPDATE Product SET productImageURL = 'img/3.jpg' WHERE ProductId = 3;
UPDATE Product SET productImageURL = 'img/4.jpg' WHERE ProductId = 4;
UPDATE Product SET productImageURL = 'img/5.jpg' WHERE ProductId = 5;

-- Loads image data for product 1
UPDATE Product SET productImage = 0xffd8ffe000104a46494600010100000100010000ffdb00840009060712131215131313151515171817171515171717181718171717161717171517181d2820181a251d151721312125292b2e2e2e171f3338332d37282d2e2b010a0a0a0e0d0e1a10101b2d251f252b2d2d2d2d2f2d2d2b2e2d2d2d2d2d2d2b2b2b2d2d2d2d2d2d2d2d2d2b2d2d2d2d2d2d2d2b2d2d2b2d2d2d2d2b2d2d2d2d2bffc000110800c2010303012200021101031101ffc4001b00000105010100000000000000000000000200010304050607ffc4004010000103020304080403060505010000000100021103210431410512516106132232718191a152b1c1d14272f0236282b2e1f11415163392345373a2d207ffc4001a010002030101000000000000000000000000010203040506ffc4002a1100020201040201020603000000000000000102031104122131134151226105323342819171a1d1ffda000c03010002110311003f00810945099672c1932772125002052053129a54931325053ca865105222c9779284011a004d6a2081a51b5458c508d81353289ed82900aa051c2900285c80037522d44122ef