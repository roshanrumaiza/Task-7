create database IMDB;
use `IMDB`;
show tables;
create table movies(
movie_id INT auto_increment primary key,
movie_name varchar(50),
release_year int);

create table media(
media_id int auto_increment primary key,
media_type varchar(50));

create table genre(
genre_id int auto_increment primary key,
genre_type varchar(50));

create table movie_media(
media_id int,
movie_id int,
foreign key(media_id) references media(media_id),
foreign key(movie_id) references movies(movie_id));

create table movie_genre(
movie_id int,
genre_id int,
foreign key(movie_id) references movies(movie_id),
foreign key(genre_id) references genre(genre_id));

create table users(
user_id int auto_increment primary key,
user_name varchar(50));

create table artists(
artist_id int auto_increment primary key,
artist_name varchar(50));

create table skills(
skill_id int auto_increment primary key,
skill_name varchar(50));

create table artist_skill(
artist_id int,
skill_id int,
foreign key(artist_id) references artists(artist_id),
foreign key(skill_id) references skills(skill_id));

create table roles(
role_id int auto_increment primary key,
role_name varchar(50));

create table movie_artist_role(
movie_id int,
artist_id int,
role_id int,
foreign key(movie_id) references movies(movie_id),
foreign key(artist_id) references artists(artist_id),
foreign key(role_id) references roles(role_id));

create table review(
review_id int auto_increment primary key,
movie_id int,
user_id int,
review_rating decimal(3,2),
foreign key(movie_id) references movies(movie_id),
foreign key(user_id) references users(user_id));

insert into movies(movie_name,release_year) values 
('Titanic',1997),
('Krishh',2000),
('KKKG',1999),
('Teri',2010),
('DDLJ',1995);

insert into media(media_type) values('image'),('vedio');

insert into users(user_name) values('Sam'),('Adi'),('Riya'),('Aisu');

insert into artists(artist_name) values('Sharukh'),('Simran'),('Raj'),('John'),('Priya');

insert into skills(skill_name) values('Acting'), ('Dancing'),('Singing'),('Stunt');

insert into roles(role_name) values('Actor'),('Writer'),('Director'),('Producer');

insert into movie_media(movie_id,media_id) values(1,1),(1,2),(2,1),(3,2),(4,1);

select * from movie_media;

insert into artist_skill(artist_id,skill_id) values(1,1),(1,4),(2,1),(2,2),(3,3),(4,4);

insert into movie_artist_role(movie_id,artist_id,role_id) values(2,1,1),(1,4,1),(3,1,4),(5,2,1);

insert into review (movie_id,user_id,review_rating) values(1,1,8.5),(2,2,8),(1,2,8.75),(5,3,9.5),(3,4,8.5);

INSERT INTO genre(genre_type) values('Action'),('Drama'),('Thriller'),('Suspense');
	
insert into movie_genre(movie_id,genre_id) values(1,1),(1,3),(2,4),(3,2),(5,3);

select * from movies;

select m.movie_name from movies m inner join movie_artist_role mar on m.movie_id=mar.movie_id;

select a.artist_name from artists a inner join artist_skill ask on a.artist_id=ask.artist_id;

select m.movie_name from movies m join review r on m.movie_id=r.movie_id where r.review_rating>8.5;

select u.user_name,count(r.review_id) as review_count  from users u left join review r on u.user_id=r.user_id GROUP BY u.user_id Having count(r.review_id)>1;

select a.artist_name, COUNT(mar.movie_id) as movie_count from artists a join movie_artist_role mar on a.artist_id=mar.artist_id GROUP BY a.artist_id HAVING count(mar.movie_id)>1;

select m.movie_name from movies m left join review r on m.movie_id=r.movie_id where r.review_id is NULL;