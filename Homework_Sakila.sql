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
phone int,
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
                

                
                
                
                
                
                
                
                
                
                
                
                
                
                