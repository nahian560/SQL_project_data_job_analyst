/*
Question: What are the top-paying data analyst jobs, and what skills are required?

- Identify the top 10 highest-paying Data Analyst jobs and the specific skills required for these roles.
- Filters for roles with specified salaries that are remote
- Why? It provides a detailed look at which high-paying jobs demand certain skills, helping job seekers understand which skills to develop that align with top salaries
*/

With top_paying_jobs AS (
    SELECT 
        jpf.job_id AS job_id,
        jpf.job_title AS job_title, 
        jpf.salary_year_avg AS salary_year_avg,
        jpf.job_posted_date AS job_posted_date,
        cd.name AS company_name
    FROM
        job_postings_fact AS jpf
    LEFT JOIN company_dim AS cd ON jpf.company_id = cd.company_id
    WHERE
        jpf.job_title_short = 'Data Analyst'
        AND jpf.job_location = 'Anywhere'
        AND jpf.salary_year_avg IS NOT NULL
    ORDER BY 
        jpf.salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.job_id,
    top_paying_jobs.job_title,
    top_paying_jobs.salary_year_avg,
    skills_dim.skills
FROM  
    top_paying_jobs
    INNER JOIN 
        skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
    INNER JOIN 
        skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC