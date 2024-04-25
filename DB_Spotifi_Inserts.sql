use DB_Sprotify;

-- kk user
INSERT INTO Bezeroa (Izen, Abizena, Hizkuntza, Erabiltzailea, Pasahitza, Jaiotze_data, Erregistro_data, Mota) 
VALUES 
('a', 'a', 'EN', 'a', 'a', '1990-05-15', '2023-01-01', 'Free');
--

INSERT INTO Musikaria (ID_Musikaria, Izen_Artistikoa, Ezaugarria, Deskribapena) 
VALUES 
('MU001', 'Estopa', 'Taldea','aaaaa'),
('MU002', 'Shakira', 'Bakarlaria','bbbbb'),
('MU003', 'Ed Sheeran', 'Bakarlaria','ccccc'),
('MU004', 'Kurt Cobain', 'Bakarlaria','ddddd');

INSERT INTO Podcaster (ID_Podcaster, Izen_Artistikoa) 
VALUES 
('PO001', 'The Wild Proyect'),
('PO002', 'Sin Miedo Al Exito'),
('PO003', 'Tengo un Plan');

INSERT INTO Audio (ID_Audio, Izena, Iraupena, Mota) 
VALUES 
('AU001', 'The Wild Proyect Podcast #1', 60, 'Podcast'),
('AU002', 'The Wild Proyect Podcast #2', 45, 'Podcast'),
('AU003', 'Como Camaron', 180, 'Abestia'),
('AU004', 'Me falta el Aliento', 210, 'Abestia'),
('AU005', 'The Wild Proyect Podcast #3', 55, 'Podcast'),
('AU006', 'The Wild Proyect Podcast #4', 50, 'Podcast'),
('AU007', 'Suerte', 160, 'Abestia'),
('AU008', 'Waka Waka', 200, 'Abestia'),
('AU009', 'Sin Miedo Al Exito #1', 40, 'Podcast'),
('AU010', 'Sin Miedo Al Exito #2', 70, 'Podcast');

INSERT INTO Hizkuntza (ID_Hizkuntza, Deskribapena) 
VALUES 
('ES', 'Spanish'),
('EN', 'English'),
('EU', 'Basque'),
('FR', 'French'),
('DE', 'German'),
('CA', 'Catalan'),
('GA', 'Galician'),
('AR', 'Arabic');

INSERT INTO Bezeroa (Izen, Abizena, Hizkuntza, Erabiltzailea, Pasahitza, Jaiotze_data, Erregistro_data, Mota) 
VALUES 
('John', 'Doe', 'EN', 'john_doe', '$2a$10$u.U5anZzcNi5VRXyRgmr7.xmTclHT4LvDSFw.jKiAMvpVbmUu59eG', '1990-05-15', '2023-01-01', 'Free'),
('Jane', 'Smith', 'EN', 'jane_smith', '$2a$10$u.U5anZzcNi5VRXyRgmr7.xmTclHT4LvDSFw.jKiAMvpVbmUu59eG', '1992-08-20', '2023-01-02', 'Premium'),
('Alice', 'Johnson', 'EN', 'alice_johnson', '$2a$10$u.U5anZzcNi5VRXyRgmr7.xmTclHT4LvDSFw.jKiAMvpVbmUu59eG', '1985-12-10', '2023-01-03', 'Free'),
('Bob', 'Brown', 'EN', 'bob_brown', '$2a$10$u.U5anZzcNi5VRXyRgmr7.xmTclHT4LvDSFw.jKiAMvpVbmUu59eG', '1988-04-25', '2023-01-04', 'Premium'),
('Charlie', 'Wilson', 'EN', 'charlie_wilson', '$2a$10$u.U5anZzcNi5VRXyRgmr7.xmTclHT4LvDSFw.jKiAMvpVbmUu59eG', '1995-09-30', '2023-01-05', 'Free'),
('Emma', 'Martinez', 'ES', 'emma_martinez', '$2a$10$u.U5anZzcNi5VRXyRgmr7.xmTclHT4LvDSFw.jKiAMvpVbmUu59eG', '1998-02-18', '2023-01-06', 'Free'),
('Michael', 'Garcia', 'ES', 'michael_garcia', '$2a$10$u.U5anZzcNi5VRXyRgmr7.xmTclHT4LvDSFw.jKiAMvpVbmUu59eG', '1993-07-22', '2023-01-07', 'Free'),
('Olivia', 'Lopez', 'ES', 'olivia_lopez', '$2a$10$u.U5anZzcNi5VRXyRgmr7.xmTclHT4LvDSFw.jKiAMvpVbmUu59eG', '1987-11-12', '2023-01-08', 'Free'),
('David', 'Rodriguez', 'ES', 'david_rodriguez', '$2a$10$u.U5anZzcNi5VRXyRgmr7.xmTclHT4LvDSFw.jKiAMvpVbmUu59eG', '1980-03-08', '2023-01-09', 'Free'),
('Sophia', 'Fernandez', 'ES', 'sophia_fernandez', '$2a$10$u.U5anZzcNi5VRXyRgmr7.xmTclHT4LvDSFw.jKiAMvpVbmUu59eG', '1976-06-28', '2023-01-10', 'Free');


