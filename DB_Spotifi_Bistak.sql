use DB_Sprotify;

-- Bistak

-- Erabiltzaile konkretu baten Playlistak ikusteko.
drop view if exists ikusiPlayListak;
create view ikusiPlayListak as 
select p.Izenburua, p.Sorrera_data, b.Erabiltzailea as 'Sortzailea'
from Playlist p inner join Bezeroa b using(ID_Bezeroa)
where b.Erabiltzailea = 'sophia_fernandez';

-- Musikarien abestiak zenbat erreprodukzio daukaten ikusteko.
drop view if exists musikaDeskubritu;
create view musikaDeskubritu as 
select m.Izen_Artistikoa as 'Musikaria', count(e.ID_Audio) as 'Erreprodukzioak'
from Musikaria m inner join Album a using(ID_Musikaria)
					inner join Abestia ab using(ID_Album)
						inner join Audio au using(ID_Audio)
							inner join Erreprodukzioak e using(ID_Audio)
group by m.Izen_Artistikoa;

drop view if exists playListView;
create view playListView as
select p.ID_List as 'ID_List', p.Izenburua as 'Izena', count(pa.ID_Audio) as 'Abestiak'
from Playlist p inner join Playlist_Abestiak pa using(ID_List)
group by p.ID_List;

-- Podcasterren podcastak zenbat erreprodukzio daukaten ikusteko.
drop view if exists podcastDeskubritu;
create view podcastDeskubritu as 
select p.Izen_artistikoa as 'Podcasterra', count(e.ID_Audio) as 'Erreprodukzioak'
from Podcaster p inner join Podcast po using(ID_Podcaster)
					inner join Erreprodukzioak e using(ID_Audio)
group by p.Izen_artistikoa;


drop view if exists AlbumView;
create view AlbumView as
select a.ID_Album as 'ID_Album', a.Izenburua as 'Izenburua', count(ab.ID_Audio) as 'Abestiak', m.ID_Musikaria
from Album a inner join Abestia ab using(ID_Album)
	inner join Musikaria m using(ID_Musikaria)
group by a.ID_Album;


drop view if exists AlbumInfo;
create view AlbumInfo as
select a.ID_Album as 'ID_Album', a.Izenburua as 'Izenburua', a.Urtea as 'Urtea', count(ab.ID_Audio) as 'AbestiKop', sum(au.Iraupena) as 'Iraupena', a.Irudia as 'Irudia'
from Album a inner join Abestia ab using(ID_Album)
	inner join Audio au using(ID_Audio)
group by a.ID_Album;


drop view if exists PodcastIkusi;
create view PodcastIkusi as
select a.ID_Audio as ID_Audio, a.Izena as Izena, a.Iraupena as Iraupena, p.ID_Podcaster as ID_Podcaster, p.Kolaboratzaileak as Kolaboratzaileak
from Audio a inner join Podcast p using(ID_Audio)
where a.mota = 'Podcast';
