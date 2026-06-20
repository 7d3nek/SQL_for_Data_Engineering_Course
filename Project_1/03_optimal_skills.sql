/*
Question: What are the most optimal skills for data engineers 
balancing both demand and salary?

. Create a ranking column that combines demand count and median salary 
to identify the most valuable skills.
. Focus only on remote Data Engineer positions with specified annual salaries.
· Why?
o This approach highlights skills that balance market demand and financial reward.
It weights core skills appropriately, rather than letting rare, 
outlier skills distort the results.
*/

SELECT
  skills,
  total_count,
  median_salary,
  (count_rank + salary_rank) / 2.0 AS ranking
FROM
  (SELECT
    sd.skills,
    COUNT(sd.skills) as total_count,
    RANK() OVER (ORDER BY COUNT(sd.skills) DESC) AS count_rank,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    RANK() OVER (ORDER BY MEDIAN(jpf.salary_year_avg) DESC) AS salary_rank
  FROM job_postings_fact jpf
  INNER JOIN skills_job_dim sjd
  ON jpf.job_id = sjd.job_id
  INNER JOIN skills_dim sd
  ON sjd.skill_id = sd.skill_id
  WHERE jpf.job_title_short = 'Data Engineer'
  AND jpf.job_work_from_home = TRUE
  AND jpf.salary_year_avg IS NOT NULL
  GROUP BY sd.skills
  HAVING COUNT(sd.skills) > 200
) AS ranking_table
ORDER BY (count_rank + salary_rank) / 2, median_salary DESC, total_count DESC
LIMIT 10

/*
Here is the final result and its breakdown (now requiring the count > 200 to remove niche skills):
    skills	   total_count	median_salary	 ranking
    spark	     503	        140000.0	     3.5
    airflow	   386	        150000.0	     4.0
    aws	       783	        137320.0	     4.0
    python	   1133	        135000.0	     4.5
    kafka	     292	        145000.0	     5.5
    snowflake	 438	        135500.0	     6.5
    sql	       1128	        130000.0	     6.5
    git	       208	        140000.0	     8.0
    java	     303	        135000.0	     8.0
    scala	     247	        137290.0	     9.0

Spark tops the list because it ranks near the top on both dimensions - strong demand and a hight median salary.
This is the ideal profile the question was looking for: not the single highest payer, nor the single most common skill,
but the best combination of the two.

Airflow and AWS tied at 4.0. 
Airflow leans on salary - with the highest in this top 10 and solid demand)
AWS leans on demand - the 3rd highest count in this list with a respectable salary.
They show two valid strategies: be highly paid in moderately-demanded niche, or be moderately
paid in a hugely demanded one.

Python's massive demand (the highest of any skill in this dataset) compensates for an average salary.
It's optimal not because it pays the best, but because almost every employer wants it.

Kafka skews toward salary, similar to Airflow but with less demand.
Snowflake and SQL skew toward demand.
SQL in particular has huge demand (the second highest in this dataset), but the lowest salary in the top 10.

For a data engineer choosing where to invest learning time, Spark, Airflow, and AWS look like the highest-leverage picks.
They show up consistently and pay well.

*/