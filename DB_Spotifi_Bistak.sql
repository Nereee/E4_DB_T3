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

-- Podcasterren podcastak zenbat erreprodukzio daukaten ikusteko.
drop view if exists podcastDeskubritu;
create view podcastDeskubritu as 
select p.Izen_artistikoa as 'Podcasterra', count(e.ID_Audio) as 'Erreprodukzioak'
from Podcaster p inner join Podcast po using(ID_Podcaster)
					inner join Erreprodukzioak e using(ID_Audio)
group by p.Izen_artistikoa;