-- QUESTIONS FROM https://www.sql-practice.com/


1. Show first name, last name, and gender of patients whose gender is 'M'

SELECT
  first_name,
  last_name,
  gender
FROM patients
WHERE gender = 'M';

2. Show first name and last name of patients who does not have allergies. (null)

SELECT
  first_name,
  last_name
FROM patients
WHERE allergies IS NULL;

3. Show all the columns from admissions where the patient was admitted and discharged on the same day.

SELECT *
FROM admissions
WHERE admission_date = discharge_date;

4. Update the patients table for the allergies column. If the patient allergies is null then replace it with 'NKA'

UPDATE patients
SET allergies = 'NKA'
WHERE allergies IS NULL;

5. Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?

SELECT DISTINCT(city) AS unique_cities
FROM patients
WHERE province_id = 'NS';

6. Write a query to find the first_name, last name and birth date of patients who has height greater than 160 and weight greater than 70

SELECT first_name, last_name, birth_date FROM patients
WHERE height > 160 AND weight > 70;

7. Show all of the patients grouped into weight groups.Show the total amount of patients in each weight group.
Order the list by the weight group decending.

SELECT
  count(patient_id),
  weight - weight % 10 AS weight_group
FROM patients
GROUP BY weight_group
ORDER BY weight_group DESC;

8. Show all patient first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.

SELECT
  first_name,
  last_name,
  birth_date
FROM patients
WHERE
  YEAR(birth_date) BETWEEN 1970 AND 1979
ORDER BY birth_date ASC;

-- MEDIUM

9. Show unique first names from the patients table which only occurs once in the list.
SELECT first_name
FROM (
    SELECT
      first_name,
      count(first_name) AS occurrencies
    FROM patients
    GROUP BY first_name
  )
WHERE occurrencies = 1

10. Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.

SELECT
  patients.patient_id,
  first_name,
  last_name
FROM patients
  JOIN admissions ON admissions.patient_id = patients.patient_id
WHERE diagnosis = 'Dementia';

11. Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.
SELECT
  patient_id,
  diagnosis
FROM admissions
GROUP BY
  patient_id,
  diagnosis
HAVING COUNT(*) > 1;

12.Write a query to find list of patients first_name, last_name, and allergies from Hamilton where allergies are not null


select first_name,last_name, allergies from  patients 

where city = 'Hamilton' and allergies is not null;

13.Based on cities where our patient lives in, write a query to display the list of 
unique city starting with a vowel (a, e, i, o, u). Show the result order in ascending by city.

select distinct(city) from  patients 

where 
city like 'a%' 
or city  like 'e%'
or city like 'i%'
or city like 'o%'
or city like 'u%'
order by city;

14.Show the total amount of male patients and the total amount of female patients in the patients table.
Display the two results in the same row.

select 
  sum(case when gender = 'M' then 1 end) as male_count,
  sum(case when gender = 'F' then 1 end) as female_count 
from patients;


15.Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. Show results 
ordered ascending by allergies then by first_name then by last_name.

select first_name,last_name,allergies
from patients where allergies in ('Penicillin' , 'Morphine')
order by allergies, first_name,last_name;

16.Show first name, last name and role of every person that is either patient or doctor.
The roles are either "Patient" or "Doctor"

select 
first_name,last_name,'Patient' from patients 
union all
select 
first_name,last_name,'Doctor' from doctors;

17. We want to display each patients full name in a single column. Their last_name in all upper 
letters must appear first, then first_name in all lower case letters. Separate the last_name 
and first_name with a comma. Order the list by the first_name in decending order
EX: SMITH,jane

select 
concat(upper(last_name), ',', lower(first_name)) as new_name_format from patients
order by first_name desc;

18. Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'


select 
max(weight) - min(weight)
from patients where last_name = 'Maroni';

19.Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.

select 
day(admission_date) as  day_number,
count(admission_date) as number_of_admissions
from admissions
group by day(admission_date)
order by number_of_admissions desc;

20.Show all columns for patient_id 542 most recent admission_date.

-select * from  admissions a where a.patient_id = 542 order by admission_date desc limit 1

SELECT *
FROM admissions
GROUP BY patient_id
HAVING
  patient_id = 542
  AND max(admission_date);

21.Show first_name, last_name, and the total number of admissions attended for each doctor.Every admission has been attended by a doctor.

select 
first_name, last_name, count(*)
from doctors d join  admissions a on d.doctor_id = a.attending_doctor_id
group by first_name,last_name;

22. For each doctor, display their id, full name, and the first and last admission date they attended.

select 

d.doctor_id, concat(first_name, ' ',last_name) as full_name, min(admission_date) first_admission_date, max(admission_date) last_admission_date
from doctors d join admissions a on d.doctor_id = a.attending_doctor_id

group by d.doctor_id, first_name,last_name;

23. Display the total amount of patients for each province. Order by descending.

select 
p2.province_name, count(p.patient_id) as x
from patients p join province_names p2 on p.province_id = p2.province_id
group by p2.province_name
order by x desc;

24. display the number of duplicate patients based on their first_name and last_name.
select 
first_name, last_name, count(*) as num_of_duplicates
from patients 
group by first_name,last_name
having count(*) >1
order by num_of_duplicates desc;

-- hard

25.Show patient_id, first_name, last_name, and attending doctors specialty.
Show only the patients who has a diagnosis as 'Epilepsy' and the doctors first name is 'Lisa'
Check patients, admissions, and doctors tables for required information.

select 
p.patient_id, p.first_name, p.last_name, d.specialty
from patients p join admissions a on p.patient_id = a.patient_id join 
doctors d on d.doctor_id = a.attending_doctor_id
where diagnosis = 'Epilepsy' and d.first_name = 'Lisa';

26.All patients who have gone through admissions, can see their medical documents on our site. Those patients 
are given a temporary password after their first admission. Show the patient_id and temp_password.

The password must be the following, in order:
1. patient_id
2. the numerical length of patient's last_name
3. year of patient's birth_date

select 
distinct p.patient_id, concat(p.patient_id,len(p.last_name), year(p.birth_date) ) as temp_password
from patients p join admissions a on p.patient_id = a.patient_id ;

27. Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name

with h as(SELECT 
p2.province_name,
sum(case when gender = 'M' then 1 end) as male,
sum(case when gender = 'F' then 1 end) as female
from patients p join province_names p2 on p.province_id = p2.province_id
group by p2.province_name)
select province_name   from h
where male > female;

288.Show the percent of patients that have 'M' as their gender. Round the answer to 
the nearest hundreth number and in percent form.
select 
concat(round(100.0* sum(case when gender = 'M' then 1 end) / count(*) ,2), '%') as percent_of_male_patients
from patients;

29. Sort the province names in ascending order in such a way that the province 'Ontario' is always on top.
select 
province_name
from province_names
order by  province_name = 'Ontario' desc, province_name;

30.For each day display the total amount of admissions on that day. Display the amount changed from the previous date.
select 
admission_date,
count(*),
count(*) -lag(count(*),1)over(order by admission_date) 
from admissions
group by admission_date;

