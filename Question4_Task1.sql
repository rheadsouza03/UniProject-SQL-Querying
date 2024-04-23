SELECT DISTINCT b.bank_name, b.city
FROM Banks b
LEFT JOIN Robberies r ON b.bank_name = r.bank_name AND b.city = r.city
WHERE r.bank_name IS NULL;
