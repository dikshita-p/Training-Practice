1: Using the table employees, show all the employees, their departments, salaries, and the average salary in their respective department. Order the result by department.

WITH avg_salary AS (
        SELECT  AVG(salary) AS average_salary,department
        FROM employees
        GROUP BY department)       
SELECT  e.first_name,e.last_name,e.department,e.salary,avgs.average_salary
FROM employees e
JOIN avg_salary avgs
ON e.department = avgs.department
ORDER BY department;

2: Find the employee with the highest salary in each department. Show their first and last names, salaries, and departments.

WITH highest_salary AS (
        SELECT  first_name,last_name,department,salary,
                RANK () OVER (PARTITION BY department ORDER BY salary DESC) AS salary_rank
        FROM employees)
SELECT  first_name,last_name,salary,department
FROM highest_salary
WHERE salary_rank = 1;

3: Find all employees working directly or indirectly under the employee whose ID is 18.

WITH RECURSIVE subordinates AS (
        SELECT  id,first_name,last_name,manager_id
        FROM employees
        WHERE id = 18
    UNION
        SELECT  e.id,e.first_name, e.last_name,e.manager_id
        FROM employees e
JOIN subordinates s
ON e.manager_id = s.id
)
SELECT *
FROM subordinates
WHERE id <> 18;


4. For each single rental, show the rental_date, the title of the movie rented, its genre, the payment amount, and the rank of the rental in terms of the price paid (the most expensive rental should have rank = 1). The ranking should be created separately for each movie genre. Allow the same rank for multiple rows and allow gaps in numbering.
SELECT
  rental_date,title,genre,payment_amount, RANK() OVER(PARTITION BY genre ORDER BY payment_amount DESC)
FROM movie
JOIN single_rental
ON single_rental.movie_id = movie.id;

5. Show the first and last name of the customer who bought the second most-recent gift card, along with the date when the payment took place. Assume that a unique rank is assigned for each gift card purchase.
WITH ranking AS (
  SELECT
    first_name,last_name,payment_date,
    ROW_NUMBER() OVER(ORDER BY payment_date DESC) AS rank
  FROM customer
  JOIN giftcard
    ON customer.id = giftcard.customer_id
)
SELECT
  first_name, last_name,payment_date
FROM ranking
WHERE rank = 2;