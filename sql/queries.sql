-- Query 1: Converters vs non-converters and conversion rate per cohort
SELECT 'Lithuanian' AS cohort,
       CASE WHEN CAST(MS AS INTEGER) = 1 THEN 'Converter' ELSE 'Non-converter' END AS outcome,
       COUNT(*) AS n,
       ROUND(COUNT(*) * 100.0 /
             (SELECT COUNT(*) FROM lithuanian WHERE MS IS NOT NULL), 1) AS conversion_rate_pct
FROM lithuanian
WHERE MS IS NOT NULL
GROUP BY CAST(MS AS INTEGER)
UNION ALL
SELECT 'Mexican' AS cohort,
       CASE WHEN SUBSTR(TRIM("group"), 1, 1) = '1' THEN 'Converter' ELSE 'Non-converter' END AS outcome,
       COUNT(*) AS n,
       ROUND(COUNT(*) * 100.0 /
             (SELECT COUNT(*) FROM mexican WHERE "group" IS NOT NULL), 1) AS conversion_rate_pct
FROM mexican
WHERE "group" IS NOT NULL
GROUP BY SUBSTR(TRIM("group"), 1, 1)
ORDER BY cohort, outcome


-- Query 2: Average age by conversion outcome per cohort
SELECT 'Lithuanian' AS cohort,
       CASE WHEN CAST(MS AS INTEGER) = 1 THEN 'Converter' ELSE 'Non-converter' END AS outcome,
       ROUND(AVG(Age), 1) AS avg_age
FROM lithuanian
WHERE MS IS NOT NULL
GROUP BY CAST(MS AS INTEGER)
UNION ALL
SELECT 'Mexican' AS cohort,
       CASE WHEN SUBSTR(TRIM("group"), 1, 1) = '1' THEN 'Converter' ELSE 'Non-converter' END AS outcome,
       ROUND(AVG("Age (y)"), 1) AS avg_age
FROM mexican
WHERE "group" IS NOT NULL
GROUP BY SUBSTR(TRIM("group"), 1, 1)
ORDER BY cohort, outcome


-- Query 3: Oligoclonal band positivity rate by conversion outcome per cohort
SELECT 'Lithuanian' AS cohort,
       CASE WHEN CAST(MS AS INTEGER) = 1 THEN 'Converter' ELSE 'Non-converter' END AS outcome,
       SUM(CASE WHEN TRIM("OGB + in CSF") = '1' THEN 1 ELSE 0 END) AS ogb_positive,
       COUNT(CASE WHEN TRIM("OGB + in CSF") IN ('0', '1') THEN 1 END) AS ogb_tested,
       ROUND(
           SUM(CASE WHEN TRIM("OGB + in CSF") = '1' THEN 1 ELSE 0 END) * 100.0 /
           NULLIF(COUNT(CASE WHEN TRIM("OGB + in CSF") IN ('0', '1') THEN 1 END), 0),
       1) AS ogb_positive_pct
FROM lithuanian
WHERE MS IS NOT NULL
GROUP BY CAST(MS AS INTEGER)
UNION ALL
SELECT 'Mexican' AS cohort,
       CASE WHEN SUBSTR(TRIM("group"), 1, 1) = '1' THEN 'Converter' ELSE 'Non-converter' END AS outcome,
       SUM(CASE WHEN SUBSTR(TRIM("Oligoclonal bands"), 1, 1) = '1' THEN 1 ELSE 0 END) AS ogb_positive,
       COUNT(CASE WHEN SUBSTR(TRIM("Oligoclonal bands"), 1, 1) IN ('0', '1') THEN 1 END) AS ogb_tested,
       ROUND(
           SUM(CASE WHEN SUBSTR(TRIM("Oligoclonal bands"), 1, 1) = '1' THEN 1 ELSE 0 END) * 100.0 /
           NULLIF(COUNT(CASE WHEN SUBSTR(TRIM("Oligoclonal bands"), 1, 1) IN ('0', '1') THEN 1 END), 0),
       1) AS ogb_positive_pct
FROM mexican
WHERE "group" IS NOT NULL
GROUP BY SUBSTR(TRIM("group"), 1, 1)
ORDER BY cohort, outcome


