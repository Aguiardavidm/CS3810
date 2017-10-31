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



-- Airline name, total number of flights, average distance, ratio of passengers to distance, ratio of freight to distance, correlation coefficient for passengers to freight, correlation coefficient for passengers to distance

