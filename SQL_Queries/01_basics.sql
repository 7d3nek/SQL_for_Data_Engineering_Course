/*
Retrieve the following columns from the job_postings_fact table:

job_id

job_title_short

job_location

job_via

Then, sort the results in descending order by job_location.
*/

SELECT
  job_id,
  job_title_short,
  job_location,
  job_via
FROM job_postings_fact
ORDER BY job_location DESC



/*
Retrieve the following columns from the job_postings_fact table:

job_id
job_title_short
job_location
job_via
Then, sort the results in descending order by job_title_short.
*/

SELECT
  job_id,
  job_title_short,
  job_location,
  job_via
FROM job_postings_fact
ORDER BY job_title_short DESC



/*
Retrieve the following columns from the job_postings_fact table:

job_id
job_title_short
job_location
job_via
Then, retrieve the last 15 postings based on job_id.
*/

SELECT
  job_id,
  job_title_short,
  job_location,
  job_via
FROM job_postings_fact
ORDER BY job_id DESC
LIMIT 15


/*
Retrieve the list of unique countries from the job_postings_fact table and present them in alphabetical order.

Output Column: job_country
*/

SELECT
  DISTINCT job_country
FROM job_postings_fact
ORDER BY job_country



/*
Problem Statement
From the job_postings_fact table, retrieve the following columns for postings that have a job_title_short of Data Engineer:

job_id
job_title_short
job_location
job_via
salary_year_avg
Then, sort the results by job_id in ascending order.
*/

SELECT
  job_id,
  job_title_short,
  job_location,
  job_via,
  salary_year_avg
FROM job_postings_fact
WHERE job_title_short = 'Data Engineer'
ORDER BY job_id



/*
Problem Statement
From the job_postings_fact table, retrieve the following columns for postings where the job location is missing (job_location IS NULL):

job_id
job_title_short
job_location
job_via
salary_year_avg
Then:

Show only the top 10 highest salaries.
Include an inline SQL comment next to the filter in the WHERE clause explaining that this selects rows with missing locations.
*/

SELECT
  job_id,
  job_title_short,
  job_location,
  job_via,
  salary_year_avg
FROM job_postings_fact
WHERE job_location IS NULL -- Filters rows with missing locations
ORDER BY salary_year_avg DESC
LIMIT 10





