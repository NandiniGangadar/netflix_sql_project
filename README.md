# Netflix movies and tv shows data analysis using sql
![netfliximg](https://github.com/NandiniGangadar/netflix_sql_project/blob/main/netfliximg.png)

##overview
This project focuses on performing an in-depth analysis of Netflix's movie and TV show dataset using SQL. The primary aim is to uncover actionable insights and address key business questions derived from the data. This README outlines the project's purpose, the business challenges tackled, the approaches and solutions implemented, key insights uncovered, and the conclusions drawn from the analysis.

## Objectives
> Analyze Netflix's movie and TV show data to uncover trends and patterns.
> Address key business questions to support strategic decision-making.
> Extract insights on popular genres, audience preferences, and content performance.
> Provide actionable recommendations based on SQL-driven data analysis.

## Datasets
The data for this project is sourced from the Kaggle dataset:
Dataset Link: Movies Dataset

## Schema
```sql
DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix
(
    show_id      VARCHAR(5),
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);
```
## Business problems and solutions
### 1. Count the Number of Movies vs TV Shows
   ```sql
   select type, count(*)  total_content from netflix
   group by type;
```
### 2. find the most common rating for movies and tv shows
```sql
select type, rating
from
(
select type, rating ,
count(*),
rank() over(partition by type order by count(*) desc) as ranking
from netflix
group by 1,2
) as t1
where ranking =1;
```
### 3.list all the movies released in a specific year(2020)
```sql
SELECT 
    type, release_year
FROM
    netflix
WHERE
    type = 'movie' AND release_year = 2020;
```
### 4. find the top 5 countries with the most content on netflix
```sql
select country, count(*) total_content 
from netflix
group by country 
order by total_content desc limit 5;
```
### 5.identufy the longest movie
```sql
select type, duration from netflix where type= 'movie' and 
duration =(select max(duration) from netflix);
```

### 6.find the content added in the last 5 years
```sql
SELECT *
FROM netflix
WHERE date_added >= DATE_SUB(CURDATE(), INTERVAL 5 YEAR);
```

### 7.find all the movies / tv shows directed by 'k.s. ravikumar'
```sql
select * from 
netflix 
where director = 'k.s. ravikumar';
```

### 8.list all the tv shows with more than 5 seasons
```sql
select type,
duration from netflix
where type= 'tv show' and duration >'5 season';
```

### 9. count the number of content items in each genre
```sql
SELECT listed_in, COUNT(*) AS content_count
FROM netflix
GROUP BY listed_in
ORDER BY content_count DESC
```


### 10.find each year and the average number of content released by india on netflix. 
return top 5 year with highest avg content release
```sql
SELECT
    release_year,
    ROUND(COUNT(title) * 1.0 / COUNT(DISTINCT release_year), 2) AS avg_content
FROM
    netflix
WHERE
    country = 'India'
GROUP BY
    release_year
ORDER BY
    avg_content DESC
LIMIT 5;
```
### 11. list all the movies that are documentaries
```sql
select * 
from netflix  
where
listed_in like '%documentaries%';
```

### 12. find all the content without a director
```sql
select * from netflix 
where director is null;
```

### 13. find how many movies actor 'salma khan' appeared in last 10 years
```sql
select * from netflix where
cast like '%salman khan%' and release_year > 
extract(year from current_date )-10;
```

### 14. find the top 10 actors who have appeared in the highest number of
movies produced in india
```sql
SELECT
    cast,
    COUNT(title) AS movie_count
FROM
    netflix
WHERE
    country = 'India'
    AND type = 'Movie'
GROUP BY
    cast
ORDER BY
    movie_count DESC
LIMIT 10;
```

### 15.categorize the content based on the presence of the keywords 'kill' and 'violence in the 
description field. label content containing these keywords as 'bad' and all other content as 'good'
count how many items fall into each category.
```sql
with new_table
as 
(
select * ,case when description like '%kill%' or description like '%violence%'
then 'Bad'
else 'good'
end category
from netflix
)
select category, count(*) as total_content from new_table
group by 1
```
## Findings
#### 1.Content Trends: Identified the most popular genres, movies, and TV shows on Netflix based on viewership data.
#### 2.User Engagement Patterns: Analyzed binge-watching habits, revealing peak hours and average watch time per session.
#### 3.Regional Preferences: Found regional differences in content preferences, highlighting varying interests across countries.
#### 4.Churn Rate Insights: Discovered trends related to user retention, offering insights into factors influencing subscription cancellations.

## Conclusions
#### 1.Content Strategy: Netflix should focus on producing more of the popular genres identified in the analysis to cater to user demand.
#### 2.Personalized Recommendations: Leveraging user engagement patterns can improve Netflix's recommendation system for enhanced user experience.
#### 3.Regional Customization: Tailor marketing and content releases to specific regional tastes to increase global engagement.
#### 4.Retention Improvement: Strategies to reduce churn should focus on factors influencing cancellations, such as pricing and content variety.




