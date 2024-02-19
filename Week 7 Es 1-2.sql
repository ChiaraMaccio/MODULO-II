--- ES 1&2 WEEK7

SELECT 
    *
FROM
    track AS T
        INNER JOIN
    genre AS G ON T.GenreId = G.GenreId;

SELECT distinct
    *
FROM
    album AS A
		RIGHT JOIN
    artist AS AR ON A.ArtistId = AR.ArtistId;
    
SELECT 
    *
FROM
    track AS t
        INNER JOIN
    genre AS g ON t.GenreId = g.GenreId
        INNER JOIN
    mediatype AS mt ON t.MediaTypeId = mt.MediaTypeId
;

SELECT 
    *
FROM
    artist AS ar
        LEFT JOIN
    album AS a ON ar.ArtistId = a.ArtistId
    ;
  
  
SELECT 
    tr.Name
FROM
    track AS tr
        LEFT JOIN
    genre AS g ON tr.GenreId = g.GenreId
WHERE
    g.Name = 'Rock' OR g.name = 'Pop';
    
    SELECT
    *
    FROM 
    artist as ar
    WHERE ar.name LIKE 'A%';
    
		SELECT 
        *
        FROM 
        album as al
        inner join artist as ar
        on
        al.ArtistId = ar.ArtistId
	;
        
        
SELECT 
   *
FROM
    track AS tr
        LEFT JOIN
    genre AS g ON tr.GenreId = g.GenreId
WHERE g.name = 'Jazz' or tr.Milliseconds < 180000;

--- ARGOMENTO INTERNO
SELECT 
            AVG(Milliseconds)
        FROM
            track AS avg_track;

SELECT 
    *
FROM
    track
WHERE
    Milliseconds > (SELECT 
            AVG(Milliseconds)
        FROM
            track AS avg_track);

SELECT 
    g.Name,
    AVG(tr.Milliseconds) AS MediaMilliseconds
FROM
    track AS tr
    INNER JOIN genre AS g ON tr.GenreId = g.GenreId
GROUP BY
    g.Name
HAVING
    AVG(tr.Milliseconds) > 240000;

SELECT 
    ar.Name AS ArtistName, COUNT(al.AlbumId) AS NumberOfAlbums
FROM
    album AS al
        INNER JOIN
    track AS tr ON al.AlbumId = tr.AlbumId
        INNER JOIN
    artist AS ar ON al.ArtistId = ar.ArtistId
GROUP BY ar.Name
HAVING COUNT(al.AlbumId) > 1;



---- innerjoin album e track

SELECT 
    tr2.Name AS track_name
FROM
    track AS tr2
        INNER JOIN
    (SELECT 
        al.AlbumId AS al_id,
            al.title AS albumTitle,
            MAX(Milliseconds) AS durata_max
    FROM
        Album AS al
    INNER JOIN track AS tr ON tr.AlbumId = al.AlbumId
    GROUP BY al_id , albumTitle) AS durata_max_album ON durata_max_album.al_id = tr2.AlbumId
        AND tr2.Milliseconds = durata_max_album.durata_max;


SELECT
al.AlbumId,
al.Title as AlbumTitle,
AVG(Milliseconds)
FROM 
Album as al
INNER JOIN
Track as tr
on
al.AlbumId=tr.AlbumId
group by al.AlbumId, al.Title;

SELECT 
    al.Title, COUNT(tr.TrackId) AS NumberOfTrack
FROM
    track AS tr
        INNER JOIN
    album al ON tr.AlbumId = al.AlbumId
GROUP BY al.Title
HAVING COUNT(tr.TrackId) > 20;


