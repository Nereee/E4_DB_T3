use DB_Sprotify;

-- Bistak

-- Erabiltzaile konkretu baten Playlistak ikusteko.
drop view if exists ikusiPlayListak;
create view ikusiPlayListak as 
select p.Izenburua, p.Sorrera_data, b.Erabiltzailea as 'Sortzailea'
from Playlist p inner join Bezeroa b using(ID_Bezeroa)
where b.Erabiltzailea = 'sophia_fernandez';

-- Musikari konkretu baten Albumak ikusteko.
drop view if exists erakutsiMusikariarenAlbumak;
create view erakutsiMusikariarenAlbumak as 
select a.Izenburua, a.Urtea, a.Generoa , m.Izen_Artistikoa
from Album a inner join Musikaria m using(ID_Musikaria)
where m.Izen_Artistikoa = 'Estopa';

-- Zein erabiltzaile entzun duen The Wild Project #1
drop view if exists TWPEntzumena;
create view TWPEntzumena as 
select a.Izena, a.Iraupena, a.Mota, b.Erabiltzailea as 'Nortzuk entzun dute'
from Audio a inner join Erreprodukzioak e using(ID_Audio)
				inner join Bezeroa b using(ID_Bezeroa)
where a.Izena = 'The Wild Proyect Podcast #1';