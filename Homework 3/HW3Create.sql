DROP TABLE aircraft_ , airport_ , carrier_ , carrier_dates , city_ , distance_ , flight_ , region_abv , state_ CASCADE;

CREATE TABLE distance_
(
	origin_ varchar (50),
	dest_ varchar (50),
	dist_ integer,
	dist_group integer,
	PRIMARY KEY (origin_, dest_)
);

CREATE TABLE region_abv
(
	region_abv varchar(1),
	region_ varchar(50),
	PRIMARY KEY(region_)
);

CREATE TABLE carrier_
(
	unique_carrier varchar (3),
	airline_id integer,
	carrier_nm varchar (200),
	carrier_ varchar (200),
	carrier_group integer,
	carrier_group_new integer,
	PRIMARY KEY (unique_carrier, airline_id,carrier_nm, carrier_,carrier_group, carrier_group_new)
);

CREATE TABLE carrier_dates
(
	carrier_ varchar (50),
	start_date date,
	PRIMARY KEY (carrier_, start_date)
);

CREATE TABLE aircraft_ 
(
	aircraft_group integer,
	aircraft_type integer,
	aircraft_config integer,
	seats_ integer,	
	payload_ integer,
	flight_id serial,
	PRIMARY KEY (aircraft_type, aircraft_config, aircraft_group, seats_ , payload_)
);

CREATE TABLE state_
(
	state_abv varchar (2),
	state_name varchar (50),
	fips_ integer,
	PRIMARY KEY (state_abv)
);

CREATE TABLE city_
(
	state_abv varchar (2),
	market_id integer,
	city_nm varchar (50),
	city_abv varchar (3),
	wac_ integer,
	PRIMARY KEY(city_abv)
);

CREATE TABLE airport_
(
	airport_id integer,
	airport_seq_id integer,
	city_abv varchar (3),
	PRIMARY KEY(airport_id)
);

CREATE TABLE flight_  
(
	month_ integer,
	class_ varchar (1), 
	passenger_ integer,
	freight_ integer,
	mail_ integer,
	ramp_to_ramp integer,
	air_time integer,
	origin_airport_id integer,
	dest_airport_id integer,
	departures_scheduled integer,
	departures_performed integer,
	flight_id serial,
	PRIMARY KEY (flight_id)
);

alter table city_
	add constraint fk_state_abv
	foreign key (state_abv)
	REFERENCES state_ (state_abv);
	
alter table flight_
	add constraint fk_origin_airport_id
	foreign key (origin_airport_id)
	REFERENCES airport_  (airport_id);
	
alter table flight_
	add constraint fk_dest_airport_id
	foreign key (dest_airport_id)
	REFERENCES airport_ (airport_id);
