/*Write a SQL query that creates a consolidated dataset from the normalized tables in the database. In other words, write a SQL query that "flattens" the database to a single table*/
SELECT records.id, age, workclasses.name as workclass, education_levels.name as education_level, education_num, marital_statuses.name as marital_status, occupations.name as occupation, relationships.name as relationship, races.name as race, sexes.name as sex, capital_gain, capital_loss, hours_week, countries.name as country, over_50k
FROM records
INNER JOIN workclasses on records.workclass_id = workclasses.id
INNER JOIN education_levels ON records.education_level_id = education_levels.id
INNER JOIN marital_statuses ON records.marital_status_id = marital_statuses.id
INNER JOIN occupations ON records.occupation_id = occupations.id
INNER JOIN relationships ON records.relationship_id = relationships.id
INNER JOIN races ON records.race_id = races.id
INNER JOIN sexes ON records.sex_id = sexes.id
INNER JOIN countries ON records.country_id = countries.id
;
