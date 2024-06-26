drop database if exists DB_Spotify;
drop database if exists DB_Sprotify;

create database if not exists DB_Sprotify
collate utf8mb4_spanish_ci;

use DB_Sprotify;

-- Taulak 

create table Musikaria(
ID_Musikaria char(5),
Izen_Artistikoa varchar(20) not null,
Irudia longblob,
Ezaugarria enum("Bakarlaria", "Taldea") not null,
Deskribapena varchar(1000) not null default("Deskribapena"),
primary key(ID_Musikaria),
unique(Izen_Artistikoa)
);

create table Podcaster(
ID_Podcaster char(5),
Izen_Artistikoa varchar(20) not null,
Irudia longblob,
Deskribapena varchar(1000),
primary key(ID_Podcaster),
unique(Izen_Artistikoa)
);

create table Bezeroa(
ID_Bezeroa int auto_increment,
Izen varchar(20) not null,
Abizena varchar(20) not null,
Hizkuntza enum("ES", "EU", "EN", "FR", "DE", "CA", "GA", "AR") not null,
Erabiltzailea varchar(20) not null,
Pasahitza varchar(100) not null,
Jaiotze_data date not null,
Erregistro_data date not null,
Mota enum("Free", "Premium") not null,
primary key(ID_Bezeroa),
unique(Erabiltzailea)
);

create table Premium(
ID_Bezeroa int,
Iraungitze_data date not null,
primary key(ID_Bezeroa)
);

create table Hizkuntza(
ID_Hizkuntza enum("ES", "EU", "EN", "FR", "DE", "CA", "GA", "AR"),
Deskribapena varchar(100) not null,
primary key(ID_Hizkuntza)
);

create table Audio(
ID_Audio char(5),
Izena varchar(150) not null,
Iraupena int not null,
Irudia longblob,
Deskribapena varchar(1000) not null default "deskripziorik ez",
Mota enum("Podcast", "Abestia") not null,
primary key(ID_Audio)
);

create table Podcast(
ID_Audio char(5),
Kolaboratzaileak varchar(150) not null,
ID_Podcaster char(5) not null,
primary key(ID_Audio)
);

create table Abestia(
ID_Audio char(5),
ID_Album char(5) not null,
primary key(ID_Audio)
);

create table Album(
ID_Album char(5),
Izenburua varchar(20) not null,
Urtea date not null,
Generoa varchar(40) not null,
Irudia blob,
Deskripzioa varchar(200) not null,
ID_Musikaria char(5) not null,
primary key(ID_Album)
);

create table Playlist(
ID_List char(5),
Izenburua varchar(20) not null,
Sorrera_data date not null,
ID_Bezeroa int not null,
primary key(ID_List)
);

create table Playlist_Abestiak(
ID_List char(5),
ID_Audio char(5),
primary key(ID_List, ID_Audio)
);

create table Gustokoak(
ID_Bezeroa int,
ID_Audio char(5),
primary key(ID_Bezeroa, ID_Audio)
);

create table Erreprodukzioak(
ID_Erreprodukzioak int auto_increment,
ID_Bezeroa int,
ID_Audio char(5),
Fecha date not null,
primary key(ID_Erreprodukzioak)
);

create table Estadistikak(
ID_Audio char(5),
Erreprodukzio_Kop_Egunero long, 
Erreprodukzio_Kop_Hilabetero long,
Erreprodukzio_Kop_Urtero long,
primary key(ID_Audio)
);

create table Erreprodukzio_Eguna(
ID_Audio char(5),
Eguna date not null, 
Erreprodukzio_Kop long not null,
primary key(ID_Audio, Eguna)
);

create table Erreprodukzio_Hilabete(
ID_Audio char(5),
Hilabetea date not null, 
Erreprodukzio_Kop long not null,
primary key(ID_Audio, Hilabetea)
);

create table Erreprodukzio_Urtea(
ID_Audio char(5),
Urtea year not null, 
Erreprodukzio_Kop long not null,
primary key(ID_Audio, Urtea)
);


-- Foreing Key

alter table Podcast
add
constraint FK_PodcastAudio foreign key (ID_Audio) references Audio (ID_Audio) on update cascade on delete cascade,
add
constraint FK_PodcastPodcaster foreign key (ID_Podcaster) references Podcaster (ID_Podcaster) on update cascade on delete cascade;


alter table Abestia
add
constraint FK_AbestiaAudio foreign key (ID_Audio) references Audio (ID_Audio) on update cascade on delete cascade,
add
constraint FK_AbestiaAlbum foreign key (ID_Album) references Album (ID_Album) on update cascade on delete cascade;


alter table Album
add
constraint FK_AlbumMusikaria foreign key (ID_Musikaria) references Musikaria (ID_Musikaria) on update cascade on delete cascade;


alter table Playlist
add
constraint FK_PlayListBezeroa foreign key (ID_Bezeroa) references Bezeroa (ID_Bezeroa) on update cascade on delete cascade;


alter table Playlist_Abestiak
add
constraint FK_PlayListAbestiakPlayList foreign key (ID_List) references Playlist (ID_List) on update cascade on delete cascade,
add
constraint FK_PlayListAbestiakAudio foreign key (ID_Audio) references Abestia (ID_Audio) on update cascade on delete cascade;


alter table Bezeroa
add
constraint FK_BezeroaHizkuntza foreign key (Hizkuntza) references Hizkuntza (ID_Hizkuntza);


alter table Premium
add
constraint FK_PremiumBezeroa foreign key (ID_Bezeroa) references Bezeroa (ID_Bezeroa) on update cascade on delete cascade;


alter table Gustokoak
add
constraint FK_GustukoakBezeroa foreign key (ID_Bezeroa) references Bezeroa (ID_Bezeroa) on update cascade on delete cascade,
add
constraint FK_GustukoakAudio foreign key (ID_Audio) references Audio (ID_Audio) on update cascade on delete cascade;


alter table Erreprodukzioak
add
constraint FK_ErreprodukzioakBezeroa foreign key (ID_Bezeroa) references Bezeroa (ID_Bezeroa) on update cascade,
add
constraint FK_ErreprodukzioakAudio foreign key (ID_Audio) references Audio (ID_Audio) on update cascade;


alter table Estadistikak
add
constraint FK_EstadistikakAudio foreign key (ID_Audio) references Audio (ID_Audio) on update cascade,
add
constraint FK_EstadistikakEguna foreign key (ID_Audio) references Erreprodukzio_Eguna (ID_Audio) on update cascade,
add
constraint FK_EstadistikakHilabete foreign key (ID_Audio) references Erreprodukzio_Hilabete (ID_Audio) on update cascade,
add
constraint FK_EstadistikakUrtea foreign key (ID_Audio) references Erreprodukzio_Urtea (ID_Audio) on update cascade;




CREATE INDEX idx_erabiltzailea_bezeroa ON Bezeroa (Erabiltzailea);
CREATE INDEX idx_join_musika_album_abestia_audio_erreprodukzioak ON Musikaria (ID_Musikaria);
CREATE INDEX idx_id_list_playlist_abestiak ON Playlist_Abestiak (ID_List);
CREATE INDEX idx_join_podcaster_podcast_erreprodukzioak ON Podcaster (ID_Podcaster);
CREATE INDEX idx_id_album_abestia ON Abestia (ID_Album);
CREATE INDEX idx_join_album_abestia_audio ON Album (ID_Album);
CREATE INDEX idx_id_audio_podcast ON Podcast (ID_Audio);


