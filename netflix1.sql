#1.count the number of movies and tv shows
use movies;
select type, count(*)  total_content from netflix
group by type;

#2.find the most common rating for movies and tv shows
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

#3.list all the movies released in a specific year(2020)
SELECT 
    type, release_year
FROM
    netflix
WHERE
    type = 'movie' AND release_year = 2020;

#4. find the top 5 countries with the most content on netflix
select country, count(*) total_content 
from netflix
group by country 
order by total_content desc limit 5;


#5.identufy the longest movie
select type, duration from netflix where type= 'movie' and 
duration =(select max(duration) from netflix);

#6.find the content added in the last 5 years
SELECT *
FROM netflix
WHERE date_added >= DATE_SUB(CURDATE(), INTERVAL 5 YEAR);

#7.find all the movies / tv shows directed by 'k.s. ravikumar'
select * from netflix where director = 'k.s. ravikumar';

#8.list all the tv shows with more than 5 seasons
select type, duration from netflix where type= 'tv show' and duration >'5 season';

#9. count the number of content items in each genre
SELECT listed_in, COUNT(*) AS content_count
FROM netflix
GROUP BY listed_in
ORDER BY content_count DESC


#10.find each year and the average number of content released by india on netflix. 
#return top 5 year with highest avg content release
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
#11. list all the movies that are documentaries
select * from netflix  where
listed_in like '%documentaries%';

#12. find all the content without a director
select * from netflix 
where director is null;

#13. find how many movies actor 'salma khan' appeared in last 10 years
select * from netflix where
cast like '%salman khan%' and release_year > 
extract(year from current_date )-10;

#14. find the top 10 actors who have appeared in the highest number of
# movies produced in india
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

#15.categorize the content based on the presence of the keywords 'kill' and 'violence in the 
#description field. label content containing these keywords as 'bad' and all other content as 'good'
#count how many items fall into each category.
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


