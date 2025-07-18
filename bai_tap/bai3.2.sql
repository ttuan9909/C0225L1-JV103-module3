SELECT oID, oDate, pTotalPrice FROM orderproduct; 

SELECT 
  c.cID, c.cName, p.pName, od.odQTY
FROM Customer c
JOIN orderproduct o ON c.cID = o.cID
JOIN OrderDetail od ON o.oID = od.oID
JOIN Product p ON od.pID = p.pID;

SELECT c.cName
FROM Customer c
LEFT JOIN orderproduct o ON c.cID = o.cID
WHERE o.oID IS NULL;

SELECT 
    o.oID,
    o.oDate,
    SUM(od.odQTY * p.pPrice) AS totalPrice
FROM orderproduct o
JOIN OrderDetail od ON o.oID = od.oID
JOIN Product p ON od.pID = p.pID
GROUP BY o.oID, o.oDate;

