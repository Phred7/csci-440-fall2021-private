SELECT name FROM tracks
WHERE AlbumId=(SELECT AlbumId from albums WHERE Title="Machine Head");

SELECT AlbumId, Title from albums WHERE Title LIKE "A%";

SELECT name FROM tracks
WHERE AlbumId=(SELECT AlbumId from albums WHERE Title LIKE "A%");


SELECT name FROM tracks
WHERE AlbumId IN (SELECT AlbumId from albums WHERE Title LIKE "A%");

-- Select all albums with a total size over 1Mb
SELECT title
FROM albums
WHERE 10000000 > (SELECT SUM(bytes)
    FROM tracks
WHERE tracks.AlbumId = albums.AlbumId) ;

SELECT SUM(bytes)
FROM tracks
WHERE tracks.AlbumId = 1;

-- Denormalized query
SELECT title
FROM albums
WHERE 10000000 > albums.bytes;

-- Move condition into subquery
SELECT Name from artists where
ArtistId IN
(SELECT albums.ArtistId
FROM albums
WHERE albums.AlbumId IN
      (SELECT AlbumId FROM tracks
       GROUP BY AlbumId
    HAVING  10000000 > SUM(tracks.Bytes)));


-- Gets all first album where artist has more than one album
SELECT *
FROM albums
GROUP BY ArtistId
HAVING COUNT(*) > 1;

-- returns all artists that have more than one album
SELECT Name
FROM albums
JOIN artists on artists.ArtistId = albums.ArtistId
GROUP BY albums.ArtistId
HAVING COUNT(*) > 1;

-- returns all tracks longer than six minutes along with the album and artist name
SELECT tracks.Name as TrackName, albums.Title as AlbumTitle, artists.Name as ArtistsName
FROM tracks
JOIN albums ON tracks.AlbumId = albums.AlbumId
JOIN artists ON albums.ArtistId = artists.ArtistId
WHERE tracks.Milliseconds > 6 * 60 * 1000;