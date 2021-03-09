use sakila;

-- SQL Self and cross join

-- 1. Get all pairs of actors that worked together.
select * from film_actor fa1
join film_actor fa2
on fa1.actor_id <> fa2.actor_id
and fa1.film_id = fa2.film_id
order by fa1.film_id, fa1.actor_id;

-- 2. Get all pairs of customers that have rented the same film more than 3 times.
select s1.inventory_id, s1.film_id, s1.rental_id, s1.customer_id, s2.customer_id  from (select i.inventory_id, i.film_id, r.rental_id, c.customer_id, concat(c.first_name, " ", c.last_name) 
from customer c
join rental r
on c.customer_id = r.customer_id
join inventory i 
on r.inventory_id = i.inventory_id
group by c.customer_id, i.film_id
) s1
join (select i.inventory_id, i.film_id, r.rental_id, c.customer_id, concat(c.first_name, " ", c.last_name) 
from customer c
join rental r
on c.customer_id = r.customer_id
join inventory i 
on r.inventory_id = i.inventory_id
group by c.customer_id, i.film_id
) s2
on s1.customer_id <> s2.customer_id
and s1.film_id = s2.film_id
group by s1.film_id
HAVING count(*) > 2;

select i.inventory_id, i.film_id, r.rental_id, c.customer_id, concat(c.first_name, " ", c.last_name) 
from customer c
join rental r
on c.customer_id = r.customer_id
join inventory i 
on r.inventory_id = i.inventory_id
group by c.customer_id, i.film_id
HAVING count(*) > 2;


select i.inventory_id, i.film_id, r.rental_id, c.customer_id, concat(c.first_name, " ", c.last_name) 
from customer c
join rental r
on c.customer_id = r.customer_id
join inventory i 
on r.inventory_id = i.inventory_id
where c.customer_id = 122;

select i.inventory_id, i.film_id, r.rental_id, c.customer_id, concat(c.first_name, " ", c.last_name) 
from customer c
join rental r
on c.customer_id = r.customer_id
join inventory i 
on r.inventory_id = i.inventory_id
where c.customer_id = 314;


-- 3. Get all possible pairs of actors and films.
select * from (
	select distinct actor_id from film_actor
) sub1
cross join (
	select distinct film_id from film
) sub2;
