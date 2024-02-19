--- ESERCIZIO VIDEOGAME STORE 


create database videogame_store;

CREATE TABLE store (
    CodiceStore VARCHAR(50),
    Indirizzo VARCHAR(50),
    Numero VARCHAR(50),
    PRIMARY KEY (CodiceStore),
    FOREIGN KEY (CodiceStore)
        REFERENCES store_gioco (CodiceStore)
);


CREATE TABLE impiegato (
    CF VARCHAR(50),
    Nome VARCHAR(50),
    TitoloStudio TEXT,
    Email VARCHAR(50),
    PRIMARY KEY (CF)
);


CREATE TABLE Servizio_impiegato (
    CF VARCHAR(50),
    CodiceStore INT,
    Data_inizio DATE,
    Data_fine DATE,
    Carica TEXT,
    PRIMARY KEY (CF)
);


CREATE TABLE videogioco (
    Titolo_gioco VARCHAR(50),
    Sviluppatore VARCHAR(50),
    Anno INT,
    Costo DOUBLE,
    Genere VARCHAR(50),
    Remakedi VARCHAR(50) DEFAULT (null),
    PRIMARY KEY (Titolo_gioco)
);



CREATE TABLE store_gioco (
    Collocazione int not null auto_increment,
    CodiceStore VARCHAR(50),
    Titolo_gioco VARCHAR(50),
    PRIMARY KEY (Collocazione),
    CONSTRAINT CodiceStore FOREIGN KEY (CodiceStore)
        REFERENCES store (CodiceStore),
    CONSTRAINT Titolo_gioco FOREIGN KEY (Titolo_gioco)
        REFERENCES videogioco (Titolo_gioco)
);



INSERT INTO store_gioco (CodiceStore, Titolo_gioco)
VALUES
(1, 'Fifa 2023'),
(2, 'Fifa 2023'),
(3, 'Fifa 2023'),
(4, 'Fifa 2023'),
(5, 'Fifa 2023'),
(6, 'Fifa 2023'),
(7, 'Fifa 2023'),
(8, 'Fifa 2023'),
(9, 'Fifa 2023'),
(10, 'Fifa 2023')
;



INSERT INTO store_gioco (CodiceStore, Titolo_gioco)
VALUES
(1, 'Assassin s Creed: Valhalla'),
-- (2, 'Fifa 2023'),
-- (3, 'Fifa 2023'),
(4, 'Assassin s Creed: Valhalla'),
-- (5, 'Fifa 2023'),
(6, 'Assassin s Creed: Valhalla'),
(7, 'Assassin s Creed: Valhalla'),
-- (8, 'Fifa 2023'),
(9, 'Assassin s Creed: Valhalla');
-- (10, 'Fifa 2023')
;



--- ESERCIZIO ORDINI E PRODOTTI

CREATE DATABASE ES1_ORDINI;

CREATE TABLE prodotti (
IDprodotto int auto_increment unique not null primary key,
NomeProdotto varchar (100),
Prezzo decimal (10,2)
); 

INSERT INTO prodotti (NomeProdotto, Prezzo)
VALUES
('Tablet', 30.00),
('Mouse', 20.00),
('Tastiera', 25.00),
('Monitor', 180.00),
('HHD', 90.00),
('SSD', 200.00),
('RAM', 100.00),
('Router', 80.00),
('Webcam', 45.00),
('GPU', 1250.00),
('Trackpad', 500.00),
('Techmagazine', 5.00),
('Martech', 50.00);



create table clienti (
IDcliente int auto_increment unique not null primary key,
Nome varchar (50),
Email varchar (100)
);

INSERT INTO clienti (Nome, Email)
VALUES
('Antonio', ' '),
('Battista', 'battista@mailmail.it'),
('Maria', 'maria@posta.it'),
('Franca', 'franca@lettere.it'),
('Ettore', ' '),
('Arianna', 'arianna@posta.it'),
('Piero', 'piero@lavoro.it');

create table ordini (
IDordine int auto_increment unique not null primary key,
IDprodotto int not null,
IDcliente int,
Quantita int,
constraint IDprodotto foreign key (IDprodotto)
references prodotti (IDprodotto),
constraint IDcliente foreign key (IDcliente)
references clienti (IDcliente)
);




INSERT INTO ordini (IDprodotto, Quantita)
VALUES
(2,10),
(6,2),
(5,3),
(1,1),
(9,1),
(4,2),
(11,6),
(10,2),
(3,3),
(3,1),
(2,1);

--- ESERCIZIO INNER JOIN

SELECT 
    titolostudio
FROM
    impiegato
WHERE
    TitoloStudio = 'laurea in economia'; 
    
SELECT 
    *
FROM
    servizio_impiegato AS s_i
        INNER JOIN
    impiegato AS i ON s_i.CF = i.CF
WHERE
    s_i.CARICA = 'cassiere'
        OR i.Titolostudio = 'Laurea in informatica';
        
        SELECT 
    i.Nome, i.titolostudio
FROM
    servizio_impiegato AS s_i
        INNER JOIN
    impiegato AS i ON s_i.CF = i.CF
    WHERE s_i.data_inizio > 2023-01-01;
    
    
SELECT 
    *
FROM
    servizio_impiegato AS s_i
        INNER JOIN
    impiegato AS i ON s_i.CF = i.CF
WHERE
    i.titolostudio <> 'laurea in economia';
    
   SELECT 
    *
FROM
    servizio_impiegato AS s_i
        INNER JOIN
    impiegato AS i ON s_i.CF = i.CF
WHERE
    s_i.data_inizio < 2023 - 07 - 01
        AND s_i.carica = 'commesso';
        
       SELECT 
    sviluppatore
FROM
    videogioco
WHERE
    anno = 2020;
    
   SELECT 
    *
FROM
    prodotti
WHERE
    PREZZO > 20.00;
    

  SELECT 
    email
FROM
    clienti
WHERE
    nome = 'a%';
    
SELECT 
    *
FROM
    ordini AS o
        INNER JOIN
    prodotti AS p ON o.idprodotto = p.idprodotto
WHERE
    o.quantita > 10 OR prezzo < 100;
    
  SELECT 
    prezzo
FROM
    Prodotti
WHERE
    nomeprodotto LIKE 'tech';

SELECT 
    nome
FROM
    clienti
WHERE
    email = ' '; 
    
    SELECT 
    *
FROM
    prodotti
WHERE
    NOMEPRODOTTO = 'M%'
        AND nomeprodotto = '%e';

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


