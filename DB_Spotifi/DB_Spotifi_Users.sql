USE DB_Sprotify;

-- Rolak
-- Administratzaile rolaren sortzea edo berria ezartzea
DROP ROLE IF EXISTS 'Administratzailea';
CREATE ROLE IF NOT EXISTS 'Administratzailea';

-- Analista rolaren sortzea edo berria ezartzea
DROP ROLE IF EXISTS 'Analista';
CREATE ROLE IF NOT EXISTS 'Analista';

-- Departamentu buruaren rolaren sortzea edo berria ezartzea
DROP ROLE IF EXISTS 'Departamentu_burua';
CREATE ROLE IF NOT EXISTS 'Departamentu_burua';

-- Langilearen rolaren sortzea edo berria ezartzea
DROP ROLE IF EXISTS 'Langilea';
CREATE ROLE IF NOT EXISTS 'Langilea';

-- Bezeroaren rolaren sortzea edo berria ezartzea
DROP ROLE IF EXISTS 'Bezeroa';
CREATE ROLE IF NOT EXISTS 'Bezeroa';

-- Rolei pribilegioak
-- Administratzaileari DB_Sprotify zerbitzariaren guztiak ematea
GRANT ALL PRIVILEGES ON DB_Sprotify.* TO 'Administratzailea';

-- Analistari DB_Sprotify zerbitzariaren hautatuak ematea
GRANT SELECT ON DB_Sprotify.* TO 'Analista';

-- Departamentu buruari DB_Sprotify zerbitzariaren taulak hautatuak ematea
GRANT SELECT ON DB_Sprotify.Hizkuntza TO 'Departamentu_burua';
GRANT SELECT ON DB_Sprotify.Musikaria TO 'Departamentu_burua';
GRANT SELECT ON DB_Sprotify.Podcaster TO 'Departamentu_burua';
GRANT SELECT ON DB_Sprotify.Audio TO 'Departamentu_burua';
GRANT SELECT ON DB_Sprotify.Abestia TO 'Departamentu_burua';
GRANT SELECT ON DB_Sprotify.Album TO 'Departamentu_burua';
GRANT SELECT ON DB_Sprotify.Podcast TO 'Departamentu_burua';

-- Langileari DB_Sprotify zerbitzariaren taulak sortzea, gehitzea eta eguneratzea ematea
GRANT INSERT, SELECT, UPDATE ON DB_Sprotify.Hizkuntza TO 'Langilea';
GRANT INSERT, SELECT, UPDATE ON DB_Sprotify.Musikaria TO 'Langilea';
GRANT INSERT, SELECT, UPDATE ON DB_Sprotify.Podcaster TO 'Langilea';
GRANT INSERT, SELECT, UPDATE ON DB_Sprotify.Audio TO 'Langilea';
GRANT INSERT, SELECT, UPDATE ON DB_Sprotify.Abestia TO 'Langilea';
GRANT INSERT, SELECT, UPDATE ON DB_Sprotify.Album TO 'Langilea';
GRANT INSERT, SELECT, UPDATE ON DB_Sprotify.Podcast TO 'Langilea';

-- Bezeroari DB_Sprotify zerbitzariaren taulak sortzea, gehitzea eta ezabatzea ematea
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

-- Erabiltzaileak
-- Admin erabiltzailea sortzea edo berria ezartzea
DROP USER IF EXISTS 'Admin'@'%';
CREATE USER IF NOT EXISTS 'Admin'@'%' IDENTIFIED BY 'Admin12345.';
GRANT 'Administratzailea' TO 'Admin'@'%';

-- a erabiltzailea sortzea edo berria ezartzea
DROP USER IF EXISTS 'a'@'%';
CREATE USER IF NOT EXISTS 'a'@'%' IDENTIFIED BY 'a';
GRANT 'Administratzailea' TO 'a'@'%';

-- Departamentua erabiltzailea sortzea edo berria ezartzea
DROP USER IF EXISTS 'Departamentua'@'%';
CREATE USER IF NOT EXISTS 'Departamentua'@'%' IDENTIFIED BY 'Depart12345.';
GRANT 'Departamentu_burua' TO 'Departamentua'@'%';

