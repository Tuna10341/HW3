CREATE TABLE MusicVideos (
  TrackId INTEGER PRIMARY KEY,
  VideoDirector NVARCHAR(120) NOT NULL,
  FOREIGN KEY (TrackId) REFERENCES tracks(TrackId)
);

INSERT INTO MusicVideos (TrackId, VideoDirector) VALUES (1, 'John');
INSERT INTO MusicVideos (TrackId, VideoDirector) VALUES (2, 'Alex');
INSERT INTO MusicVideos (TrackId, VideoDirector) VALUES (3, 'Tammy');
INSERT INTO MusicVideos (TrackId, VideoDirector) VALUES (4, 'Nikhil');
INSERT INTO MusicVideos (TrackId, VideoDirector) VALUES (5, 'Jackson');
INSERT INTO MusicVideos (TrackId, VideoDirector) VALUES (6, 'Alan');
INSERT INTO MusicVideos (TrackId, VideoDirector) VALUES (7, 'Taylor');
INSERT INTO MusicVideos (TrackId, VideoDirector) VALUES (8, 'Mason');
INSERT INTO MusicVideos (TrackId, VideoDirector) VALUES (9, 'Jordan');
INSERT INTO MusicVideos (TrackId, VideoDirector) VALUES (10, 'Ava');

INSERT INTO MusicVideos (TrackId, VideoDirector)
SELECT TrackId, 'Russell Elevado'
FROM tracks
WHERE Name = 'Voodoo'
LIMIT 1;

SELECT TrackId, Name
FROM tracks
WHERE Name LIKE '%á%'
   OR Name LIKE '%é%'
   OR Name LIKE '%í%'
   OR Name LIKE '%ó%'
   OR Name LIKE '%ú%'
ORDER BY Name;

SELECT ar.Name AS Artist,
       ROUND(SUM(ii.UnitPrice * ii.Quantity), 2) AS Revenue
FROM artists ar
JOIN albums al ON al.ArtistId = ar.ArtistId
JOIN tracks t ON t.AlbumId = al.AlbumId
JOIN invoice_items ii ON ii.TrackId = t.TrackId
GROUP BY ar.ArtistId
ORDER BY Revenue DESC
LIMIT 10;

SELECT g.Name AS Genre,
       COUNT(t.TrackId) AS TrackCount,
       ROUND(AVG(t.Milliseconds), 2) AS AvgMilliseconds
FROM genres g
JOIN tracks t ON t.GenreId = g.GenreId
GROUP BY g.GenreId
ORDER BY AvgMilliseconds DESC;

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