-- Query 4: MRI lesion presence rates by conversion outcome per cohort
SELECT 'Lithuanian' AS cohort,
       CASE WHEN CAST(MS AS INTEGER) = 1 THEN 'Converter' ELSE 'Non-converter' END AS outcome,
       ROUND(SUM(CASE WHEN TRIM(Periventricular) = '1' THEN 1 ELSE 0 END) * 100.0 /
             NULLIF(COUNT(CASE WHEN TRIM(Periventricular) IN ('0','1') THEN 1 END), 0), 1) AS periventricular_pct,
       ROUND(SUM(CASE WHEN TRIM("MRI lesion localisation: infratentorally") = '1' THEN 1 ELSE 0 END) * 100.0 /
             NULLIF(COUNT(CASE WHEN TRIM("MRI lesion localisation: infratentorally") IN ('0','1') THEN 1 END), 0), 1) AS infratentorial_pct,
       ROUND(SUM(CASE WHEN TRIM("MRI spinal lesions") = '1' THEN 1 ELSE 0 END) * 100.0 /
             NULLIF(COUNT(CASE WHEN TRIM("MRI spinal lesions") IN ('0','1') THEN 1 END), 0), 1) AS spinal_cord_pct
FROM lithuanian
WHERE MS IS NOT NULL
GROUP BY CAST(MS AS INTEGER)
UNION ALL
SELECT 'Mexican' AS cohort,
       CASE WHEN SUBSTR(TRIM("group"), 1, 1) = '1' THEN 'Converter' ELSE 'Non-converter' END AS outcome,
       ROUND(SUM(CASE WHEN SUBSTR(TRIM("Periventricular MRI"), 1, 1) = '1' THEN 1 ELSE 0 END) * 100.0 /
             NULLIF(COUNT(CASE WHEN SUBSTR(TRIM("Periventricular MRI"), 1, 1) IN ('0','1') THEN 1 END), 0), 1) AS periventricular_pct,
       ROUND(SUM(CASE WHEN SUBSTR(TRIM("Infratentorial MRI"), 1, 1) = '1' THEN 1 ELSE 0 END) * 100.0 /
             NULLIF(COUNT(CASE WHEN SUBSTR(TRIM("Infratentorial MRI"), 1, 1) IN ('0','1') THEN 1 END), 0), 1) AS infratentorial_pct,
       ROUND(SUM(CASE WHEN SUBSTR(TRIM("Spinal cord MRI"), 1, 1) = '1' THEN 1 ELSE 0 END) * 100.0 /
             NULLIF(COUNT(CASE WHEN SUBSTR(TRIM("Spinal cord MRI"), 1, 1) IN ('0','1') THEN 1 END), 0), 1) AS spinal_cord_pct
FROM mexican
WHERE "group" IS NOT NULL
GROUP BY SUBSTR(TRIM("group"), 1, 1)
ORDER BY cohort, outcome


-- Query 5: VEP and BAEP positivity rates by conversion outcome per cohort
SELECT 'Lithuanian' AS cohort,
       CASE WHEN CAST(MS AS INTEGER) = 1 THEN 'Converter' ELSE 'Non-converter' END AS outcome,
       ROUND(SUM(CASE WHEN TRIM("VEP +") = '1' THEN 1 ELSE 0 END) * 100.0 /
             NULLIF(COUNT(CASE WHEN TRIM("VEP +") IN ('0','1') THEN 1 END), 0), 1) AS vep_positive_pct,
       ROUND(SUM(CASE WHEN TRIM("BAEP +") = '1' THEN 1 ELSE 0 END) * 100.0 /
             NULLIF(COUNT(CASE WHEN TRIM("BAEP +") IN ('0','1') THEN 1 END), 0), 1) AS baep_positive_pct
FROM lithuanian
WHERE MS IS NOT NULL
GROUP BY CAST(MS AS INTEGER)
UNION ALL
SELECT 'Mexican' AS cohort,
       CASE WHEN SUBSTR(TRIM("group"), 1, 1) = '1' THEN 'Converter' ELSE 'Non-converter' END AS outcome,
       ROUND(SUM(CASE WHEN SUBSTR(TRIM(VEP), 1, 1) = '1' THEN 1 ELSE 0 END) * 100.0 /
             NULLIF(COUNT(CASE WHEN SUBSTR(TRIM(VEP), 1, 1) IN ('0','1') THEN 1 END), 0), 1) AS vep_positive_pct,
       ROUND(SUM(CASE WHEN SUBSTR(TRIM(BAEP), 1, 1) = '1' THEN 1 ELSE 0 END) * 100.0 /
             NULLIF(COUNT(CASE WHEN SUBSTR(TRIM(BAEP), 1, 1) IN ('0','1') THEN 1 END), 0), 1) AS baep_positive_pct
