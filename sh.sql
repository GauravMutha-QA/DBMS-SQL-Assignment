CREATE TABLE product (
    product_id NUMBER PRIMARY KEY,
    name VARCHAR2(255),
    description CLOB,
    quantity NUMBER,
    price NUMBER(10,2)
);

CREATE TABLE UserTable (
    User_Id NUMBER PRIMARY KEY,
    First_Name VARCHAR2(50),
    Last_Name VARCHAR2(50),
    Phone_No VARCHAR2(15),
    Email VARCHAR2(100)
);

CREATE TABLE OrderTable (
    Order_Id NUMBER PRIMARY KEY,
    User_Id NUMBER,
    Total_Amount NUMBER(10,2),
    Date_Created DATE,
    CONSTRAINT fk_user FOREIGN KEY (User_Id) REFERENCES UserTable(User_Id)
);

CREATE TABLE OrderLine (
    Order_Id NUMBER,
    Product_Id NUMBER,
    Quantity NUMBER,
    PRIMARY KEY (Order_Id, Product_Id),
    CONSTRAINT fk_order FOREIGN KEY (Order_Id) REFERENCES OrderTable(Order_Id),
    CONSTRAINT fk_product FOREIGN KEY (Product_Id) REFERENCES Product(Product_Id)
);
select * from OrderTable;

INSERT INTO Product VALUES (1, 'Product A', 'Description A', 10, 29.99);
INSERT INTO Product VALUES (2, 'Product B', 'Description B', 5, 49.99);
INSERT INTO Product VALUES (3, 'Product C', 'Description C', 8, 19.99);
INSERT INTO Product VALUES  (4, 'Product D', 'Description D', 12, 39.99);
INSERT INTO Product VALUES (5, 'Product E', 'Description E', 15, 9.99);

INSERT INTO UserTable VALUES (1, 'John', 'Doe', '123-456-7890', 'john.doe@email.com');
INSERT INTO UserTable VALUES (2, 'Jane', 'Smith', '987-654-3210', 'jane.smith@email.com');
INSERT INTO UserTable VALUES (3, 'Bob', 'Johnson', '555-555-5555', 'bob.johnson@email.com');
INSERT INTO UserTable VALUES (4, 'Alice', 'Williams', '111-222-3333', 'alice.williams@email.com');
INSERT INTO UserTable VALUES (5, 'Charlie', 'Brown', '444-777-8888', 'charlie.brown@email.com');

INSERT INTO OrderTable VALUES (101, 1, 129.95, TO_DATE('2024-01-14', 'YYYY-MM-DD'));
INSERT INTO OrderTable VALUES (102, 2, 299.99, TO_DATE('2024-01-14', 'YYYY-MM-DD'));
INSERT INTO OrderTable VALUES (103, 3, 79.95, TO_DATE('2024-01-14', 'YYYY-MM-DD'));
INSERT INTO OrderTable VALUES (104, 1, 199.95, TO_DATE('2024-01-13', 'YYYY-MM-DD'));
INSERT INTO OrderTable VALUES (105, 4, 49.99, TO_DATE('2024-01-13', 'YYYY-MM-DD'));

-- Insert data into OrderLine table
INSERT INTO OrderLine VALUES (101, 1, 2);
INSERT INTO OrderLine VALUES (101, 2, 1);
INSERT INTO OrderLine VALUES (102, 3, 5);
INSERT INTO OrderLine VALUES (103, 4, 3);
INSERT INTO OrderLine VALUES (104, 1, 4);
INSERT INTO OrderLine VALUES (104, 3, 2);
INSERT INTO OrderLine VALUES (105, 5, 1);

SELECT * FROM OrderTable WHERE Date_Created = TO_DATE('2024-01-14', 'YYYY-MM-DD');

SELECT * FROM (
    SELECT Order_Id, Total_Amount, ROW_NUMBER() OVER (ORDER BY Total_Amount DESC) as rn
    FROM OrderTable
) WHERE rn = 2;

SELECT ot.*
FROM OrderTable ot
JOIN (
    SELECT Order_Id, COUNT(*) as ItemCount
    FROM OrderLine
    GROUP BY Order_Id
    HAVING COUNT(*) > 1
) ol ON ot.Order_Id = ol.Order_Id;

SELECT ot.*
FROM OrderTable ot
JOIN OrderLine ol ON ot.Order_Id = ol.Order_Id
WHERE ol.Product_Id = 1;


SELECT SUM(ot.Total_Amount) AS TotalSale
FROM OrderTable ot
WHERE ot.Date_Created = TO_DATE('2024-01-14', 'YYYY-MM-DD');


SELECT ot.*
FROM OrderTable ot
WHERE ot.User_Id = 1 -- Replace 1 with the desired User Id
ORDER BY ot.Date_Created ASC;
