/**************Drop the table if exists*******************/
drop table Company CASCADE CONSTRAINTS;
drop table Restaurant CASCADE CONSTRAINTS;
drop table Customer CASCADE CONSTRAINTS;
drop table Recommendations CASCADE CONSTRAINTS;
drop table Reviews CASCADE CONSTRAINTS;
drop table CreditCard CASCADE CONSTRAINTS;
drop table TakeOut CASCADE CONSTRAINTS;
drop table FoodCart CASCADE CONSTRAINTS;
drop table SitDown CASCADE CONSTRAINTS;
drop table Reservation CASCADE CONSTRAINTS;
Commit;

/**************************Create Table*******************************/
/**Create Company Table**/
CREATE TABLE Company
(Company_ID VARCHAR(10) NOT NULL,
Company_Name VARCHAR(30) NOT NULL, 
Description VARCHAR(100) NOT NULL, 
CONSTRAINT company_companyname_uk Unique (Company_Name),
CONSTRAINT company_companyID_pk PRIMARY KEY(Company_ID));

/**Create Restaurant Table**/
CREATE TABLE Restaurant
(Restaurant_ID VARCHAR(15) NOT NULL, 
Restaurant_Name VARCHAR(30) NOT NULL,
Company_ID VARCHAR(10) NOT NULL,
Descriptions VARCHAR(100) NOT NULL,
Menu VARCHAR(500) NOT NULL,
Listed_hours VARCHAR(30),
Active_closed CHAR(1) NOT NULL ,
Street_Address VARCHAR(100) NOT NULL,
City VARCHAR(30) NOT NULL,
State VARCHAR(30) NOT NULL,
Zip_code VARCHAR(10) NOT NULL,
Cuisine_type VARCHAR(20) NOT NULL,
Restaurant_type VARCHAR(20) NOT NULL,
CONSTRAINT Restaurant_ID_PK PRIMARY KEY(Restaurant_ID),
CONSTRAINT Restaurant_activclosed_ck check (Active_closed IN ('A', 'C')),
CONSTRAINT Restaurant_companyID_fk FOREIGN KEY(Company_ID) REFERENCES Company(Company_ID),
CONSTRAINT Restaurant_cuisinetype_ck CHECK (Cuisine_type IN 
('African', 'American', 'Asian', 'European', 'Hispanic')),CONSTRAINT Restaurant_restauranttype_ck CHECK (Restaurant_type IN ('Sitdown', 'Takeout', 'Foodcart')));

/**Create Customer Table**/
CREATE TABLE Customer
(Username VARCHAR(20) NOT NULL,
Password VARCHAR(30) NOT NULL, 
Firstname VARCHAR(20) NOT NULL,
Lastname VARCHAR(20) NOT NULL,
Email VARCHAR(100) NOT NULL,
Phone_Number VARCHAR(15) NOT NULL,
CONSTRAINT Customer_Email_uk UNIQUE (Email),
CONSTRAINT Customer_PhoneNumber_uk UNIQUE (Phone_Number),
CONSTRAINT Username_PK PRIMARY KEY(Username));

/**Create Recommendations Table**/
CREATE TABLE Recommendations
(
Recommendation_ID VARCHAR2(10) NOT NULL,
Comments VARCHAR2(300) NOT NULL,
Restaurant_ID VARCHAR2(15) NOT NULL,
Username VARCHAR2(20) NOT NULL,
CONSTRAINT Recommendations__pk PRIMARY KEY(Recommendation_ID),
CONSTRAINT Recommendations_Restaurant_FK FOREIGN KEY (Restaurant_ID) 
REFERENCES Restaurant(Restaurant_ID),
CONSTRAINT Recommendations_Customer_FK FOREIGN KEY (Username) 
REFERENCES Customer(Username)
);


/**Create Reviews Table**/
CREATE TABLE Reviews
(Review_ID VARCHAR(10) NOT NULL,
Review VARCHAR(300) NOT NULL, 
Rating NUMBER(2, 1) CHECK (Rating >= 0 AND Rating <= 5) NOT NULL,
Time_stamp Timestamp,
Restaurant_ID VARCHAR2(15) NOT NULL,
Username VARCHAR2(20) NOT NULL,
CONSTRAINT Reviews_ReviewID_pk PRIMARY KEY(Review_ID),
CONSTRAINT Reviews_Restaurant_FK FOREIGN KEY (Restaurant_ID) 
REFERENCES Restaurant(Restaurant_ID),
CONSTRAINT Reviews_Customer_FK FOREIGN KEY (Username) 
REFERENCES Customer(Username));

