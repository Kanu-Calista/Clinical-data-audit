-- Polypharmacy:  Geriatric patients (65+) on 5 or more medications
-- This identifies high-risk cases for potential drug-drug interactions

SELECT
   p.first || ' ' || p.last AS patient_identity,
   EXTRACT(YEAR FROM AGE(p.birthdate)) AS age,
   COUNT(m.id) AS med_count
FROM patients p
JOIN medications m ON p.id = m.patient
WHERE EXTRACT(YEAR FROM AGE(p.birthdate)) > 65
GROUP BY 1, 2
HAVING COUNT(m.id) >= 5
ORDER BY 3 DESC;


-- The master Patient Journey (Triple Join Report)
-- Final view: Who was seen , when, for what, and what was prescribed?
SELECT
   p.last AS patient_surname,
   e.start::DATE AS visit_date,
   e.reasondescription AS diagnosis,
   m.description AS therapy_ordered
FROM patients p
JOIN encounters e ON p.id = e.patient
JOIN medications m ON e.id = m.encounter
WHERE e.reasondescription IS NOT NULL
ORDER BY e.start DESC
LIMIT 15;
