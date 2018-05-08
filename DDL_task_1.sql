DROP TABLE IF EXISTS TRIP;
DROP TABLE IF EXISTS FIELD;
DROP TABLE IF EXISTS POSSIBLE_BUYER_X_CROP;
DROP TABLE IF EXISTS POSSIBLE_BUYER;
DROP TABLE IF EXISTS EMPLOYEE;
DROP TABLE IF EXISTS AGRICULTURAL_MACHINERY;
DROP TABLE IF EXISTS VILLAGE;
DROP TABLE IF EXISTS CROP;
DROP TABLE IF EXISTS FERTILIZER;


CREATE TABLE FERTILIZER
(
    fertilizer_id serial PRIMARY KEY NOT NULL,
    fertilizer_nm varchar(30),
    shelf_life_dt date
);

CREATE TABLE VILLAGE
(
    village_id serial PRIMARY KEY NOT NULL,
    village_nm varchar(30),
    district_nm varchar(30)
);

CREATE TABLE CROP
(
    crop_id serial PRIMARY KEY NOT NULL,
    crop_nm varchar(30),
    crop_desc text,
    crop_yield_rt decimal(4, 2) CONSTRAINT positive_crop_yield_rt CHECK (crop_yield_rt > 0)
);

CREATE TABLE AGRICULTURAL_MACHINERY
(
    machinery_id serial PRIMARY KEY NOT NULL,
    type_code smallint,
    machinery_nm varchar(30),
    release_dt date
);

CREATE TABLE EMPLOYEE
(
    employee_id serial PRIMARY KEY NOT NULL,
    first_nm varchar(30),
    last_nm varchar(30),
    middle_nm varchar(30),
    birth_dt date,
    mobile_phone_no char(11) CONSTRAINT mobile_phone_pattern CHECK (mobile_phone_no ~ '7[0-9]{10}')
);

CREATE TABLE POSSIBLE_BUYER
(
    buyer_id serial PRIMARY KEY NOT NULL,
    buyer_nm varchar(30),
    mobile_phone_no char(11) CONSTRAINT mobile_phone_pattern CHECK (mobile_phone_no ~ '7[0-9]{10}')
);

CREATE TABLE POSSIBLE_BUYER_X_CROP
(
  buyer_id integer NOT NULL REFERENCES POSSIBLE_BUYER(buyer_id),
  crop_id integer NOT NULL REFERENCES CROP(crop_id),
  PRIMARY KEY (buyer_id, crop_id)
);

CREATE TABLE FIELD
(
  field_id serial PRIMARY KEY NOT NULL,
  village_id integer NOT NULL REFERENCES VILLAGE(village_id),
  area_amt decimal(6, 2) CONSTRAINT positive_area_amt CHECK (area_amt > 0),
  crop_id integer NOT NULL REFERENCES CROP(crop_id),
  fertilizer_id integer NOT NULL REFERENCES FERTILIZER(fertilizer_id)
);

CREATE TABLE TRIP
(
  trip_id serial PRIMARY KEY NOT NULL,
  trip_dt date,
  field_id integer NOT NULL REFERENCES FIELD(field_id),
  machinery_id integer NOT NULL REFERENCES AGRICULTURAL_MACHINERY(machinery_id),
  employee_id integer NOT NULL REFERENCES EMPLOYEE(employee_id),
  weight_amt smallint CONSTRAINT positive_weight CHECK (weight_amt > 0)
);
