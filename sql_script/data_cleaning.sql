/* DATA CLEANING
Standardizing variables and removing biological impossibilities to ensure scientific accuracy. */

-- 1. Remove impossible lifespans (Death before birth)
DELETE FROM patients
WHERE deathdate IS NOT NULL AND deathdate < birthdate;

-- 2. Standardize Gender labels for uniform visualization
UPDATE patients SET gender = 'F' WHERE gender IN ('Female','female','f');
UPDATE patients SET gender = 'M' WHERE gender IN ('Male','Male','m');

--3. Remove records with zero/null costs
DELETE FROM medications WHERE totalcost <= 0 OR totalcost IS NULL;

-- 4. Deduplicate encounter records
DELETE FROM encounters a
USING encounters b
WHERE a.ctid < b.ctid AND a.id = b.id;

-- CLINICAL INSIGHTS
-- Demographic volume: Understanding patient diversity
SELECT race, gender, COUNT(*) AS patient_volume
FROM patients
GROUP BY 1, 2
ORDER BY 3 DESC;
