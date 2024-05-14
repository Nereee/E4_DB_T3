USE DB_Sprotify;

-- Rolak
drop role if exists 'Administratzailea';
CREATE ROLE if not exists 'Administratzailea';

drop role if exists 'Analista';
CREATE ROLE if not exists 'Analista';

drop role if exists 'Departamentu_burua';
CREATE ROLE if not exists 'Departamentu_burua';

drop role if exists 'Langilea';
CREATE ROLE if not exists 'Langilea';

drop role if exists 'Bezeroa';
CREATE ROLE if not exists 'Bezeroa';

-- Rolei pribilegioak
GRANT ALL PRIVILEGES ON DB_Sprotify.* TO 'Administratzailea';

GRANT SELECT ON DB_Sprotify.* TO 'Analista';

GRANT SELECT ON DB_Sprotify.Hizkuntza TO 'Departamentu_burua';
GRANT SELECT ON DB_Sprotify.Musikaria TO 'Departamentu_burua';
GRANT SELECT ON DB_Sprotify.Podcaster TO 'Departamentu_burua';
GRANT SELECT ON DB_Sprotify.Audio TO 'Departamentu_burua';
GRANT SELECT ON DB_Sprotify.Abestia TO 'Departamentu_burua';
GRANT SELECT ON DB_Sprotify.Album TO 'Departamentu_burua';
GRANT SELECT ON DB_Sprotify.Podcast TO 'Departamentu_burua';

GRANT INSERT, SELECT, UPDATE ON DB_Sprotify.Hizkuntza TO 'Langilea';
GRANT INSERT, SELECT, UPDATE ON DB_Sprotify.Musikaria TO 'Langilea';
GRANT INSERT, SELECT, UPDATE ON DB_Sprotify.Podcaster TO 'Langilea';
GRANT INSERT, SELECT, UPDATE ON DB_Sprotify.Audio TO 'Langilea';
GRANT INSERT, SELECT, UPDATE ON DB_Sprotify.Abestia TO 'Langilea';
GRANT INSERT, SELECT, UPDATE ON DB_Sprotify.Album TO 'Langilea';
GRANT INSERT, SELECT, UPDATE ON DB_Sprotify.Podcast TO 'Langilea';

GRANT INSERT, SELECT, UPDATE ON DB_Sprotify.Bezeroa TO 'Bezeroa';
GRANT INSERT, SELECT, DELETE ON DB_Sprotify.Playlist TO 'Bezeroa';
GRANT INSERT, SELECT ON DB_Sprotify.Premium TO 'Bezeroa';
GRANT INSERT, SELECT, DELETE ON DB_Sprotify.Gustokoak TO 'Bezeroa';
GRANT INSERT, SELECT, DELETE ON DB_Sprotify.Playlist_Abestiak TO 'Bezeroa';
GRANT SELECT ON DB_Sprotify.musikaDeskubritu TO 'Bezeroa';
GRANT SELECT ON DB_Sprotify.AlbumView TO 'Bezeroa';
GRANT SELECT ON DB_Sprotify.ikusiPlayListak TO 'Bezeroa';
GRANT SELECT ON DB_Sprotify.playListView TO 'Bezeroa';
GRANT SELECT ON DB_Sprotify.podcastDeskubritu TO 'Bezeroa';
GRANT SELECT ON DB_Sprotify.Audio TO 'Bezeroa';
GRANT SELECT ON DB_Sprotify.Musikaria TO 'Bezeroa';
GRANT SELECT ON DB_Sprotify.Podcast TO 'Bezeroa';
GRANT SELECT ON DB_Sprotify.Podcaster TO 'Bezeroa';
GRANT SELECT ON DB_Sprotify.Album TO 'Bezeroa';

FLUSH PRIVILEGES;



-- Users
drop USER if exists 'Admin'@'%';
CREATE USER if not exists 'Admin'@'%' IDENTIFIED BY 'Admin12345.';
GRANT 'Administratzailea' TO 'Admin'@'%';

drop USER if exists 'a'@'%';
CREATE USER if not exists 'a'@'%' IDENTIFIED BY 'a';
GRANT 'Administratzailea' TO 'a'@'%';

drop USER if exists 'Departamentua'@'%';
CREATE USER if not exists 'Departamentua'@'%' IDENTIFIED BY 'Depart12345.';
GRANT 'Departamentu_burua' TO 'Departamentua'@'%';

drop USER if exists 'Analist1'@'%';
CREATE USER if not exists 'Analist1'@'%' IDENTIFIED BY 'Analist12345.';
GRANT 'Analista' TO 'Analist1'@'%';

drop USER if exists 'Analist2'@'%';
CREATE USER if not exists 'Analist2'@'%' IDENTIFIED BY 'Analist12345.';
GRANT 'Analista' TO 'Analist2'@'%';

drop USER if exists 'Langile'@'%';
CREATE USER if not exists 'Langile'@'%' IDENTIFIED BY 'Lang12345.';
GRANT 'Langilea' TO 'Langile'@'%';

drop USER if exists 'Bezero'@'%';
CREATE USER if not exists 'Bezero'@'%' IDENTIFIED BY 'Bez12345.';
GRANT 'Bezeroa' TO 'Bezero'@'%';

drop USER if exists 'unai.souto'@'%';
CREATE USER if not exists 'unai.souto'@'%' IDENTIFIED BY 'Bez12345.';
GRANT 'Bezeroa' TO 'Bezero'@'%';
drop USER if exists 'iker.sanchez'@'%';
CREATE USER if not exists 'iker.sanchez'@'%' IDENTIFIED BY 'Bez12345.';
GRANT 'Bezeroa' TO 'Bezero'@'%';
drop USER if exists 'juan.perez'@'%';
CREATE USER if not exists 'juan.perez'@'%' IDENTIFIED BY 'Bez12345.';
GRANT 'Bezeroa' TO 'Bezero'@'%';
drop USER if exists 'maria.garcia'@'%';
CREATE USER if not exists 'maria.garcia'@'%' IDENTIFIED BY 'Bez12345.';
GRANT 'Bezeroa' TO 'Bezero'@'%';
drop USER if exists 'carlos.martinez'@'%';
CREATE USER if not exists 'carlos.martinez'@'%' IDENTIFIED BY 'Bez12345.';
GRANT 'Bezeroa' TO 'Bezero'@'%';
drop USER if exists 'clara.escudero'@'%';
CREATE USER if not exists 'clara.escudero'@'%' IDENTIFIED BY 'Bez12345.';
GRANT 'Bezeroa' TO 'Bezero'@'%';
drop USER if exists 'asier.martinez'@'%';
CREATE USER if not exists 'asier.martinez'@'%' IDENTIFIED BY 'Bez12345.';
GRANT 'Bezeroa' TO 'Bezero'@'%';
drop USER if exists 'miguel.perez'@'%';
CREATE USER if not exists 'miguel.perez'@'%' IDENTIFIED BY 'Bez12345.';
GRANT 'Bezeroa' TO 'Bezero'@'%';

FLUSH PRIVILEGES;
