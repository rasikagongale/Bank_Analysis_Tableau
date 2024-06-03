select * from finance2;
select * from Finance1;


--Year wise loan amount Stats

SELECT YEAR(issue_d) AS Loan_Year, SUM(loan_amnt) AS TotalLoanAmount
FROM Finance1
GROUP BY YEAR(issue_d)
ORDER BY Loan_Year;


--Grade and sub grade wise revol_bal

--SELECT 
   -- grade,
--sub_grade,
  --  AVG(revol_bal) AS AvgRevolBal,
   -- SUM(revol_bal) AS TotalRevolBal,
   -- MAX(revol_bal) AS MaxRevolBal
--FROM Finance1
--GROUP BY grade, sub_grade
--ORDER BY grade, sub_grade;



SELECT -- top 10
    f.grade,
    f.sub_grade,
    SUM(ld.revol_bal) AS total_revol_bal
FROM
    Finance1 f
JOIN
    Finance2 ld ON f.id = ld.id
GROUP BY
    f.grade,
    f.sub_grade
ORDER BY
    f.grade,
    f.sub_grade;



--Total Payment for Verified Status Vs Total Payment for Non Verified Status


SELECT 
    f1.verification_status AS VerificationStatus,
    SUM(f2.total_pymnt) AS TotalPayment,
    FORMAT(SUM(f2.total_pymnt) * 100.0 / (SELECT SUM(total_pymnt) FROM Finance2), 'N2') AS PaymentPercentage
FROM 
    Finance1 f1
JOIN 
    Finance2 f2 ON f1.id = f2.id
WHERE 
    f1.verification_status IN ('Not Verified', 'Verified')
GROUP BY 
    f1.verification_status;


--State wise and last_credit_pull_d wise loan status

SELECT 
    f1.addr_state AS State,
    f2.last_credit_pull_d AS LastCreditPullDate,
    f1.loan_status AS LoanStatus,
    COUNT(*) AS TotalLoans
FROM 
    Finance1 f1
JOIN 
       Finance2 f2 ON f1.id = f2.id
GROUP BY 
    f1.addr_state, f2.last_credit_pull_d, f1.loan_status
ORDER BY 
    f1.addr_state, f2.last_credit_pull_d DESC;


--Home ownership Vs last payment date stats

SELECT 
    f1.home_ownership AS HomeOwnership,
    MAX(f2.last_pymnt_d) AS LastPaymentDate,
    COUNT(*) AS TotalLoans
FROM 
        Finance1 f1
LEFT JOIN 
    Finance2 f2 ON f1.id = f2.id
GROUP BY 
    f1.home_ownership;


