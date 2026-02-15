WITH avg_len AS (
  SELECT AVG(Milliseconds) AS avg_ms
  FROM tracks
  WHERE Milliseconds <= 900000
)
SELECT DISTINCT c.CustomerId, c.FirstName, c.LastName, c.Email
FROM customers c
JOIN invoices i ON i.CustomerId = c.CustomerId
JOIN invoice_items ii ON ii.InvoiceId = i.InvoiceId
JOIN tracks t ON t.TrackId = ii.TrackId
CROSS JOIN avg_len
WHERE t.Milliseconds > avg_len.avg_ms
  AND t.Milliseconds <= 900000
ORDER BY c.LastName, c.FirstName;