FROM mexican
WHERE "group" IS NOT NULL
GROUP BY SUBSTR(TRIM("group"), 1, 1)
ORDER BY cohort, outcome


-- Query 6: Cross-population union of shared comparable variables
SELECT 'Lithuanian' AS population,
       CAST(Sex AS INTEGER) AS sex,
       Age AS age,
       CASE WHEN TRIM("OGB + in CSF") IN ('0','1')
            THEN CAST(TRIM("OGB + in CSF") AS INTEGER) ELSE NULL END AS oligoclonal_bands,
       CASE WHEN TRIM(Periventricular) IN ('0','1')
            THEN CAST(TRIM(Periventricular) AS INTEGER) ELSE NULL END AS periventricular_mri,
       CASE WHEN TRIM("MRI lesion localisation: infratentorally") IN ('0','1')
            THEN CAST(TRIM("MRI lesion localisation: infratentorally") AS INTEGER) ELSE NULL END AS infratentorial_mri,
       CASE WHEN TRIM("MRI spinal lesions") IN ('0','1')
            THEN CAST(TRIM("MRI spinal lesions") AS INTEGER) ELSE NULL END AS spinal_cord_mri,
       CASE WHEN TRIM("VEP +") IN ('0','1')
            THEN CAST(TRIM("VEP +") AS INTEGER) ELSE NULL END AS vep,
       CASE WHEN TRIM("BAEP +") IN ('0','1')
            THEN CAST(TRIM("BAEP +") AS INTEGER) ELSE NULL END AS baep,
       CAST(MS AS INTEGER) AS conversion_outcome
FROM lithuanian
WHERE MS IS NOT NULL
UNION ALL
SELECT 'Mexican' AS population,
       CASE WHEN SUBSTR(TRIM(Gender), 1, 1) IN ('1','2')
            THEN CAST(SUBSTR(TRIM(Gender), 1, 1) AS INTEGER) ELSE NULL END AS sex,
       "Age (y)" AS age,
       CASE WHEN SUBSTR(TRIM("Oligoclonal bands"), 1, 1) IN ('0','1')
            THEN CAST(SUBSTR(TRIM("Oligoclonal bands"), 1, 1) AS INTEGER) ELSE NULL END AS oligoclonal_bands,
       CASE WHEN SUBSTR(TRIM("Periventricular MRI"), 1, 1) IN ('0','1')
            THEN CAST(SUBSTR(TRIM("Periventricular MRI"), 1, 1) AS INTEGER) ELSE NULL END AS periventricular_mri,
       CASE WHEN SUBSTR(TRIM("Infratentorial MRI"), 1, 1) IN ('0','1')
            THEN CAST(SUBSTR(TRIM("Infratentorial MRI"), 1, 1) AS INTEGER) ELSE NULL END AS infratentorial_mri,
       CASE WHEN SUBSTR(TRIM("Spinal cord MRI"), 1, 1) IN ('0','1')
            THEN CAST(SUBSTR(TRIM("Spinal cord MRI"), 1, 1) AS INTEGER) ELSE NULL END AS spinal_cord_mri,
       CASE WHEN SUBSTR(TRIM(VEP), 1, 1) IN ('0','1')
            THEN CAST(SUBSTR(TRIM(VEP), 1, 1) AS INTEGER) ELSE NULL END AS vep,
       CASE WHEN SUBSTR(TRIM(BAEP), 1, 1) IN ('0','1')
            THEN CAST(SUBSTR(TRIM(BAEP), 1, 1) AS INTEGER) ELSE NULL END AS baep,
       CASE WHEN SUBSTR(TRIM("group"), 1, 1) = '1' THEN 1 ELSE 0 END AS conversion_outcome
FROM mexican
WHERE "group" IS NOT NULL
ORDER BY population, conversion_outcome