/**Create Creditcard Table**/
CREATE TABLE CreditCard
(Card_number VARCHAR2(20) NOT NULL,
Expiration_date DATE NOT NULL,
Username VARCHAR2(20) NOT NULL,
CONSTRAINT CreditCard_PK PRIMARY KEY (Card_number),
CONSTRAINT CreditCard_Customer_FK FOREIGN KEY (Username) 
REFERENCES Customer(Username));

/**Create Takeout Table**/
CREATE TABLE TakeOut 
(Trestaurant_id VARCHAR2(15) NOT NULL
                CONSTRAINT TakeOut_PK PRIMARY KEY,
Max_wait_time NUMBER(4,2) NOT NULL,
CONSTRAINT TakeOut_RestaurantID_fk FOREIGN KEY (Trestaurant_id) 
REFERENCES Restaurant(Restaurant_ID));

/**Create FoodCart Table**/
CREATE TABLE FoodCart (
Frestaurant_id VARCHAR2(15) NOT NULL
               CONSTRAINT FoodCart_PK PRIMARY KEY,
Licenced_status CHAR(1) CHECK (Licenced_status IN ('Y', 'N')) NOT NULL,
CONSTRAINT FoodCart_RestaurantID_fk FOREIGN KEY (Frestaurant_id) 
REFERENCES Restaurant(Restaurant_ID));

/**Create SitDown Table**/
CREATE TABLE SitDown
(Srestaurant_id VARCHAR2(15) NOT NULL
                CONSTRAINT SitDown_PK PRIMARY KEY,
Capacity NUMBER(5) NOT NULL,
CONSTRAINT SitDown_RestaurantID_FK FOREIGN KEY (Srestaurant_id) 
REFERENCES Restaurant(Restaurant_ID));

/**Create Reservation Table**/
CREATE TABLE Reservation
(Reservation_ID VARCHAR2(10) NOT NULL,
Start_timestamp VARCHAR2(60) NOT NULL,
End_timestamp VARCHAR2(60) NOT NULL,
Party_size NUMBER(3) NOT NULL,
Username VARCHAR2(20) NOT NULL,
Srestaurant_id VARCHAR2(10) NOT NULL,
CONSTRAINT Reservation_PK PRIMARY KEY (Reservation_ID),
CONSTRAINT Reservation_Customer_FK FOREIGN KEY (Username) REFERENCES Customer(Username),
CONSTRAINT Reservation_Restaurant_FK FOREIGN KEY (Srestaurant_id) REFERENCES SitDown(Srestaurant_id));

/**************************Insert Values*******************************/
/**********Company Table Value**********/
INSERT INTO Company (Company_ID, Company_Name, Description) 
VALUES ('Com1', 'Gorgeous', 'Gorgeous steak house experience.');
INSERT INTO Company (Company_ID, Company_Name, Description) 
VALUES ('Com2', 'Fork', 'Quick services.');
INSERT INTO Company (Company_ID, Company_Name, Description) 
VALUES ('Com3', 'Comfy', 'find your comfort, nice coffee');