INSERT INTO Podcast (ID_Audio, Kolaboratzaileak, ID_Podcaster) 
VALUES 
('AU001', 'Guest 1, Guest 2', 'PO001'),
('AU002', 'Guest 3, Guest 4', 'PO001'),
('AU005', 'Guest 5, Guest 6', 'PO001'),
('AU006', 'Guest 7, Guest 8', 'PO001'),
('AU009', 'Guest 5, Guest 6', 'PO002'),
('AU010', 'Guest 7, Guest 8', 'PO002');

INSERT INTO Album (ID_Album, Izenburua, Urtea, Generoa, ID_Musikaria) 
VALUES 
('AL001', 'Album 1', '2023-01-01', 'Pop', 'MU001'),
('AL002', 'Album 2', '2023-01-01', 'Rock', 'MU002');

INSERT INTO Abestia (ID_Audio, ID_Album) 
VALUES 
('AU003', 'AL001'),
('AU004', 'AL001'),
('AU007', 'AL002'),
('AU008', 'AL002');

INSERT INTO Playlist (ID_List, Izenburua, Sorrera_data, ID_Bezeroa) 
VALUES 
('PL001', 'Playlist 1', '2023-01-01', '1'),
('PL002', 'Playlist 2', '2023-01-02', '2'),
('PL003', 'Playlist 3', '2023-01-03', '3'),
('PL004', 'Playlist 4', '2023-01-04', '4'),
('PL005', 'Playlist 5', '2023-01-05', '5'),
('PL006', 'Playlist 6', '2023-01-06', '6'),
('PL007', 'Playlist 7', '2023-01-07', '7'),
('PL008', 'Playlist 8', '2023-01-08', '8'),
('PL009', 'Playlist 9', '2023-01-09', '9'),
('PL010', 'Playlist 10', '2023-01-10', '10');


INSERT INTO Playlist_Abestiak (ID_Audio, ID_List)
VALUES
('AU003', 'PL003'),
('AU004', 'PL004'),
('AU007', 'PL004'),
('AU008', 'PL008');


INSERT INTO Premium (ID_Bezeroa, Iraungitze_data) 
VALUES 
('2', '2024-01-01'),
('4', '2024-01-01');

INSERT INTO Gustokoak (ID_Bezeroa, ID_Audio) 
VALUES 
('1', 'AU001'),
('1', 'AU002'),
('2', 'AU003'),
('2', 'AU004'),
('3', 'AU005'),
('3', 'AU006'),
('4', 'AU007'),
('4', 'AU008'),
('5', 'AU009'),
('5', 'AU010');

-- Sample data for Erreprodukzioak table
INSERT INTO Erreprodukzioak (ID_Bezeroa, ID_Audio, Fecha) 
VALUES 
('1', 'AU001', '2023-01-01'),
('1', 'AU002', '2023-01-02'),
('2', 'AU003', '2023-01-03'),
('2', 'AU004', '2023-01-04'),
('3', 'AU005', '2023-01-05'),
('3', 'AU006', '2023-01-06'),
('4', 'AU007', '2023-01-07'),
('4', 'AU008', '2023-01-08'),
('5', 'AU009', '2023-01-09'),
('5', 'AU010', '2023-01-10');

-- Sample data for Estadistikak table
INSERT INTO Estadistikak (ID_Audio, KeyFigure1, KeyFigure2, KeyFigure3, KeyFigure4) 
VALUES 
('AU001', '1', '2', '3', '4'),
('AU002', '2', '3', '4', '5'),
('AU003', '3', '4', '5', '6'),
('AU004', '4', '5', '6', '7'),
('AU005', '5', '6', '7', '8'),
('AU006', '6', '7', '8', '9'),
('AU007', '7', '8', '9', '1'),
('AU008', '8', '9', '1', '2'),
('AU009', '9', '1', '2', '3'),
('AU010', '1', '2', '3', '4');


