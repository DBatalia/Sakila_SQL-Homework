select first_name,
last_name
from sakila.actor;

ALTER TABLE actor
ADD column Actor_Name varchar (55); 

#Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name.
SELECT upper(CONCAT(first_name, ' ', last_name)) As actor_name FROM actor;

#You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." 
#What is one query would you use to obtain this information?
select actor_id,
		first_name,
        last_name
        from actor
        where first_name= "Joe";

# Find all actors whose last name contain the letters GEN
Select first_name,
		last_name
        from actor
		 where last_name like "%GEN%";

#Find all actors whose last names contain the letters LI. 
#This time, order the rows by last name and first name, in that order
Select first_name,
		last_name
        from actor
		 where last_name like "%LI%"
         order by 2,1;

#Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China:

select 
country_id,
country 
from country
where country in ("Afghanistan", "Bangladesh", "China");

ALTER TABLE actor
ADD COLUMN description blob;



#Very quickly you realize that entering descriptions for each actor is too much effort. Delete the description column.
ALTER TABLE actor
drop column description;

#List the last names of actors, as well as how many actors have that last name.
select distinct last_name,
count(*)
from actor
group by 1;

#List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
select last_name,
count(*) 
from actor
group by 1
having count(*) >=2;

# The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS. Write a query to fix the record.
# Select records with GROUCHO William
select *
from actor
where first_name="GROUCHO" and last_name= "Williams";

Update actor
set first_name ="HARPO", last_name="WILLIAMS"
where actor_id=172;

#Perhaps we were too hasty in changing GROUCHO to HARPO.
 #It turns out that GROUCHO was the correct name after all!
 #In a single query, if the first name of the actor is currently HARPO, change it to GROUCHO.
 
Update actor
set first_name ="GROUCHO", last_name="WILLIAMS"
where actor_id=172;

#You cannot locate the schema of the address table. Which query would you use to re-create it?
select * from sakila.address
limit 100;

# OR
#Describe address;

select * from information_schema.tables
where table_type ="base table" and table_name="address";

# Recreate the address column
use sakila
create table address
(address_id as int,
address varchar (55),
address2 varchar(55),
district varchar(55),
city_id Int,
postal_code int,
phone int (10) not null,
location blob,
last_update int datetime);

#Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address
 select 
 a.first_name,
 a.last_name,
 b.address
 from staff a
inner join address b on a.address_id = b.address_id;

#Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment.
select 
b.staff_id,
a.first_name,
last_name,
sum(amount) as total_amount
from staff a
left join payment b on a.staff_id = b.staff_id
where payment_date= "2005-08-31";

#List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.

select 
b.title,
count(a.actor_id)
from film_actor a
inner join film b on a.film_id = b.film_id
group by 1;

#How many copies of the film Hunchback Impossible exist in the inventory system?
select 
	a.title,
	count(b.inventory_id)
from film a, inventory b
where a.film_id = b.film_id
and title like "Hunchback%"
group by 1;

#Using the tables payment and customer and the JOIN command, list the total paid by each customer. 
#List the customers alphabetically by last name:
select a.first_name, 
	a.last_name, 
	sum(b.amount) as total_paid
from customer a
join payment b on a.customer_id = b.customer_id
group by 1,2
order by last_name asc;


select title
FROM film 
	WHERE title like "K%" 
	OR title like "Q%"
	AND title in (select title 
				FROM film 
				WHERE language_id=1);
                

#SELECT title, (SELECT COUNT(*) FROM inventory WHERE film.film_id = inventory.film_id ) AS 'Number of Copies'
#FROM film;

#. Use subqueries to display all actors who appear in the film Alone Trip
select first_name, last_name
from actor
	where actor_id IN (
		select film_id
		from film_actor
where actor_id IN (
select
film_id
from film
where title="Alone Trip"));

# You want to run an email marketing campaign in Canada, 
#for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.
select 
a.first_name,
a.last_name,
a.email,
d.country

from customer a 
Left join address b on a.address_id=b.address_id
Left join city c on b.city_id=c.city_id
Left join country d on c.country_id=d.country_id
where country="Canada"


#Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
#Identify all movies categorized as family films.       

select title, description
from film 
where film_id IN(
select film_id from film_category
where category_id IN(       
select 
category_id from category
where name= 'family'));

#Display the most frequently rented movies in descending order

select 
a.title, 
count(c.rental_id) as rental_cnt
from film a 
inner join inventory b on a.film_id=b.film_id
inner join rental c  on b.inventory_id=c.inventory_id
group by 1
order by count(c.rental_id) desc;

#Write a query to display how much business, in dollars, each store brought in.       
 select a.store_id,
sum(b.amount) as totl_amt
 from store a
 inner join staff b on a.staff_id=b.staff_id
 inner join payment b on a.store_id=
 inner join inventory on store_id
 where 
       
       
# Write a query to display for each store its store ID, city, and country
select    
a.store_id,
d.city,
e.country
from store a
inner customer b on a.store_id = b.store_id
inner staff c on b.address_id = c.address_id
inner join city d on a.city_id = d.city_id 
inner join country e on d.country_id=e.country_id

#List the top five genres in gross revenue in descending order
select 
a.name,
sum(e.amount) as total_revenue
from category a
inner join film_category b on a.category_id=b.category_id
inner join inventory c on b.film_id = c.film_id
inner join rental d on c.inventory_id= d.inventory_id
inner join payment e on d.customer_id=e.customer_id
#where customer_id <5
Group by 1
order by 1 
limit 5




# 8. Create a view
use sakila; 

create view  topfivegenre as 
select 
a.name,
sum(e.amount) as total_revenue
from category a
inner join film_category b on a.category_id=b.category_id
inner join inventory c on b.film_id = c.film_id
inner join rental d on c.inventory_id= d.inventory_id
inner join payment e on d.customer_id=e.customer_id
#where customer_id <5
Group by 1
order by 1 
limit 5;

# Display the view
select * from topfivegenre
 
 # delect the view
drop view topfivegenre
                
                
                
                
                
                
                
                
                