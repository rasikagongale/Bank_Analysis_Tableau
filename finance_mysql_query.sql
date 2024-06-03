create database Bank_Analysis;

use bank_analysis;
select * from finance1;
select * from finance2;

select count(id) as Total_Loan_Application from finance1; 

select sum(funded_amnt) as Total_Funded_Amount from finance1;

select sum(total_pymnt) as Total_Payment from finance2;

-- select avg(int_rate) as Avg_int_rate from finance1;

SELECT CONCAT(ROUND(AVG(int_rate) * 100, 2), '%') AS Avg_int_rate_percentage
FROM finance1;


SELECT FORMAT(AVG(dti), 2) AS Avg_dti 
FROM finance1;




-- 1) Year wise loan amount Stats

SELECT YEAR(issue_d) AS Loan_Year, SUM(loan_amnt) AS TotalLoanAmount
FROM Finance1
GROUP BY YEAR(issue_d)
ORDER BY Loan_Year;


-- 2) Grade and sub grade wise revol_bal
SELECT -- top 10
    f.grade,
    f.sub_grade,
    SUM(ld.revol_bal) AS total_revol_bal
FROM  Finance1 f
JOIN
    Finance2 ld ON f.id = ld.id
GROUP BY
    f.grade, f.sub_grade
ORDER BY
    f.grade, f.sub_grade;
                                                                
    
-- 3) Total Payment for Verified Status Vs Total Payment for Not Verified Status

SELECT 
    f1.verification_status AS VerificationStatus,
    SUM(f2.total_pymnt) AS TotalPayment,
    CONCAT(FORMAT(SUM(f2.total_pymnt) * 100.0 / (SELECT SUM(total_pymnt) FROM Finance2), 'N2'), '%') AS PaymentPercentage
FROM 
    Finance1 f1
JOIN 
    Finance2 f2 ON f1.id = f2.id
WHERE 
    f1.verification_status IN ('Not Verified', 'Verified','Source Verified')
GROUP BY 
    f1.verification_status;
    
    --  SELECT verification_status from finance1;

-- 4) State wise and last_credit_pull_d wise loan status

SELECT 
    f1.addr_state AS State,
   f2.last_credit_pull_d AS LastCreditPullDate,
    f1.loan_stat
    us AS LoanStatus
 
FROM 
    Finance1 f1
JOIN 
       Finance2 f2 ON f1.id = f2.id
GROUP BY 
    f1.addr_state,f2.last_credit_pull_d, f1.loan_status
ORDER BY 
    f1.addr_state,f2.last_credit_pull_d DESC;


-- 5) Home ownership Vs last payment date stats

SELECT 
    f1.home_ownership AS HomeOwnership,
    MAX(f2.last_pymnt_d) AS LastPaymentDate,
    count(home_ownership)
FROM  Finance1 f1
LEFT JOIN 
    Finance2 f2 ON f1.id = f2.id
GROUP BY 
    f1.home_ownership;



desc finance2;
    