/**********Restaurant Table Value**********/
INSERT INTO Restaurant (Restaurant_ID, Restaurant_Name, Descriptions, Menu, 
Listed_hours, Active_closed, Street_Address, City, State, Zip_Code, Cuisine_type, Restaurant_type, Company_ID) 
VALUES ('Res1', 'Night out', 'Good place for dating', 'Steak Menu', '09:30-20:00',
'A', '150 Huntington St.', 'Boston City', 'MA', '02115', 'African', 'Sitdown', 'Com1');
INSERT INTO Restaurant (Restaurant_ID, Restaurant_Name, Descriptions, Menu, 
Listed_hours, Active_closed, Street_Address, City, State, Zip_Code, Cuisine_type, Restaurant_type, Company_ID) 
VALUES ('Res2', 'Inside Out', 'Fast food', 'Fast food menu', '04:00-24:00',
'A', '133 Boylston Street.', 'Boston City', 'MA', '02115', 'American', 'Takeout', 'Com2');
INSERT INTO Restaurant (Restaurant_ID, Restaurant_Name, Descriptions, Menu, 
Listed_hours, Active_closed, Street_Address, City, State, Zip_Code, Cuisine_type, Restaurant_type, Company_ID) 
VALUES ('Res3', 'Sunny Brunch', 'Brunch at the cozy cafe was a delightful experience.', 'Brunch Menu', '09:30-17:00',
'A', '123 Sunny Street.', 'Boston City', 'MA', '02119', 'Asian', 'Sitdown', 'Com3');
INSERT INTO Restaurant (Restaurant_ID, Restaurant_Name, Descriptions, Menu, 
Listed_hours, Active_closed, Street_Address, City, State, Zip_Code, Cuisine_type, Restaurant_type, Company_ID) 
VALUES ('Res4', 'Fantasy', 'Good spot for Italian Food', 'Italian Menu', '09:30-22:00',
'A', '744 Columbus St.', 'Boston City', 'MA', '02120', 'European', 'Takeout', 'Com2');
INSERT INTO Restaurant (Restaurant_ID, Restaurant_Name, Descriptions, Menu, 
Listed_hours, Active_closed, Street_Address, City, State, Zip_Code, Cuisine_type, Restaurant_type, Company_ID) 
VALUES ('Res5', 'Wonder', 'African experience', 'African Menu', '09:40-24:00',
'A', '163 Cambridge St.', 'Boston City', 'MA', '02167', 'African', 'Takeout', 'Com3');
INSERT INTO Restaurant (Restaurant_ID, Restaurant_Name, Descriptions, Menu, 
Listed_hours, Active_closed, Street_Address, City, State, Zip_Code, Cuisine_type, Restaurant_type, Company_ID) 
VALUES ('Res6', 'Sage Bistro', 'To go place', 'Sage Bistro Signature Menu', '10:30-21:00',
'A', '1234 Amber St.', 'Boston City', 'MA', '02115', 'European', 'Foodcart', 'Com1');
INSERT INTO Restaurant (Restaurant_ID, Restaurant_Name, Descriptions, Menu, 
Listed_hours, Active_closed, Street_Address, City, State, Zip_Code, Cuisine_type, Restaurant_type, Company_ID) 
VALUES ('Res7', 'AB  Eatery', 'Nice food', 'AB Menu', '09:30-20:00',
'A', '345 Roxbury St.', 'Boston City', 'MA', '02119', 'Hispanic', 'Foodcart', 'Com1');
INSERT INTO Restaurant (Restaurant_ID, Restaurant_Name, Descriptions, Menu, 
Listed_hours, Active_closed, Street_Address, City, State, Zip_Code, Cuisine_type, Restaurant_type, Company_ID) 
VALUES ('Res8', 'Early Bird', 'Quality Breakfast Shop', 'Breakfast Menu', '07:00-11:00',
'A', '64 Washington Street', 'Boston City', 'MA', '02110', 'European', 'Foodcart', 'Com1');
INSERT INTO Restaurant (Restaurant_ID, Restaurant_Name, Descriptions, Menu, 
Listed_hours, Active_closed, Street_Address, City, State, Zip_Code, Cuisine_type, Restaurant_type, Company_ID) 
VALUES ('Res9', 'Lazy Bird', 'Quality Afternoon Tea Restaurant', 'Afternoon Tea Menu', '14:00-18:00',
'C', '655 Tremont Street', 'Boston City', 'MA', '02116', 'Hispanic', 'Sitdown', 'Com1');

/**********Customer Table Value**********/
INSERT INTO Customer (Username, Password, Firstname, Lastname, Email, Phone_Number) 
VALUES ('user008', '1234', 'Ann', 'Youin', 'an.yo@noeeu.com', '854-2062847');
INSERT INTO Customer (Username, Password, Firstname, Lastname, Email, Phone_Number) 
VALUES ('user002', '4583', 'Jae', 'Foster', 'jane.fosr@hotmail.com', '556-4839917');
INSERT INTO Customer (Username, Password, Firstname, Lastname, Email, Phone_Number) 
VALUES ('user003', 'bwbkxhianek', 'Eric', 'Brown', 'Brown.er23@gmail.com', '857-4390892');

/**********Recommendations Table Value**********/
INSERT INTO Recommendations (Recommendation_ID, Comments, Restaurant_ID, Username) 
VALUES ('Recommend1', 'Must try ', 'Res1', 'user008');
INSERT INTO Recommendations (Recommendation_ID, Comments, Restaurant_ID, Username) 
VALUES ('Recommend2', 'The cheeseburger is better than McDonald.', 'Res2', 'user002');
INSERT INTO Recommendations (Recommendation_ID, Comments, Restaurant_ID, Username) 
VALUES ('Recommend3', 'Need some improvement.', 'Res3', 'user003');

