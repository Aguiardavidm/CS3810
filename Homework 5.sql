-- Canada_AirCan, USA_United, UK_BA
CREATE TABLE airlines(
	airline_name VARCHAR (100),
	country_abv VARCHAR (100),
	country_code integer,
	PRIMARY KEY (airline_name));
	
-- Torono and Montreal in Canada, New York and Chicago in the USA, London and Edinburgh in the UK, Paris and Nice in France.
CREATE TABLE city(
	city_name VARCHAR (100),
	country_abv VARCHAR (100),
	PRIMARY KEY (city_name));
	
-- Customer_ first name, last name, mailing address, +- phone number, +- email 
CREATE TABLE person(
	full_name VARCHAR (200),
	first_name VARCHAR (100),
	last_name VARCHAR (100),
	mailing_address VARCHAR (100),
	phone_number integer,
	PRIMARY KEY (full_name, address));
	
-- Address_ street, city, province or state, postal code, country
CREATE TABLE address(
	address_id SERIAL,
	street VARCHAR (100),
	city VARCHAR (100),
	state VARCHAR (100),
	postal_code integer,
	country VARCHAR (100),
	PRIMARY KEY (address_id));
	
-- Phone_ country code, city/area code, local number
CREATE TABLE phone(
	full_phone integer,
	country_code integer,
	city_code integer,
	local_code integer,
	PRIMARY KEY (full_phone));
	
CREATE TABLE flight(
	origin_city_name VARCHAR (100),
	dest_city_name VARCHAR (100),
	flight_length integer,
	booking_number integer,
	city_code integer, 
	booking_date VARCHAR (100),
	flight_number VARCHAR (100),
	city_code integer, 
	departure_time_date VARCHAR (100),
	arrival_time_date VARCHAR (100),
	payment_person VARCHAR (100),
	ticket_person VARCHAR (100),
	PRIMARY KEY (flight_number, ticket_person));