-- Analist1 erabiltzailea sortzea edo berria ezartzea
DROP USER IF EXISTS 'Analist1'@'%';
CREATE USER IF NOT EXISTS 'Analist1'@'%' IDENTIFIED BY 'Analist12345.';
GRANT 'Analista' TO 'Analist1'@'%';

-- Analist2 erabiltzailea sortzea edo berria ezartzea
DROP USER IF EXISTS 'Analist2'@'%';
CREATE USER IF NOT EXISTS 'Analist2'@'%' IDENTIFIED BY 'Analist12345.';
GRANT 'Analista' TO 'Analist2'@'%';

-- Langile erabiltzailea sortzea edo berria ezartzea
DROP USER IF EXISTS 'Langile'@'%';
CREATE USER IF NOT EXISTS 'Langile'@'%' IDENTIFIED BY 'Lang12345.';
GRANT 'Langilea' TO 'Langile'@'%';

-- Bezero erabiltzailea sortzea edo berria ezartzea
DROP USER IF EXISTS 'Bezero'@'%';
CREATE USER IF NOT EXISTS 'Bezero'@'%' IDENTIFIED BY 'Bez12345.';
GRANT 'Bezeroa' TO 'Bezero'@'%';

-- Bezero erabiltzailea sortzea edo berria ezartzea
DROP USER IF EXISTS 'unai.souto'@'%';
CREATE USER IF NOT EXISTS 'unai.souto'@'%' IDENTIFIED BY 'Bez12345.';
GRANT 'Bezeroa' TO 'unai.souto'@'%';

-- Bezero erabiltzailea sortzea edo berria ezartzea
DROP USER IF EXISTS 'iker.sanchez'@'%';
CREATE USER IF NOT EXISTS 'iker.sanchez'@'%' IDENTIFIED BY 'Bez12345.';
GRANT 'Bezeroa' TO 'iker.sanchez'@'%';

-- Bezero erabiltzailea sortzea edo berria ezartzea
DROP USER IF EXISTS 'juan.perez'@'%';
CREATE USER IF NOT EXISTS 'juan.perez'@'%' IDENTIFIED BY 'Bez12345.';
GRANT 'Bezeroa' TO 'juan.perez'@'%';

-- Bezero erabiltzailea sortzea edo berria ezartzea
DROP USER IF EXISTS 'maria.garcia'@'%';
CREATE USER IF NOT EXISTS 'maria.garcia'@'%' IDENTIFIED BY 'Bez12345.';
GRANT 'Bezeroa' TO 'maria.garcia'@'%';

-- Bezero erabiltzailea sortzea edo berria ezartzea
DROP USER IF EXISTS 'carlos.martinez'@'%';
CREATE USER IF NOT EXISTS 'carlos.martinez'@'%' IDENTIFIED BY 'Bez12345.';
GRANT 'Bezeroa' TO 'carlos.martinez'@'%';

-- Bezero erabiltzailea sortzea edo berria ezartzea
DROP USER IF EXISTS 'clara.escudero'@'%';
CREATE USER IF NOT EXISTS 'clara.escudero'@'%' IDENTIFIED BY 'Bez12345.';
GRANT 'Bezeroa' TO 'clara.escudero'@'%';

-- Bezero erabiltzailea sortzea edo berria ezartzea
DROP USER IF EXISTS 'asier.martinez'@'%';
CREATE USER IF NOT EXISTS 'asier.martinez'@'%' IDENTIFIED BY 'Bez12345.';
GRANT 'Bezeroa' TO 'asier.martinez'@'%';

-- Bezero erabiltzailea sortzea edo berria ezartzea
DROP USER IF EXISTS 'miguel.perez'@'%';
CREATE USER IF NOT EXISTS 'miguel.perez'@'%' IDENTIFIED BY 'Bez12345.';
GRANT 'Bezeroa' TO 'miguel.perez'@'%';

FLUSH PRIVILEGES;

