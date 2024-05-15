use DB_Sprotify;

-- Bistak

-- Erabiltzaile konkretu baten Playlistak ikusteko.
DROP VIEW IF EXISTS ikusiPlayListak;
CREATE VIEW ikusiPlayListak AS 
SELECT p.Izenburua, p.Sorrera_data, b.Erabiltzailea AS 'Sortzailea'
FROM Playlist p INNER JOIN Bezeroa b USING(ID_Bezeroa)
WHERE b.Erabiltzailea = 'sophia_fernandez';

-- Musikarien abestiak zenbat erreprodukzio daukaten ikusteko.
DROP VIEW IF EXISTS musikaDeskubritu;
CREATE VIEW musikaDeskubritu AS 
SELECT m.Izen_Artistikoa AS 'Musikaria', COUNT(e.ID_Audio) AS 'Erreprodukzioak'
FROM Musikaria m INNER JOIN Album a USING(ID_Musikaria)
					INNER JOIN Abestia ab USING(ID_Album)
						INNER JOIN Audio au USING(ID_Audio)
							INNER JOIN Erreprodukzioak e USING(ID_Audio)
GROUP BY m.Izen_Artistikoa;

-- Playlist-en informazioa lortzeko.
DROP VIEW IF EXISTS playListView;
CREATE VIEW playListView AS
SELECT p.ID_List AS 'ID_List', p.Izenburua AS 'Izena', COUNT(pa.ID_Audio) AS 'Abestiak', p.ID_Bezeroa AS 'ID_Bezeroa'
FROM Playlist p LEFT JOIN Playlist_Abestiak pa USING(ID_List)
GROUP BY p.ID_List;

-- Podcasterren podcasten erreprodukzio kopurua ikusteko.
DROP VIEW IF EXISTS podcastDeskubritu;
CREATE VIEW podcastDeskubritu AS 
SELECT p.Izen_artistikoa AS 'Podcasterra', COUNT(e.ID_Audio) AS 'Erreprodukzioak'
FROM Podcaster p LEFT JOIN Podcast po USING(ID_Podcaster)
					LEFT JOIN Erreprodukzioak e USING(ID_Audio)
GROUP BY p.Izen_artistikoa;

-- Albumen informazioa lortzeko.
DROP VIEW IF EXISTS AlbumView;
CREATE VIEW AlbumView AS
SELECT a.ID_Album AS 'ID_Album', a.Izenburua AS 'Izenburua', COUNT(ab.ID_Audio) AS 'Abestiak', m.ID_Musikaria
FROM Album a LEFT JOIN Abestia ab USING(ID_Album)
		LEFT JOIN Musikaria m USING(ID_Musikaria)
GROUP BY a.ID_Album;

-- Albumen informazio osatua lortzeko.
DROP VIEW IF EXISTS AlbumInfo;
CREATE VIEW AlbumInfo AS
SELECT a.ID_Album AS 'ID_Album', a.Izenburua AS 'Izenburua', a.Urtea AS 'Urtea', COUNT(ab.ID_Audio) AS 'AbestiKop', SUM(au.Iraupena) AS 'Iraupena', a.Irudia AS 'Irudia', a.Deskripzioa AS 'Deskribapena'
FROM Album a INNER JOIN Abestia ab USING(ID_Album)
		INNER JOIN Audio au USING(ID_Audio)
GROUP BY a.ID_Album;

-- Podcastak ikusteko.
DROP VIEW IF EXISTS PodcastIkusi;
CREATE VIEW PodcastIkusi AS
SELECT a.ID_Audio AS ID_Audio, a.Izena AS Izena, a.Iraupena AS Iraupena, p.ID_Podcaster AS ID_Podcaster, p.Kolaboratzaileak AS Kolaboratzaileak, a.Irudia AS Irudia
FROM Audio a INNER JOIN Podcast p USING(ID_Audio)
WHERE a.mota = 'Podcast';
