-- A1
-- COMPLETE CITY NAME, COMPLETE STATE NAME, AIRPORT CODE, THE COMPLETE AIRLINE, NUM OF PASS

SELECT city.city_name as origin_city, state.state_name as origin_state, airport.airport_id, carrier.unique_carrier_name as airline_name, flights.passenger as pass
FROM flights
INNER JOIN airport ON flights.origin_airport_id = airport.airport_id
INNER JOIN carrier ON flights.unique_carrier_entity = carrier.unique_carrier_entity
INNER JOIN city ON airport.city_abv = city.city_abv
INNER JOIN state ON city.state_abv = state.state_abv
WHERE state.state_abv like 'CO';

-- A2
-- COMPLETE CITY NAME, COMPLETE STATE NAME, AIRPORT CODE, THE COMPLETE AIRLINE, & FREIGHT

SELECT city.city_name as origin_city, state.state_name as origin_state, airport.airport_id, carrier.unique_carrier_name as airline_name, flights.freight as freight
FROM flights
INNER JOIN airport ON flights.origin_airport_id = airport.airport_id
INNER JOIN carrier ON flights.unique_carrier_entity = carrier.unique_carrier_entity
INNER JOIN city ON airport.city_abv = city.city_abv
INNER JOIN state ON city.state_abv = state.state_abv
WHERE state.state_abv like 'CO';

-- A3
-- How many passengers arrived in Colorado from outside Colorado? Display the following information in this format: Origin city name & state, destination city in colorado, airline name

SELECT SUM(passenger)
FROM flights f, city c, airport o
WHERE f.origin_airport_id = o.airport_id
AND o.city_abv = c.city_abv
AND c.state_abv != 'CO';

SELECT oc.city_name AS origin_city_name, oc.state_abv AS state, dc.city_name AS destination_city, c.carrier_name, f.passenger
FROM flights f, city oc, city dc, airport oa, airport da, carrier c
WHERE f.origin_airport_id = oa.airport_id
AND f.dest_airport_id = da.airport_id
AND oa.city_abv = oc.city_abv
AND da.city_abv = dc.city_abv
AND c.unique_carrier_entity = f.unique_carrier_entity
AND oc.state_abv != 'CO';

--A4
--List all the flights into Denver that the distance was between 500 and 1200 miles. Display the following information: Origin city and state, airline name

SELECT oc.city_name AS origin_city_name, oc.state_abv AS state, carrier.unique_carrier_name
FROM flights f, city oc, city dc, carrier, airport oa, airport da, distance d
WHERE f.origin_airport_id = oa.airport_id
AND f.dest_airport_id = da.airport_id
AND oa.city_abv = oc.city_abv
AND da.city_abv = dc.city_abv
AND f.unique_carrier_entity = carrier.unique_carrier_entity
AND d.origin_airport_id = f.origin_airport_id
AND d.dest_airport_id = f.dest_airport_id
AND d.distance < 1200
AND d.distance > 500;
