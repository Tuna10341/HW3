INSERT INTO MusicVideos (TrackId, VideoDirector)
SELECT TrackId, 'Russell Elevado'
FROM tracks
WHERE Name = 'Voodoo'
LIMIT 1;