/**********Reviews Table Value **********/
INSERT INTO Reviews (Review_ID, Review, Rating, Time_stamp, Restaurant_ID, Username) 
VALUES ('Rew1', 'great.', 3, current_timestamp, 'Res1', 'user008');
INSERT INTO Reviews (Review_ID, Review, Rating, Time_stamp, Restaurant_ID, Username)
VALUES ('Rew2', 'Amazing chicken and well-done fries.', 5, current_timestamp, 'Res2', 'user002');
INSERT INTO Reviews (Review_ID, Review, Rating, Time_stamp, Restaurant_ID, Username) 
VALUES ('Rew3', 'The brunch offering only standard breakfast fare without any unique or creative options to truly set it apart from other dining experiences.', 2, current_timestamp, 'Res3', 'user003');

/**********CreditCard Table Value**********/
INSERT INTO CreditCard (Card_number, Expiration_date, Username)
VALUES ('1234567892', TO_DATE('2028-11-16', 'YYYY-MM-DD'), 'user008');
INSERT INTO CreditCard (Card_number, Expiration_date, Username)
VALUES ('8544569684', TO_DATE('2028-06-15','YYYY-MM-DD'), 'user002');
INSERT INTO CreditCard (Card_number, Expiration_date, Username)
VALUES ('759356281940', TO_DATE('2026-9-28','YYYY-MM-DD'), 'user003');

/******Takeout Table Value ****/
INSERT INTO TakeOut (Trestaurant_id, Max_wait_time)VALUES ('Res4', 30);
INSERT INTO TakeOut (Trestaurant_id, Max_wait_time)VALUES ('Res2', 50);
INSERT INTO TakeOut (Trestaurant_id, Max_wait_time) VALUES ('Res5', 50);

/******FoodCart Table Value ****/
INSERT INTO FoodCart (Frestaurant_id, Licenced_status) VALUES ('Res6', 'Y');
INSERT INTO FoodCart (Frestaurant_id, Licenced_status) VALUES ('Res7', 'Y');
INSERT INTO FoodCart (Frestaurant_id, Licenced_status) VALUES ('Res8', 'Y');

/******SitDown Table Value ****/
INSERT INTO SitDown (Srestaurant_id, Capacity) VALUES ('Res1', 50);
INSERT INTO SitDown (Srestaurant_id, Capacity) VALUES ('Res3', 80);
INSERT INTO SitDown (Srestaurant_id, Capacity) VALUES ('Res9', 90);

/**********Reservation Table Value**********/
INSERT INTO Reservation (Reservation_ID, Start_timestamp, End_timestamp, Party_size, Username, Srestaurant_id) 
VALUES ('Reserve001', '2023-12-24 18:00', '2023-12-24 19:00', 8, 'user008', 'Res1');
INSERT INTO Reservation (Reservation_ID, Start_timestamp, End_timestamp, Party_size, Username, Srestaurant_id) 
VALUES ('Reserve002', '2023-11-25 15:30', '2023-11-25 20:00', 4, 'user002', 'Res9');
INSERT INTO Reservation (Reservation_ID, Start_timestamp, End_timestamp, Party_size, Username, Srestaurant_id) 
VALUES ('Reserve003', '2023-12-16 17:00', '2023-12-16 19:00', 5, 'user003', 'Res3');

/**** double check table if values are populated***/
select * from Company;
select * from Restaurant;
select * from Customer;
select * from Recommendations ;
select * from Reviews ;
select * from Creditcard;
select * from TakeOut;
select * from FoodCart;
select * from SitDown;
select * from Reservation;

/**** Phase 5 **/
/** Queries 1:list all reviews for restaurants which has ratings >=4, including the restaurant's name and the review's details: **/
SELECT r.Restaurant_Name, rev.Review, rev.Rating, rev.Time_stamp
FROM Restaurant r
JOIN Reviews rev ON r.Restaurant_ID = rev.Restaurant_ID
WHERE rev.Rating >= 4; 

/** How many Sitdown restaurants have capacity larger than 20?**/
SELECT COUNT(*) AS NumberOfSitdownRestaurants FROM Sitdown WHERE Capacity > 20;

/** List of all restaurants offering 'Asian' cuisine**/
SELECT Restaurant_ID, Restaurant_Name
FROM Restaurant
WHERE Cuisine_Type = 'Asian';