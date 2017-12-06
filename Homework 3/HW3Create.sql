CREATE TABLE airport
(
	airport_id integer,
	airport_seq_id integer,
	city_abv VARCHAR (3),
	PRIMARY KEY (airport_id)
);

CREATE TABLE carrier
(
	unique_carrier VARCHAR (10),
	airline_id integer,
	unique_carrier_name VARCHAR (100),
	unique_carrier_entity VARCHAR (10),
	carrier VARCHAR (100),
	region_abv VARCHAR (1),
	carrier_name VARCHAR (100),
	carrier_group integer,
	carrier_group_new integer,
	PRIMARY KEY (unique_carrier_entity)
);

CREATE TABLE carrier_date
(
	unique_carrier_entity VARCHAR (10),
	start_date VARCHAR (20),
	thru_date_source VARCHAR (10),
	PRIMARY KEY (unique_carrier_entity)
);

CREATE TABLE distance
(
	origin_airport_id integer,
	dest_airport_id integer,
	distance integer,
	distance_group integer,
	PRIMARY KEY (origin_airport_id, dest_airport_id)
);

CREATE TABLE flights
(
	year integer,
	month integer,
	class VARCHAR (1),
	passenger integer,
	freight integer,
	mail integer,
	ramp_to_ramp integer,
	air_time integer,
	origin_airport_id integer,
	dest_airport_id integer,
	flight_id integer,
	unique_carrier_entity VARCHAR (20),
	departures_scheduled integer,
	departures_performed integer,
	PRIMARY KEY (flight_id)
);

CREATE TABLE city
(
	city_name VARCHAR (100),
	city_abv VARCHAR (3),
	state_abv VARCHAR (2),
	wac integer,
	city_market_id integer,
	PRIMARY KEY (city_abv)
	
);

CREATE TABLE state
(
	state_abv VARCHAR (3),
	state_name VARCHAR (20),
	state_fips integer,
	PRIMARY KEY (state_abv)
);

alter table flights
	add constraint fk_origin_airport_id
	foreign key (origin_airport_id)
	REFERENCES airport (airport_id);
	
alter table flights
	add constraint fk_dest_airport_id
	foreign key (dest_airport_id)
	REFERENCES airport (airport_id);
	
alter table flights
	add constraint fk_unique_carrier_entity
	foreign key (unique_carrier_entity)
	REFERENCES carrier (unique_carrier_entity);
	
alter table airport
	add constraint fk_city_abv
	foreign key (city_abv)
	REFERENCES city (city_abv);
	
alter table carrier_date
	add constraint fk_carrier_date
	foreign key (unique_carrier_entity)
	REFERENCES carrier (unique_carrier_entity);
	
alter table distance
	add constraint fk_origin_airport_id
	foreign key (origin_airport_id)
	REFERENCES airport (airport_id);

alter table city
	add constraint fk_state_abv
	foreign key (state_abv)
	REFERENCES state (state_abv);
	