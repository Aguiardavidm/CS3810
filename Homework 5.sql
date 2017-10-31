CREATE TABLE country(
	country_code integer UNIQUE,
	country VARCHAR (100) UNIQUE,
	country_abv VARCHAR (100) UNIQUE,
	PRIMARY KEY (country_code));

-- Canada_AirCan, USA_United, UK_BA
CREATE TABLE airlines(
	airline_name VARCHAR (100),
	country_code integer REFERENCES country(country_code),
	PRIMARY KEY (airline_name));
	
-- Torono and Montreal in Canada, New York and Chicago in the USA, London and Edinburgh in the UK, Paris and Nice in France.
CREATE TABLE city(
	city_name VARCHAR (100) UNIQUE,
	city_code integer UNIQUE,
	country VARCHAR (100) REFERENCES country(country),
	PRIMARY KEY (city_name));

	-- Phone_ country code, city/area code, local number
CREATE TABLE phone(
	full_phone integer,
	country_code integer REFERENCES country(country_code),
	city_code integer REFERENCES city(city_code),
	local_code integer,
	PRIMARY KEY (full_phone));
	
-- Address_ street, city, province or state, postal code, country
CREATE TABLE address(
	address_id SERIAL,
	street VARCHAR (100),
	city VARCHAR (100) REFERENCES city(city_name),
	state VARCHAR (100),
	postal_code integer,
	country VARCHAR (100) REFERENCES country(country),
	PRIMARY KEY (address_id));	
	
-- Customer_ first name, last name, mailing address, +- phone number, +- email 
CREATE TABLE person(
	full_name VARCHAR (200) UNIQUE,
	first_name VARCHAR (100),
	last_name VARCHAR (100),
	mailing_address_id integer REFERENCES address(address_id),
	phone_number integer REFERENCES phone(full_phone),
	PRIMARY KEY (full_name, mailing_address_id));
		
CREATE TABLE flight(
	origin_city_name VARCHAR (100) REFERENCES city(city_name),
	dest_city_name VARCHAR (100) REFERENCES city(city_name),
	flight_length integer,
	booking_number integer,
	city_code integer REFERENCES city(city_code), 
	booking_date VARCHAR (100),
	flight_number VARCHAR (100),
	departure_time_date VARCHAR (100),
	arrival_time_date VARCHAR (100),
	payment_person VARCHAR (100) REFERENCES person(full_name),
	ticket_person VARCHAR (100)REFERENCES person(full_name),
	PRIMARY KEY (flight_number, ticket_person));

