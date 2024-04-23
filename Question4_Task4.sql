SELECT DISTINCT ha.bank_name, ha.city
FROM HasAccounts ha
JOIN Robbers r ON ha.robber_id = r.robber_id AND r.nickname = 'Al Capone';
