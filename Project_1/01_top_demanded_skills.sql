/*
Question: What are the most in-demand skills for data engineers at FAANG?

. Identify the top 10 in-demand skills for data engineers

. Focus on remote job postings

· Why?
o Retrieves the top 10 skills with the highest demand in the remote
job market, providing insights into the most valuable skills for data
engineers seeking remote work at FAANG companies
*/

SELECT
  sd.skills,
  COUNT(*) AS total_count
FROM job_postings_fact jpf
INNER JOIN company_dim cd
ON jpf.company_id = cd.company_id
INNER JOIN skills_job_dim sjd
ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd
ON sjd.skill_id = sd.skill_id
WHERE jpf.job_title_short = 'Data Engineer'
AND jpf.job_work_from_home = TRUE
AND cd.name IN ('Facebook', 'Meta', 'Apple', 'Amazon', 'Netflix', 'Google')
GROUP BY sd.skills
ORDER BY COUNT(*) DESC
LIMIT 10

/*

Here is the breakdown of the most demanded skills for remote data engineers jobs at FAANG:
    skills	total_count
    python	52
    sql	    52
    java	  38
    scala	  33
    spark	  32
    aws	    20
    hadoop	14
    c++	    11
    nosql	  7
    c#	    7

Python and SQL are non-negotiable. This confirms the classic data engineering core:
 - SQL for querying and manipulating data
 - Python for scripting, ETL and automation
If you had to choose only two skills, it would be these.

Java and Scala sit right behind Python/SQL. This reflects the data engineering ecosystem's
roots in JVM-based (Java Virtual Machine) big data tools (Hadoop, Kafka)

Spark is the dominant big-data processing framework.

AWS shows cloud platform skills are valued, but less than the core programming skills.
This suggests that roles at FAANG assume strong engineering fundamentals first and cloud tooling second.

Hadoop's continued presence shows legacy big-data infrastructure is still in use.

*/