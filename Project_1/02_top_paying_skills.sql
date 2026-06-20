/*
Question: What are the highest-paying skills for data engineers?
. Calculate the median salary for each skill required in data engineer
positions

. Focus on remote positions with specified salaries
. Include skill frequency to identify both salary and demand

· Why?

o Helps identify which skills command the highest compensation
while also showing how common those skills are, providing a more
complete picture for skill development priorities.

o The median is used instead of the average to reduce the impact of
outlier salaries.
*/

SELECT
  sd.skills,
  COUNT(sd.skills) as total_count,
  ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary
FROM job_postings_fact jpf
INNER JOIN skills_job_dim sjd
ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd
ON sjd.skill_id = sd.skill_id
WHERE jpf.job_title_short = 'Data Engineer'
AND jpf.job_work_from_home = TRUE
AND jpf.salary_year_avg IS NOT NULL
GROUP BY sd.skills
HAVING COUNT(sd.skills) > 100
ORDER BY MEDIAN(jpf.salary_year_avg) DESC, COUNT(sd.skills) DESC 
LIMIT 20

/*
Here is a breakdown of the top-paying skills for data engineers:
    skills	     total_count	median_salary
    terraform	   193	        184000.0
    kubernetes	 147	        150500.0
    airflow	     386	        150000.0
    kafka	       292	        145000.0
    spark	       503	        140000.0
    git	         208	        140000.0
    pyspark	     152	        140000.0
    go	         113	        140000.0
    aws	         783	        137320.0
    scala	       247	        137290.0
    gcp	         196	        136000.0
    mongodb	     136	        135750.0
    snowflake	   438	        135500.0
    python	     1133	        135000.0
    java	       303	        135000.0
    hadoop	     198	        135000.0
    docker	     144	        135000.0
    github	     127	        135000.0
    bigquery	   123	        135000.0
    r	           133	        134775.0

Terraform ($184k, 193 postings) tops the list by a wide margin. Likely because Terraform overlaps
with DevOps - not just a pure data work.

Kubernetes ($150.5k, 147 postings) and Airflow ($150k, 386 postings) follow closely.
Airflow's combination of high pay and high frequency makes it standout.
It is both valuable and in real demand.

Kafka ($145k), Spark/PySpark ($140k), Git ($140k), and Go ($140k) cluster toghether.
Spark's volume (total 655 with PySpark) show it's a foundational expectation, while paying
well above baseline.

AWS ($137.3k, 783 postings) has the second highest frequency in this whole list.
It's the most in-demand cloud platform and pays well.

Python ($135k, 1,133 postings) has by far the highest demand of any skill here, but
its salary is not top. Python is the most universally required skill and everyone has it, so it does
not differentiate pay as much.

*/