USE crime_data;

#1
SELECT COUNT(DISTINCT(crime_type)) AS unique_crimes
FROM incident_reports;
## There are 16 Different Crime Types in the table.

#2
SELECT crime_type, COUNT(*) AS num_crimes
FROM incident_reports
GROUP BY crime_type
ORDER BY crime_type;
## The Query shows the number of incidents that occured for the different crime types, ordered by crime type alphabetically.

#3
SELECT COUNT(*) 
FROM incident_reports
WHERE TIMESTAMPDIFF(day, date_reported, date_occured) = 0;
## The query shows that the number of incidents that were reported on the same day they occured is 1,083,885.

#4
SELECT date_reported, date_occured, crime_type, TIMESTAMPDIFF(year, date_reported, date_occured) AS 'Difference in years'
FROM incident_reports
WHERE TIMESTAMPDIFF(year, date_reported, date_occured) != 0
ORDER BY TIMESTAMPDIFF(year, date_reported, date_occured);
## The query sh0ws the amount of time between the date reported and date occured in years, sorted from longest to shortest.

#5
SELECT YEAR(date_occured) AS year, COUNT(*) AS num_incidents
FROM incident_reports
WHERE YEAR(date_occured) BETWEEN 2012 AND 2021
GROUP BY YEAR(date_occured)
ORDER BY YEAR(date_occured) DESC;
## The query shows the count of incidents of all crimes by year, for the past 10 years. 

#6
SELECT *
FROM incident_reports
WHERE crime_type = 'ROBBERY';
## The query returns all columns with crime type of robbery.

#7
SELECT lmpd_division, incident_number, date_occured
FROM incident_reports
WHERE crime_type = 'ROBBERY'
ORDER BY lmpd_division AND date_occured;
## The query shows the LMPD Division, Incident Number, and Date Occured for the crime type of robbery. 

#8
SELECT date_occured, crime_type
FROM incident_reports
WHERE zip_code = 40202
ORDER BY crime_type;
## The query shows the crime type and date occured for all crimes that took place in zip code 40202.

SELECT date_occured, crime_type
FROM incident_reports
WHERE zip_code = 40202
ORDER BY date_occured;
## Ordered by Date Occured.

#9
SELECT zip_code, COUNT(*) AS num_thefts
FROM incident_reports
WHERE crime_type = 'VEHICLE BREAK-IN/THEFT'
GROUP BY zip_code
ORDER BY COUNT(zip_code) DESC;
## The Zip Code with the highest number of vehicle thefts is 40202, with 7153 thefts. The number of results is 44, because of the 44 Zip Codes.

#10
SELECT COUNT(DISTINCT(city)) AS num_cities
FROM incident_reports;
## There are 234 Different cities in the report table.

#11
SELECT city, COUNT(city) AS num_incidents
FROM incident_reports
GROUP BY city
ORDER BY COUNT(city) DESC;
## The city with the second highest number of incidents behind LOUISVILLE is LVIL, with 37,299 incidents. However, this may just be a typo error where LVIL is actually incidents that happened in Louisville, so the second highest should be LYNDON with 4,898.  

#12
SELECT uor_desc, crime_type
FROM incident_reports
WHERE crime_type != 'OTHER'
ORDER BY uor_desc;

SELECT uor_desc, crime_type
FROM incident_reports
WHERE crime_type != 'OTHER'
ORDER BY crime_type;
## The Uniform Offense Reporting column describes the type of incident in the specific crime type. It is a sub-group of the crime_type column.

#13
SELECT COUNT(DISTINCT(lmpd_beat))
FROM incident_reports;
## There are 60 Different LMPD Beats.

#14
SELECT COUNT(*)  
FROM nibrs_codes;
## There are 61 NIBRS Codes in the nibrs_codes table.

#15
SELECT COUNT(DISTINCT(nibrs_code))
FROM incident_reports;
## There are 54 mentioned NIBRS Codes in the incident_reports table.

#16
SELECT date_occured, block_address, zip_code,nibrs_code, offense_description
FROM incident_reports, nibrs_codes
WHERE (nibrs_code = 240 OR nibrs_code = 250 OR nibrs_code = 270 OR nibrs_code = 280) AND incident_reports.nibrs_code = nibrs_codes.offense_code
ORDER BY block_address;
## This is a multi-table query joining the nibrs_code column and the offense_code column from the different tables.

#17
SELECT zip_code, offense_against
FROM incident_reports, nibrs_codes
WHERE (nibrs_code != 999 AND LENGTH(zip_code) >= 5) AND incident_reports.nibrs_code = nibrs_codes.offense_code
ORDER BY zip_code;
## The query shows the ZIP Codes and Offense Against Entity, removing and invalid zip codes or unknown nibrs codes.

#18
SELECT offense_against, COUNT(*) 
FROM incident_reports, nibrs_codes
WHERE (offense_against != '') AND incident_reports.nibrs_code = nibrs_codes.offense_code
GROUP BY nibrs_codes.offense_against
ORDER BY nibrs_codes.offense_against;
## The query shows the count of the different Offense Against Entities.

#19
SELECT premise_type, COUNT(*) AS Count
FROM incident_reports
GROUP BY premise_type
HAVING COUNT(*) > 1000;
## The query shows the count of the different premise types, having a greater total than 1000. 

#20
SELECT date_occured, zip_code, nibrs_code, offense_group
FROM incident_reports, nibrs_codes
WHERE (zip_code = 40205) AND incident_reports.nibrs_code = nibrs_codes.offense_code
ORDER BY nibrs_codes.offense_group;
## The query shows the incidents that occured in 40205 Zip code, that is sorted by the Offense Group.