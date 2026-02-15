WITH top5_long_genres AS (
  SELECT GenreId
  FROM tracks
  WHERE GenreId IS NOT NULL
  GROUP BY GenreId
  ORDER BY AVG(Milliseconds) DESC
  LIMIT 5
)
SELECT t.TrackId, t.Name, g.Name AS Genre, t.Milliseconds
FROM tracks t
LEFT JOIN genres g ON g.GenreId = t.GenreId
WHERE t.GenreId NOT IN (SELECT GenreId FROM top5_long_genres)
ORDER BY t.Milliseconds DESC, t.Name;
