-- Adarsh S C391

/*
Aggregate Queries

REQUIREMENT - Use a multi-line comment to paste the first 5 or fewer results under your query
		     THEN records returned. 
*/

USE orderbook_activity_db;


-- #1: How many users do we have?
SELECT COUNT(*) AS 'user count'
FROM User;
/*
7
ROWS=1
*/


-- #2: List the username, userid, and number of orders each user has placed.
SELECT u.uname AS username,
       u.userid,
       COUNT(o.orderid) AS 'number of orders'
FROM User u
LEFT JOIN `Order` o ON u.userid = o.userid
GROUP BY u.userid, u.uname;
/*
admin	1	3
alice	5	8
james	3	3
kendra	4	5
robert	6	5
ROWS=7
*/


-- #3: List the username, symbol, and number of orders placed for each user and for each symbol. 
-- Sort results in alphabetical order by symbol.
SELECT uname, symbol, COUNT(o.orderid) 'number of orders'
FROM orderbook_activity_db.Order o JOIN User u ON o.userid = u.userid
GROUP BY u.userid, o.symbol
ORDER BY o.symbol;
/* 
alice	A	5
james	A	1
robert	AAA	1
admin	AAPL	1
robert	AAPL	1
ROWS=19
*/


-- #4: Perform the same query as the one above, but only include admin users.
SELECT uname, symbol, COUNT(o.orderid) 'number of orders'
FROM orderbook_activity_db.Order o 
JOIN User u ON o.userid = u.userid 
JOIN UserRoles ur ON u.userid = ur.userid 
JOIN Role r ON ur.roleid = r.roleid
WHERE r.roleid = 1
GROUP BY u.userid, o.symbol
ORDER BY o.symbol;
/* 7 rows
alice	GOOG	1
admin	GS	1
alice	SPY	1
alice	TLT	1
admin	WLY	1
ROWS=7
*/


-- #5: List the username and the average absolute net order amount for each user with an order.
-- Round the result to the nearest hundredth and use an alias (averageTradePrice).
-- Sort the results by averageTradePrice with the largest value at the top.
SELECT uname, ROUND(AVG(ABS(shares*price)), 2) 'average absolute net order amount'
FROM orderbook_activity_db.Order o JOIN User u ON o.userid = u.userid
GROUP BY u.userid
ORDER BY 'average absolute net order amount' DESC;
/* 
kendra	17109.53
admin	12182.47
robert	10417.84
alice	6280.26
james	2053.73
ROWS=5
*/

-- #6: How many shares for each symbol does each user have?
-- Display the username and symbol with number of shares.
SELECT uname, symbol, SUM(o.shares) shares
FROM orderbook_activity_db.Order o 
RIGHT JOIN User u ON o.userid = u.userid
GROUP BY o.symbol, u.userid;
/*
admin	WLY	100
admin	GS	100
admin	AAPL	-15
alice	A	18
alice	SPY	100
ROWS=21
*/


-- #7: What symbols have at least 3 orders?
SELECT symbol, COUNT(orderid) orders FROM orderbook_activity_db.Order
GROUP BY symbol
HAVING COUNT(orderid) >=3;
/* 
A	6
AAPL	3
WLY	3
ROWS=3
*/


-- #8: List all the symbols and absolute net fills that have fills exceeding $100.
-- Do not include the WLY symbol in the results.
-- Sort the results by highest net with the largest value at the top.
SELECT symbol, MAX(ABS(share * price)) AS 'absolute_net_fills'
FROM orderbook_activity_db.Fill
WHERE ABS(share * price)>100 AND symbol != 'WLY'
GROUP BY symbol
ORDER BY 'absolute_net_fills' DESC;
/* 
SPY		27429.75
GS		3056.30
AAPL	2111.40
A		1298.90
TLT		989.30
ROWS=5
*/



-- #9: List the top five users with the greatest amount of outstanding orders.
-- Display the absolute amount filled, absolute amount ordered, and net outstanding.
-- Sort the results by the net outstanding amount with the largest value at the top.
SELECT u.userid, uname, ABS(o.shares*o.price) 'absolute amount of orders', ABS(f.share*f.price) 'absolute amount filled', ABS(o.shares*o.price) - ABS(f.share*f.price) 'net outstanding' 
FROM orderbook_activity_db.Order o JOIN User u ON o.userid = u.userid LEFT JOIN Fill f ON o.orderid = f.orderid
ORDER BY 'net outstanding' DESC LIMIT 5;
/*
1	admin	30563.00	3056.30		27506.70
5	alice	36573.00	27429.75	9143.25
1	admin	3873.00		387.30		3485.70
6	robert	3519.00		1407.60		2111.40
6	robert	3519.00		2111.40		1407.60
ROWS=5
*/
