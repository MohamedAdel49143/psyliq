select *
from [dbo].[Diabetes_prediction_csv]
where Patient_id = 'PT100100';

--1) Retrieve the patient_id and ages of all patients.
select patient_id,age
from diabetes_prediction_csv;

--2) Select all female patients who are older than 40.
select patient_id,gender,age
from diabetes_prediction_csv
where gender = 'Female' and age > 40;

--3) Calculate the average BMI of patients.
select round(avg(bmi),2) as 'Average_BMI'
from diabetes_prediction_csv;

--4) List patients in descending order of blood glucose levels.
select Patient_id, blood_glucose_level
from diabetes_prediction_csv
order by blood_glucose_level desc;

--OR

WITH PatientGlucoseLevels AS (
    SELECT patient_id, blood_glucose_level
    FROM diabetes_prediction_csv
    
)
SELECT *
FROM PatientGlucoseLevels
ORDER BY blood_glucose_level desc;

--5) Find patients who have hypertension and diabetes.
select patient_id,hypertension,diabetes
from diabetes_prediction_csv
where hypertension = 1 and diabetes = 1;

--6) Determine the number of patients with heart disease.
select count(heart_disease) as 'Number of heart patients'
from diabetes_prediction_csv
where heart_disease = 1;

--7) Group patients by smoking history and count how many smokers and non- smokers there are.
select smoking_history,COUNT(smoking_history) as Total_Number
from [dbo].[Diabetes_prediction_csv]
group by smoking_history;

--8) Retrieve the Patient_ids of patients who have a BMI greater than the average BMI.
select Patient_id,round(bmi,2)
from [dbo].[Diabetes_prediction_csv]
where bmi > 27.32;

--9) Find the patient with the highest HbA1c level and the patient with the lowest HbA1clevel.
WITH RankedPatients AS (
    SELECT [Patient_id],[HbA1c_level],
           ROW_NUMBER() OVER (ORDER BY [HbA1c_level] DESC) AS rn_highest,
           ROW_NUMBER() OVER (ORDER BY [HbA1c_level] ASC) AS rn_lowest
    FROM [dbo].[Diabetes_prediction_csv]
)
SELECT [Patient_id],[HbA1c_level]
FROM RankedPatients
WHERE rn_highest = 1 OR rn_lowest = 1;

--10) Calculate the age of patients in years (assuming the current date as of now)
--11) Rank patients by blood glucose level within each gender group.
  SELECT
    patient_id,
    gender,
    blood_glucose_level,
    RANK() OVER (PARTITION BY gender ORDER BY blood_glucose_level) AS glucose_rank
  FROM
  [dbo].[Diabetes_prediction_csv]


--12) Update the smoking history of patients who are older than 50 to "Ex-smoker."
update [dbo].[Diabetes_prediction_csv]
set smoking_history = 'EX-smoker'
where age > 50;

select [Patient_id],[smoking_history]
from [dbo].[Diabetes_prediction_csv]
where age > 50;


--13) Insert a new patient into the database with sample data.
insert into [dbo].[Diabetes_prediction_csv]([EmployeeName],[Patient_id],[gender],[age],[hypertension],
                                            [heart_disease],[smoking_history],[bmi],[HbA1c_level],[blood_glucose_level],[diabetes])
values('MOHAMED SAEED','PT100105','male',34,0,0,'NO INFO',25.234,5,130,0)


select*
from [dbo].[Diabetes_prediction_csv]
where Patient_id='PT100105';

--14) Delete all patients with heart disease from the database.
delete from [dbo].[Diabetes_prediction_csv]
where heart_disease = 1

--15) Find patients who have hypertension but not diabetes using the EXCEPT operator.
select Patient_id,hypertension,diabetes
from [dbo].[Diabetes_prediction_csv]
where hypertension = 1
except
select Patient_id,hypertension,diabetes
from [dbo].[Diabetes_prediction_csv]
where diabetes = 1

--16) Define a unique constraint on the "patient_id" column to ensure its values are unique.
ALTER TABLE [dbo].[Diabetes_prediction_csv]
ADD CONSTRAINT unique_patient_id UNIQUE (patient_id);

--17) Create a view that displays the Patient_ids, ages, and BMI of patients.
CREATE VIEW patient_info AS
SELECT patient_id, 
      age,
      bmi
FROM [dbo].[Diabetes_prediction_csv] ;

--We can query the view above as follows:
select * from patient_info

--18) Suggest improvements in the database schema to reduce data redundancy and improve data integrity.
     --To reduce data redundancy and improve data integrity in the database schema, here are some suggestions:
          --1)Normalize the Data: Split the data into separate tables to eliminate duplicate data and reduce the risk of inconsistencies.
		      -- For example, you can create separate tables for patient details, conditions, and measurements.

          --2)Use Foreign Keys: Establish relationships between tables using foreign keys to enforce referential integrity. 
	          -- For example, you can link patient conditions to the patient table using patient IDs.

--19) Explain how you can optimize the performance of SQL queries on this dataset
	--I was used window functions and common table expressions (CTEs) can help improve the performance of SQL queries on the dataset
	--   in certain cases. Window functions can be used to perform complex calculations and aggregations without the need for subqueries or temporary tables
	--   , which can lead to more efficient query execution. CTEs can help to simplify and organize complex queries, making them easier to understand and maintain. 