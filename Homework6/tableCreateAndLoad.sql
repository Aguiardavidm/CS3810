CREATE TABLE country(
	country_code integer,
	country VARCHAR (100) UNIQUE,
	country_abv VARCHAR (100) UNIQUE,
	PRIMARY KEY (country));

-- Canada_AirCan, USA_United, UK_BA
CREATE TABLE airlines(
	airline_name VARCHAR (100),
	country VARCHAR (100) REFERENCES country(country),
	PRIMARY KEY (airline_name));
	
-- Torono and Montreal in Canada, New York and Chicago in the USA, London and Edinburgh in the UK, Paris and Nice in France.
CREATE TABLE city(
	city_name VARCHAR (100) UNIQUE,
	city_abv VARCHAR (100) UNIQUE,
	country VARCHAR (100) REFERENCES country(country),
	city_code integer,
	PRIMARY KEY (city_name));

	-- Phone_ country code, city/area code, local number
CREATE TABLE phone(
	full_phone VARCHAR (100),
	country_code integer,
	city_code integer,
	local_code integer,
	PRIMARY KEY (full_phone));
	
CREATE TABLE email(
	email_address VARCHAR (200),
	email_id integer,
	PRIMARY KEY (email_id));
	
-- Address_ street, city, province or state, postal code, country
CREATE TABLE address(
	address_id SERIAL,
	street VARCHAR (100),
	city VARCHAR (100),
	state VARCHAR (100),
	postal_code VARCHAR (100),
	country VARCHAR (100) REFERENCES country(country),
	PRIMARY KEY (address_id));	
	
-- Customer_ first name, last name, mailing address, +- phone number, +- email 
CREATE TABLE person(
	full_name VARCHAR (200) UNIQUE,
	first_name VARCHAR (100),
	last_name VARCHAR (100),
	mailing_address_id integer REFERENCES address(address_id),
	phone_number VARCHAR (100),
	email_id integer REFERENCES email(email_id),
	PRIMARY KEY (full_name, mailing_address_id));
		
CREATE TABLE flight(
	origin_city_name VARCHAR (100) REFERENCES city(city_name),
	dest_city_name VARCHAR (100) REFERENCES city(city_name),
	flight_length VARCHAR (100),
	booking_number integer,
	booking_date VARCHAR (100),
	flight_number VARCHAR (100),
	departure_time_date VARCHAR (100),
	arrival_time_date VARCHAR (100),
	payment_person VARCHAR (100) REFERENCES person(full_name),
	ticket_person VARCHAR (100)REFERENCES person(full_name),
	PRIMARY KEY (flight_number, ticket_person));

CREATE TABLE routes(
	origin_city_name VARCHAR (100),
	dest_city_name VARCHAR (100),
	airline_name VARCHAR (100),
	route_number integer UNIQUE,
	PRIMARY KEY (origin_city_name, dest_city_name));
	


\COPY country FROM 'C:\Users\aguia\Documents\MSU Fall 2017\Databases\homework5\country.csv' CSV HEADER;

\COPY airlines FROM 'C:\Users\aguia\Documents\MSU Fall 2017\Databases\homework5\airlines.csv' CSV HEADER;

\COPY city FROM 'C:\Users\aguia\Documents\MSU Fall 2017\Databases\homework5\city.csv' CSV HEADER;

\COPY phone FROM 'C:\Users\aguia\Documents\MSU Fall 2017\Databases\homework5\phone.csv' CSV HEADER;

\COPY email FROM 'C:\Users\aguia\Documents\MSU Fall 2017\Databases\homework5\email.csv' CSV HEADER;

\COPY address FROM 'C:\Users\aguia\Documents\MSU Fall 2017\Databases\homework5\address.csv' CSV HEADER;

\COPY person FROM 'C:\Users\aguia\Documents\MSU Fall 2017\Databases\homework5\person.csv' CSV HEADER;

\COPY flight FROM 'C:\Users\aguia\Documents\MSU Fall 2017\Databases\homework5\flight.csv' CSV HEADER;

\COPY routes FROM 'C:\Users\aguia\Documents\MSU Fall 2017\Databases\homework5\routes.csv' CSV HEADER;