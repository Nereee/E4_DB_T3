drop database if exists DB_Spotify;
drop database if exists DB_Sprotify;

create database if not exists DB_Sprotify
collate utf8mb4_spanish_ci;

use DB_Sprotify;

-- Taulak 

create table Musikaria(
ID_Musikaria char(5),
Izen_Artistikoa varchar(20) not null,
Irudia blob,
Ezaugarria enum("Bakarlaria", "Taldea") not null,
Deskribapena varchar(200) not null,
primary key(ID_Musikaria),
unique(Izen_Artistikoa)
);

create table Podcaster(
ID_Podcaster char(5),
Izen_Artistikoa varchar(20) not null,
Irudia blob,
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
Irudia blob,
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
KeyFigure1 varchar(1), 
KeyFigure2 varchar(1),
KeyFigure3 varchar(1),
KeyFigure4 varchar(1),
primary key(ID_Audio)
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
constraint FK_EstadistikakAudio foreign key (ID_Audio) references Audio (ID_Audio) on update cascade on delete cascade;
