SELECT g.Name AS Genre,
       COUNT(t.TrackId) AS TrackCount,
       ROUND(AVG(t.Milliseconds), 2) AS AvgMilliseconds
FROM genres g
JOIN tracks t ON t.GenreId = g.GenreId
GROUP BY g.GenreId
ORDER BY AvgMilliseconds DESC;
