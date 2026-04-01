 /* Answer: What are the most optimal skills to learn aka it's in high demand and a high-paying skill?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- concentrares on remote positions win spectree salartes
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
oTterino strateonc instonts Tor career develoonent in cata analysis
*/

WITH skills_demand AS (
SELECT 
skill_id,
skills,
count(skills_job_dim.job_id) as demand_count
from job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id 
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id  
WHERE job_title_short = 'Data Analyst' AND
job_work_from_home = TRUE AND
salary_year_avg IS NOT NULL AND
GROUP BY skill_id 
)
with average_salary as (
SELECT 
skill_id,
skills,
round(AVG(salary_year_avg),0) as avg_salary
from job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id 
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id  
WHERE job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home = TRUE
GROUP BY skill_id
)

SELECT 
skills_demand.skill_id,
skills_demand.skills,
demand_count,
avg_salary
from  
skills_demand
INNER JOIN average_salary on skills_demand.skill_id = average_salary.skill_id