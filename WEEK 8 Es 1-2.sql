------------------------------------------------------------------- WEEK_8 ES_1 ------------------------------------------------------------
--- Scoprite quanti clienti si sono registrati nel 2006 ---

SELECT 
    COUNT(customer_id) AS NumberOfClients,
    YEAR(create_date) AS RegistrationYear
FROM
    customer
WHERE
    YEAR(create_date) = 2006
GROUP BY YEAR(create_date);

--- Trovate il numero totale di noleggi effettuati il giorno 14/02/2006 -------

SELECT 
    count(rental_id) as NumberOfCustomer,
    rental_date
FROM
    rental
where
    rental_date like '2006-02-14%'
 group by rental_date
;



--- Elencate tutti i film noleggiati nell’ultima settimana e tutte le informazioni legate al cliente che li ha noleggiati. --- 

CREATE VIEW Film_Inv_Rent as
(SELECT 
    f.title, c.*, r.rental_date
FROM
    film AS f
        LEFT JOIN
    inventory AS i ON f.film_id = i.film_id
        LEFT JOIN
    rental AS r ON i.inventory_id = r.inventory_id
        LEFT JOIN
    customer AS c ON r.customer_id = c.customer_id);



SELECT 
    f.title, c.*, r.rental_date
FROM
    film AS f
        LEFT JOIN
    inventory AS i ON f.film_id = i.film_id
        LEFT JOIN
    rental AS r ON i.inventory_id = r.inventory_id
        LEFT JOIN
    customer AS c ON r.customer_id = c.customer_id
WHERE
    DATE(r.rental_date) BETWEEN DATE('2006-02-08') AND DATE('2006-02-14');


--- Calcolate la durata media del noleggio per ogni categoria di film. ----

SELECT 
    c.name AS FIlmCategory, AVG(f.rental_duration) AS RentalAvg
FROM
    film_category AS fc
        INNER JOIN
    film AS f ON fc.film_id = f.film_id
        INNER JOIN
    category AS c ON fc.category_id = c.category_id
GROUP BY c.name;


---- Trovate la durata del noleggio più lungo ----
SELECT 
    MAX(rental_duration) AS LongRent
FROM
    film;

------------------------------------------------------------------- WEEK_8 ES_2 ------------------------------------------------------------

--- Identificate tutti i clienti che non hanno effettuato nessun noleggio a febbraio 2006 ----

  SELECT 
    r.customer_id
FROM
    rental AS r
    WHERE r.rental_date like '2006-02-%';


SELECT DISTINCT
customer_id, first_name, last_name
FROM
    customer 
    WHERE customer_id NOT IN 
(SELECT 
    r.customer_id
FROM
    rental AS r
    WHERE r.rental_date like '2006-02-%');
    
  ---- Elencate tutti i film che sono stati noleggiati più di 1 volta nel primo quarto del 2006. ----
  
SELECT 
    f.title, COUNT(f.film_id) AS RentNumber, DATE(r.rental_date) as RentalDate
FROM
    film AS f
        LEFT JOIN
    inventory AS i ON f.film_id = i.film_id
        LEFT JOIN
    rental AS r ON i.inventory_id = r.inventory_id
        LEFT JOIN
    customer AS c ON r.customer_id = c.customer_id
WHERE
    DATE(r.rental_date) BETWEEN DATE('2006-01-01') AND DATE('2006-03-31')
GROUP BY f.title , DATE(r.rental_date)
HAVING RentNumber > 1;

---- Trovate il numero totale di noleggi effettuati il giorno 1/1/2006.   ----

SELECT
count(rental_id) as NumberofRental
FROM 
rental
where date(rental_date) = '2006-01-01'
group by date(rental_date);


---- Calcolate la somma degli incassi generati nei weekend (sabato e domenica). ----

SELECT 
	SUM(amount) TotWeekends
FROM
    payment
WHERE
    DAYNAME(payment_date) = 'Sunday'
        OR DAYNAME(payment_date) = 'Saturday';


--- OPPURE ---

SELECT 
SUM(amount) AS TotWeekends
FROM
    payment
WHERE
    DAYNAME(payment_date) IN ('Sunday','Saturday');


---	Individuate il cliente che ha speso di più in noleggi ---
SELECT 
    p.customer_id, c.first_name,
    c.last_name,
    SUM(p.amount) AS RetalPayment
FROM
    payment as p
    INNER JOIN
    customer as c
    ON p.customer_id=c.customer_id
GROUP BY p.customer_id
ORDER BY SUM(p.amount) DESC
LIMIT 1;


--- Elencate i 5 film con la maggior durata media di noleggio. ---

SELECT 
    film_id, title, AVG(rental_duration) AS AvgRental
FROM
    film
GROUP BY film_id
ORDER BY rental_duration DESC
LIMIT 5;

--- Calcolate il tempo medio tra due noleggi consecutivi da parte di un cliente. ---

SELECT 
    *
FROM
    rental
WHERE
    customer_id = 10;

SELECT 
    customer_id,
    TIMEDIFF('2005-06-16 20:21:53',
            '2005-05-31 19:36:30') AS TimeDiffRent
FROM
    rental
GROUP BY customer_id
HAVING customer_id = 10;

--- Individuate il numero di noleggi per ogni mese del 2005 ---

SELECT 
    MONTHNAME(rental_date) AS MonthRent,
    COUNT(rental_id) AS NumberofRental
FROM
    rental
WHERE
    YEAR(rental_date) = '2005'
GROUP BY MONTHNAME(rental_date);

---- Trovate i film che sono stati noleggiati almeno due volte lo stesso giorno. ---

SELECT 
    title,
    DATE(rental_date) as data_noleggio,
    COUNT(*) as numero_noleggi
FROM
   film_inv_rent
GROUP BY title , data_noleggio
HAVING numero_noleggi > 1;  


--- Calcolate il tempo medio di noleggio ---
SELECT
AVG(rental_duration) AS AvgRental
FROM
film;

--- oppure ---

SELECT 
    CAST(AVG(rental_duration) AS DECIMAL (10 , 2 )) AS AvgRental
FROM
    film;

