/*

CREATE TABLE city_population (
 state VARCHAR(50),
 city VARCHAR(50),
 population INT
);

-- Insert the data
INSERT INTO city_population (state, city, population) VALUES ('haryana', 'ambala', 100);
INSERT INTO city_population (state, city, population) VALUES ('haryana', 'panipat', 200);
INSERT INTO city_population (state, city, population) VALUES ('haryana', 'gurgaon', 300);
INSERT INTO city_population (state, city, population) VALUES ('punjab', 'amritsar', 150);
INSERT INTO city_population (state, city, population) VALUES ('punjab', 'ludhiana', 400);
INSERT INTO city_population (state, city, population) VALUES ('punjab', 'jalandhar', 250);
INSERT INTO city_population (state, city, population) VALUES ('maharashtra', 'mumbai', 1000);
INSERT INTO city_population (state, city, population) VALUES ('maharashtra', 'pune', 600);
INSERT INTO city_population (state, city, population) VALUES ('maharashtra', 'nagpur', 300);
INSERT INTO city_population (state, city, population) VALUES ('karnataka', 'bangalore', 900);
INSERT INTO city_population (state, city, population) VALUES ('karnataka', 'mysore', 400);
INSERT INTO city_population (state, city, population) VALUES ('karnataka', 'mangalore', 200);

Output Required:

state			highest_population	lowest_population
haryana			gurgaon				ambala
karnataka		bangalore			mangalore
maharashtra		mumbai				nagpur
punjab			ludhiana			amritsar


*/

SELECT state, MAX(CASE WHEN rank_ = 3 then city END) as highest_population,  MAX(CASE WHEN rank_ = 1 THEN city END) as lowest_population 
FROM (
select *, rank() over (partition by state order by population) as rank_ from city_population)
as A 
GROUP BY state

