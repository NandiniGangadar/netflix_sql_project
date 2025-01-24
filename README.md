# Netflix movies and tv shows data analysis using sql
![netfliximg](https://github.com/NandiniGangadar/netflix_sql_project/blob/main/netfliximg.png)

##overview
This project focuses on performing an in-depth analysis of Netflix's movie and TV show dataset using SQL. The primary aim is to uncover actionable insights and address key business questions derived from the data. This README outlines the project's purpose, the business challenges tackled, the approaches and solutions implemented, key insights uncovered, and the conclusions drawn from the analysis.

##Objectives
> Analyze Netflix's movie and TV show data to uncover trends and patterns.
> Address key business questions to support strategic decision-making.
> Extract insights on popular genres, audience preferences, and content performance.
> Provide actionable recommendations based on SQL-driven data analysis.

##Datasets
The data for this project is sourced from the Kaggle dataset:
Dataset Link: Movies Dataset

##Schema
'''sql
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
'''

