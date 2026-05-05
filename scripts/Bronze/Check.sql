-------------------------Cleaning crm_cust_info------------------------
-- ############ Check Nulls & Duplicated in PK ###################

SELECT
cci.cst_id,
COUNT(*) As Repeated
FROM bronze.crm_cust_info cci
GROUP BY cci.cst_id
HAVING COUNT(*) > 1 OR cci.cst_id IS NULL

SELECT
*
FROM 
(
SELECT 
*,
ROW_NUMBER() OVER(PARTITION BY cci.cst_id ORDER BY cci.cst_create_date DESC) as Ranked
FROM bronze.crm_cust_info cci
WHERE cst_id IS NOT NULL
)t WHERE Ranked = 1 


-- ############ Check Unwanted Spaces ###################
SELECT
cst_firstname,
COUNT(*) OVER()
FROM bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)
--There are 15 Value

SELECT
cst_lastname,
COUNT(*) OVER()
FROM bronze.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname)
--There are 17 Value

SELECT
cst_marital_status,
COUNT(*) OVER()
FROM bronze.crm_cust_info
WHERE cst_marital_status != TRIM(cst_marital_status)
--There are NO Value

-- ############ Check Standrization & Consistency ###################
SELECT DISTINCT (cst_gndr)
FROM bronze.crm_cust_info 
--Notes:
--there are null values 
--I want use Male,Female insetad of M,F

SELECT DISTINCT (cst_material_status)
FROM bronze.crm_cust_info 
--Notes:
--there are null values 
--I want use Male,Female insetad of M,F


------------------------- Cleaning crm_prd_info ------------------------
-- ############ Check Nulls & Duplicated in PK ###################
SELECT
*
FROM(
SELECT
*,
ROW_NUMBER() OVER(PARTITION BY prd_id ORDER BY prd_start_dt DESC) AS Ranked
FROM bronze.crm_prd_info
WHERE prd_id IS NOT NULL)t
WHERE Ranked = 1


-- ############ Check Unwanted Spaces ###################
SELECT 
*
FROM bronze.crm_prd_info
WHERE prd_line != TRIM(prd_line)
--no unwanted space

-- ############ Check Standrization & Consistency ###################
SELECT 
DISTINCT prd_line
FROM bronze.crm_prd_info


-- ############ G ###############
-- 
SELECT
       prd_id
      ,prd_key
      ,REPLACE(SUBSTRING(prd_key,1,5),'-','_') AS cat_id
      ,SUBSTRING(prd_key,7,LEN(prd_key)) AS prd_key
      ,prd_nm
      ,ISNULL(prd_cost,0) prd_cost
      ,CASE WHEN UPPER(TRIM(prd_line)) = 'M' THEN 'Mountain'
            WHEN UPPER(TRIM(prd_line)) = 'R' THEN 'Road'
            WHEN UPPER(TRIM(prd_line)) = 'S' THEN 'Other Sales'
            WHEN UPPER(TRIM(prd_line)) = 'T' THEN 'Touring'
            ELSE 'n/a'
        END AS prd_line
      ,prd_start_dt
      ,prd_end_dt
  FROM bronze.crm_prd_info
  WHERE SUBSTRING(prd_key,7,LEN(prd_key)) IN (
  SELECT
  sls_prd_key
  FROM bronze.crm_sales_details)


-- ######## Check Invalid Date & Order #############
SELECT
*
FROM bronze.crm_prd_info
WHERE prd_start_dt > prd_end_dt

-- ##############################################
SELECT 
      NULLIF(sls_order_dt,0) sls_order_dt
      ,sls_ship_dt
      ,sls_due_dt
FROM bronze.crm_sales_details
WHERE sls_order_dt < 0 OR LEN(sls_order_dt) !=8

SELECT 
       sls_ord_num
      ,sls_prd_key
      ,sls_cust_id
      ,CASE WHEN sls_order_dt <=0 OR LEN(sls_order_dt) != 8 THEN NULL
        ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE)
        END sls_order_dt
       ,CASE WHEN sls_ship_dt <=0 OR LEN(sls_ship_dt) != 8 THEN NULL
        ELSE CAST(CAST(sls_ship_dt AS VARCHAR) AS DATE)
        END sls_ship_dt
      ,CASE WHEN sls_due_dt <=0 OR LEN(sls_due_dt) != 8 THEN NULL
        ELSE CAST(CAST(sls_due_dt AS VARCHAR) AS DATE)
        END sls_due_dt
      ,CASE WHEN sls_sales IS NULL OR sls_sales    <= 0 OR sls_sales != sls_quantity * ABS(sls_price)
            THEN  sls_quantity * ABS(sls_price) 
        ELSE sls_sales
        END sls_sales
      ,sls_quantity
      ,CASE WHEN sls_price IS NULL OR sls_price <= 0 
            THEN sls_sales / NULLIF(sls_quantity,0)
        ELSE sls_price
        END sls_price
FROM bronze.crm_sales_details

--########################### erp_cust_az12 ##############################
  SELECT *
  FROM silver.crm_cust_info
  WHERE cst_key LIKE 'NAS%'

  --### check Bdate
SELECT
    *
FROM bronze.erp_cust_az12
WHERE bdate < '1926-01-01' OR bdate > GETDATE()

--### Check gen
SELECT DISTINCT 
    gen
FROM bronze.erp_cust_az12

---

SELECT 
       CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid,4 , LEN(cid))
       ELSE cid
       END cid
      ,CASE WHEN bdate > GETDATE() THEN NULL   -- bdate < '1926-01-01' but it may be logical and Important
       ELSE bdate
       END bdate
      ,CASE WHEN UPPER(TRIM(gen)) ='' THEN 'n/a'
            WHEN UPPER(TRIM(gen)) ='M' THEN 'Male'
        ELSE
            gen
        END gen
  FROM bronze.erp_cust_az12

--########################### erp_loc_a101 ##############################
SELECT DISTINCT
*
/*CASE WHEN UPPER(TRIM(cntry)) ='' THEN 'n/a'
     WHEN UPPER(TRIM(cntry)) ='US' THEN 'United States'
     WHEN UPPER(TRIM(cntry)) ='DE' THEN 'Germany'
     WHEN cntry IS NULL THEN 'n/a'
ELSE cntry
END cntry2*/
FROM silver.erp_loc_a101
/*
SELECT 
*
FROM bronze.crm_cust_info*/


--The last table is clean 
