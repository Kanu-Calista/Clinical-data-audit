-- Disease Mapping: Top 10 diagnoses driving hospital visits
SELECT reasondescription AS diagnosis, COUNT(*) AS frequency
FROM encounters
WHERE reasondescription IS NOT NULL
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

-- Clinical correlations: Linking drugs to specific diagnoses (Pharma link)
SELECT
    m.description AS medication_name,
    e.reasondescription AS diagnosis,
    COUNT(*) AS total_prescriptions
FROM medications m
JOIN encounters e ON m.encounter = e.id
WHERE e.reasondescription IS NOT NULL
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 12;

-- Medication cost variance: Tracking the most expensive drug classes
SELECT
    description AS drug_name,
    '$' || TO_CHAR(AVG(totalcost), 'FM999,999,999.00') AS avg_unit_cost
FROM medications
GROUP BY 1
ORDER BY AVG(totalcost) DESC
LIMIT 10;
