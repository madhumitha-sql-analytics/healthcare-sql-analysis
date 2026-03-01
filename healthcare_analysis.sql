-- Create Patients Table
CREATE TABLE patients (
    patient_id INT,
    age INT,
    gender VARCHAR(10)
);

-- Create Visits Table
CREATE TABLE visits (
    visit_id INT,
    patient_id INT,
    visit_date DATE,
    diagnosis VARCHAR(50),
    cost DECIMAL(10,2)
);

-- Insert Sample Patients
INSERT INTO patients VALUES
(1, 25, 'Female'),
(2, 40, 'Male'),
(3, 35, 'Female'),
(4, 60, 'Male'),
(5, 50, 'Female');

-- Insert Sample Visits
INSERT INTO visits VALUES
(101, 1, '2024-01-01', 'Flu', 200),
(102, 1, '2024-02-10', 'Infection', 500),
(103, 1, '2024-03-15', 'Follow-up', 150),
(104, 2, '2024-01-20', 'Diabetes', 800),
(105, 2, '2024-03-05', 'Checkup', 300),
(106, 3, '2024-02-25', 'Injury', 700),
(107, 3, '2024-03-10', 'Follow-up', 200),
(108, 4, '2024-01-30', 'Hypertension', 900),
(109, 5, '2024-02-14', 'Flu', 250),
(110, 5, '2024-04-01', 'Follow-up', 300);

-- Patients with More Than 2 Visits
SELECT patient_id, COUNT(*) AS visit_count
FROM visits
GROUP BY patient_id
HAVING COUNT(*) > 2;

-- Average Cost Per Patient
SELECT patient_id, AVG(cost) AS avg_cost
FROM visits
GROUP BY patient_id;

-- Most Common Diagnosis
SELECT diagnosis, COUNT(*) AS diagnosis_count
FROM visits
GROUP BY diagnosis
ORDER BY diagnosis_count DESC;

-- Monthly Visit Trend
SELECT 
    DATE_FORMAT(visit_date, '%Y-%m') AS month,
    COUNT(*) AS total_visits
FROM visits
GROUP BY month
ORDER BY month;

-- Rank Patients by Total Treatment Cost
SELECT patient_id, total_cost,
       RANK() OVER (ORDER BY total_cost DESC) AS cost_rank
FROM (
    SELECT patient_id, SUM(cost) AS total_cost
    FROM visits
    GROUP BY patient_id
) t;
