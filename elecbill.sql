
CREATE DATABASE electricity_bill;

CREATE TABLE electricity_connection_type
    (id INT(11) NOT NULL PRIMARY KEY,
    connection_name VARCHAR(20));

CREATE TABLE slab
    (id INT(11) NOT NULL PRIMARY KEY,
    connection_type_id INT(11) not NULL,
    from_unit INT(11),
    to_unit INT(11),
    rate DOUBLE,
    FOREIGN KEY(connection_type_id) REFERENCES electricity_connection_type(id));

CREATE TABLE meter
    (id INT(11) NOT NULL PRIMARY KEY,
    meter_number VARCHAR(100),
    building_id INT(11) NOT NULL,
    FOREIGN KEY(building_id) REFERENCES building(id));

CREATE TABLE building_type
    (id INT(11) NOT NULL PRIMARY KEY,
    name VARCHAR(100),
    connection_type_id INT(11) NOT NULL,
    FOREIGN KEY(connection_type_id) REFERENCES electricity_connection_type(id));

CREATE TABLE electricity_reading
    (id INT(11) NOT NULL PRIMARY KEY,
    meter_id INT(11) NOT NULL,
    day DATE, h1 INT(11), h2 INT(11), h3 INT(11), h4 INT(11), h5 INT(11), h6 INT(11), h7 INT(11), h8 INT(11), h9 INT(11), h10 INT(11), h11 INT(11), h12 INT(11),
    h13 INT(11), h14 INT(11), h15 INT(11), h16 INT(11), h17 INT(11), h18 INT(11), h19 INT(11), h20 INT(11), h21 INT(11), h22 INT(11), h23 INT(11), h24 INT(11),
    total_units INT(11) NOT NULL,
    FOREIGN KEY(meter_id) REFERENCES meter(id));

CREATE TABLE building
    (id INT(11) NOT NULL PRIMARY KEY,
    owner_name VARCHAR(100),
    address VARCHAR(100),
    building_type_id INT(11) NOT NULL,
    contact_number VARCHAR(100),
    email_address VARCHAR(100),
    FOREIGN KEY(building_type_id) REFERENCES building_type(id));

CREATE TABLE bill
    (id INT(11) NOT NULL PRIMARY KEY,
    meter_id INT(11) NOT NULL,
    month INT(11) NOT NULL,
    year INT(11) NOT NULL,
    due_date DATE,
    total_units INT(11) NOT NULL,
    payable_amount DOUBLE,
    is_payed TINYINT(1) NOT NULL,
    payment_data DATE,
    fine_amount DOUBLE,
    FOREIGN KEY(meter_id) REFERENCES meter(id));

INSERT INTO electricity_connection_type (id, connection_name) VALUES
(1, 'Residential'),
(2, 'Commercial');


INSERT INTO slab (id, connection_type_id, from_unit, to_unit, rate) VALUES
(1, 1, 0, 100, 0.5),
(2, 1, 101, 200, 0.75),
(3, 2, 0, 100, 1.0),
(4, 2, 101, 200, 1.5);


INSERT INTO building_type (id, name, connection_type_id) VALUES
(1, 'Library', 2),
(2, 'Police Station', 2),
(3, 'Museum', 2);

INSERT INTO building (id, owner_name, address, building_type_id, contact_number, email_address) VALUES
(27, 'DANNY YONG', 'NATIONAL LIBRARY, 100 VICTORIA ST, SINGAPORE 188064', 1, '+65 6332 3255', 'REF@NB.COM.SG'),
(28, 'SAURABH MITTAL', 'JURONG REGIONAL LIBRARY, 21 JURONG EAST CENTRAL 1, SINGAPORE 609732', 1, '+65 6332 3255', 'REF@NB.COM.SG'),
(29, 'JOHN DOE', 'CENTRAL POLICE STATION, 391 NEW BRIDGE ROAD, SINGAPORE 088762', 2, '+65 1800 255 0000', 'CONTACT@CPS.COM.SG'),
(30, 'JANE SMITH', 'WEST POLICE STATION, 1 JURONG WEST CENTRAL 2, SINGAPORE 648331', 2, '+65 1800 363 9999', 'CONTACT@WPS.COM.SG'),
(31, 'ALAN LEE', 'NATIONAL MUSEUM, 93 STAMFORD ROAD, SINGAPORE 178897', 3, '+65 6332 5645', 'INFO@NM.COM.SG');


INSERT INTO meter (id, meter_number, building_id) VALUES
(1, 'SG824012', 31),
(2, 'SG934826', 30),
(3, 'SG834015', 27),
(4, 'SG834016', 28),
(5, 'SG834017', 29);

INSERT INTO electricity_reading (id, meter_id, day, h1, h2, h3, h4, h5, h6, h7, h8, h9, h10, h11, h12, h13, h14, h15, h16, h17, h18, h19, h20, h21, h22, h23, h24, total_units) VALUES
(1, 1, '2023-01-01', 5, 6, 7, 5, 4, 3, 6, 7, 8, 5, 6, 5, 4, 3, 5, 7, 8, 6, 7, 5, 6, 7, 8, 6, 199),
(2, 2, '2023-01-01', 7, 8, 6, 5, 4, 3, 8, 7, 6, 5, 4, 7, 6, 5, 4, 7, 6, 5, 4, 7, 8, 6, 5, 7, 199),
(3, 3, '2023-01-01', 6, 7, 5, 4, 3, 6, 5, 4, 7, 6, 5, 4, 7, 6, 5, 4, 3, 6, 5, 4, 3, 6, 7, 6, 171),
(4, 4, '2023-01-01', 7, 8, 7, 6, 5, 4, 7, 6, 5, 4, 7, 6, 5, 4, 7, 6, 5, 4, 7, 6, 5, 4, 7, 7, 185),
(5, 5, '2023-01-01', 8, 7, 6, 5, 4, 7, 6, 5, 4, 7, 6, 5, 4, 7, 6, 5, 4, 7, 6, 5, 4, 7, 6, 7, 196);


INSERT INTO bill (id, meter_id, month, year, due_date, total_units, payable_amount, is_payed, payment_data, fine_amount) VALUES
(1, 1, 1, 2023, '2023-02-01', 19900, 696500, 0, NULL, 50.00),
(2, 2, 1, 2023, '2023-02-01', 19900, 696500, 0, NULL, 0.00),
(3, 3, 1, 2023, '2023-02-01', 17100, 59850, 1, '2023-01-25', 0.00),
(4, 4, 1, 2023, '2023-02-01', 18500, 64750, 1, '2023-01-27', 25.00),
(5, 5, 1, 2023, '2023-02-01', 19600, 68600, 0, NULL, 15.00);
