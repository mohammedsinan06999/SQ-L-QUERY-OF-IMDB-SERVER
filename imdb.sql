create database IMDB;
use imdb; 
select*from actors;
select*from directors;
select*from directors_genres;
select*from movies;
select*from movies_directors;
select*from movies_genres;
select*from roles;

# QUESTIONS

# 1. List all actors (first name, last name, gender) from the actors table:
select  first_name,last_name,gender from actors;

#2. Find the number of movies directed by each director: 
select directors.id,directors.first_name,count(movies_directors.movie_id) as number_of_movies from movies_directors 
right join directors on movies_directors.director_id=directors.id 
group by directors.id,directors.first_name 
order by number_of_movies desc;

#3. List all movies from the movies table released after the year 2000:
select name,year from movies where year>2000;

#4. Find the top 5 movies with the highest rank score:
select name,rankscore from movies  order by rankscore desc limit 5;

#5. Count the number of male and female actors:
select gender,count(gender) as number_of_gender from actors group by gender;

#6 findout the actors who played 'Demon' role in any movie:
 select roles.actor_id,actors.first_name,roles.role from roles 
 left join actors on roles.actor_id=actors.id  where roles.role='Demon'; 
 
 #7 find all genres of movie with movie id =1 belongs to
 select * from movies_genres where movie_id='1';
 
 #8 find all movies directed by 'Anthony Abrams':
 SELECT m.name AS movie_name
FROM movies_directors md
JOIN directors d ON md.director_id = d.id
JOIN movies m ON md.movie_id = m.id
WHERE d.first_name = 'Anthony' AND d.last_name = 'Abrams';


#9. Count the number of movies in each genre: 
select genre,count(movie_id) as numbers_of_movie from movies_genres group by genre,movie_id order by numbers_of_movie desc;

#10. Find the top 5 directors with the highest average rank score: 
select d.first_name, d.last_name, avg(m.rankscore) as avg_rankscore
from directors d
join movies_directors md on d.id = md.director_id
join movies m on md.movie_id = m.id
group by d.id, d.first_name, d.last_name
order by avg_rankscore desc
limit 5;

#11. List all the directors who have directed movies in more than one genre:
select d.first_name, d.last_name, count(dg.genre) num_genres
from directors d
join directors_genres dg on d.id = dg.director_id
group by d.id, d.first_name, d.last_name 
having count(dg.genre)>1;
 
-- 12. Find all actors who have worked in movies from the 'Action' genre: 
select distinct a.first_name, a.last_name
from actors a
join roles r on a.id = r.actor_id
join movies_genres mg on r.movie_id = mg.movie_id
where mg.genre = 'action';

-- 13. Find all actors who have acted in more than 5 movies: 
select a.first_name, a.last_name, count(r.movie_id) as num_movies
from actors a
join roles r on a.id = r.actor_id
group by a.id, a.first_name, a.last_name
having count(r.movie_id) > 5;

-- 14. List all movies along with their directors and genres: 
select m.name as movie_name, d.first_name as director_first_name, 
d.last_name as director_last_name, mg.genre
from movies m
left join movies_directors md on m.id = md.movie_id
right join directors d on md.director_id = d.id
inner join movies_genres mg on m.id = mg.movie_id
order by m.name;

#15. Find the genre in which the highest number of directors have worked:
select dg.director_id,d.first_name,dg.genre,count(distinct dg.director_id) as num_of_directors
from directors_genres dg
left join directors d on dg.director_id=d.id
group by dg.director_id,d.first_name,dg.genre
order by num_of_directors desc 
limit 1;