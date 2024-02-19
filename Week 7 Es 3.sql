

------------------------------------------------ WEEK7 ES3 -----------------------------------------------------------

------- Elencate il numero di tracce per ogni genere in ordine discendente, escludendo quei generi che hanno meno di 10 tracce. 

SELECT
g.name, COUNT(tr.TrackId) as NumberOfTracks
FROM 
track as tr
INNER JOIN genre as g 
on tr.GenreId = g.GenreId
group by g.name
having NumberOfTracks >= 10
order by NumberofTracks desC
;

------- Trovate le tre canzoni più costose

SELECT 
tr.name, tr.UnitPrice
FROM
track AS tr
WHERE
tr.UnitPrice=
(SELECT
max(tr.UnitPrice)
FROM 
track as tr);

------- Elencate gli artisti che hanno canzoni più lunghe di 6 minuti

SELECT 
    ar.Name, tr.Milliseconds
FROM
    Album AS al
        INNER JOIN
    track AS tr ON al.AlbumId = tr.AlbumId
        INNER JOIN
    artist AS ar ON al.ArtistId = ar.ArtistId
WHERE
    tr.milliseconds > 360000;

-------	Individuate la durata media delle tracce per ogni genere

SELECT 
    g.name, AVG(tr.milliseconds) as Avg_tracks
FROM
    genre AS g
        INNER JOIN
    track AS tr ON g.GenreId = tr.GenreId
GROUP BY g.name;

------ Elencate tutte le canzoni con la parola “Love” nel titolo, ordinandole alfabeticamente prima per genere e poi per nome.

SELECT 
tr.name, g.name
FROM
track as tr
INNER JOIN 
genre as g
ON tr.GenreId=g.GenreId
WHERE tr.name LIKE '%Love%' 
ORDER BY g.name;


SELECT 
tr.name, g.name
FROM
track as tr
INNER JOIN 
genre as g
ON tr.GenreId=g.GenreId
WHERE tr.name LIKE '%Love%' 
ORDER BY tr.name;

------ Trovate il costo medio per ogni tipologia di media
SELECT
mt.name, AVG(tr.UnitPrice) as Avg_Track_Cost
FROM
track as tr
INNER JOIN mediatype as mt
on tr.MediaTypeId=mt.MediaTypeId
group by mt.Name;

------ Individuate il genere con più tracce
SELECT
g.name, count(tr.GenreId) as NumberOfTracks 
FROM
track as tr
inner join
genre as g
on tr.GenreId=g.GenreId
GROUP BY g.name;

------- Trovate gli artisti che hanno lo stesso numero di album dei Rolling Stones. 

SELECT 
    ar.name AS ArtistName, COUNT(al.AlbumId) AS AlbumxArtist
FROM
    album AS al
        INNER JOIN
    artist AS ar ON al.ArtistId = ar.ArtistId
GROUP BY ar.name
HAVING COUNT(al.AlbumId) = (SELECT 
        COUNT(al2.AlbumId) AS RS_album
    FROM
        album AS al2
            INNER JOIN
        artist AS ar2 ON al2.ArtistId = ar2.ArtistId
    WHERE
        ar2.name = 'The Rolling Stones'
    GROUP BY ar2.name);

------ Trovate l’artista con l’album più costoso
  
SELECT 
    ar.*,
    TotalAlbumPrice,
    AlbumTitle
FROM
    artist AS ar
INNER JOIN
    (SELECT 
        al.ArtistId,
        SUM(tr.UnitPrice) AS TotalAlbumPrice,
        al.Title AS AlbumTitle
    FROM
        album AS al
    INNER JOIN
        track AS tr ON al.AlbumId = tr.AlbumId
    GROUP BY 
        al.ArtistId, al.Title
    ORDER BY 
        TotalAlbumPrice DESC
    LIMIT 1) AS Subquery
ON
    ar.ArtistId = Subquery.ArtistId;
