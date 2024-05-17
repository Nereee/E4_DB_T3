use DB_Sprotify;


DELIMITER //
drop procedure if exists instertNewEgunaCaller//
CREATE procedure instertNewEgunaCaller()
BEGIN
    declare abestiKop bigint default 0;
    set abestiKop = (SELECT COUNT(ID_Audio) FROM Audio WHERE mota = 'abestia');
    call instertNewEguna(abestiKop);
END;
//

DELIMITER //
drop procedure if exists instertNewEguna//
CREATE procedure instertNewEguna(abestiKop INT)
BEGIN
    DECLARE bukle INT;
    SET bukle = 0;
    
    WHILE abestiKop > bukle DO
		INSERT INTO Erreprodukzio_Eguna (ID_Audio, Eguna, Erreprodukzio_Kop) 
		VALUES 
		((SELECT ID_Audio FROM Audio WHERE mota = 'abestia' LIMIT 1 OFFSET bukle), current_date, 0);
		SET bukle = bukle + 1;
    END WHILE;
END;
//

DELIMITER //
DROP PROCEDURE IF EXISTS insertEstadistikak//
CREATE PROCEDURE insertEstadistikak(indize INT)
BEGIN
    IF indize = 0 THEN
        INSERT INTO Estadistikak (ID_Audio, Erreprodukzio_Kop_Egunero) 
			SELECT ID_Audio, AVG(Erreprodukzio_Kop) AS Egunero 
			FROM Audio 
			JOIN Erreprodukzio_Eguna USING (ID_Audio) 
			GROUP BY ID_Audio
		ON DUPLICATE KEY UPDATE Erreprodukzio_Kop_Egunero = VALUES(Erreprodukzio_Kop_Egunero);
    ELSEIF indize = 1 THEN
        INSERT INTO Estadistikak (ID_Audio, Erreprodukzio_Kop_Egunero, Erreprodukzio_Kop_Hilabetero)
			SELECT ID_Audio, AVG(E.Erreprodukzio_Kop) AS Egunero, AVG(H.Erreprodukzio_Kop) AS Hilabetero 
			FROM Audio 
			JOIN Erreprodukzio_Eguna E USING (ID_Audio) JOIN Erreprodukzio_Hilabete H USING (ID_Audio)
			GROUP BY ID_Audio
		ON DUPLICATE KEY UPDATE Erreprodukzio_Kop_Egunero = VALUES(Erreprodukzio_Kop_Egunero), Erreprodukzio_Kop_Hilabetero = VALUES(Erreprodukzio_Kop_Hilabetero);
    ELSEIF indize = 2 THEN
        INSERT INTO Estadistikak (ID_Audio, Erreprodukzio_Kop_Egunero, Erreprodukzio_Kop_Hilabetero, Erreprodukzio_Kop_Urtero)
			SELECT ID_Audio, AVG(E.Erreprodukzio_Kop) AS Egunero, AVG(H.Erreprodukzio_Kop) AS Hilabetero, AVG(U.Erreprodukzio_Kop) AS Urtero 
			FROM Audio 
			JOIN Erreprodukzio_Eguna E USING (ID_Audio) JOIN Erreprodukzio_Hilabete H USING (ID_Audio) JOIN Erreprodukzio_Urtea U USING (ID_Audio)
			GROUP BY ID_Audio
		ON DUPLICATE KEY UPDATE Erreprodukzio_Kop_Egunero = VALUES(Erreprodukzio_Kop_Egunero), Erreprodukzio_Kop_Hilabetero = VALUES(Erreprodukzio_Kop_Hilabetero), Erreprodukzio_Kop_Urtero = VALUES(Erreprodukzio_Kop_Urtero);
    END IF;
END//

-- SALBUESPENAK --
# Salbuespen honek insert bat egiterakoan Bezero taulari ez edukitzea erabiltzaile izen berdina.
DELIMITER //
DROP PROCEDURE IF EXISTS insertErabiltzailea//
CREATE PROCEDURE insertErabiltzailea(
-- Bezero bat sortzeko datuak hartzen ditu
    IN e_izena VARCHAR(20),
    IN e_abizena VARCHAR(20),
    IN e_hizkuntza ENUM('ES', 'EU', 'EN', 'FR', 'DE', 'CA', 'GA', 'AR'),
    IN e_erabiltzailea VARCHAR(20),
    IN e_pasahitza VARCHAR(100),
    IN e_jaiotze_data DATE,
    IN e_erregistro_data DATE,
    IN e_mota ENUM('Free', 'Premium')
)
BEGIN
	-- deklaratzen dugu kondizioa gako unikoentzako (23000), kasu honetan, erabiltzaile izena berdina izatea
	DECLARE	usernameBerdina CONDITION FOR SQLSTATE '23000';
    
    -- Aurrekoa gertatzen bada, handler bat sortzen dugu errore mesua ateratzeko
    DECLARE CONTINUE HANDLER FOR usernameBerdina
    BEGIN
		SELECT 'Errorea. Erabiltzaile izena hartuta dago.';
    END;
    -- Erabiltzaile izena desberdina bada, insert-a egingo da problema barik.
    INSERT INTO Bezeroa (Izen, Abizena, Hizkuntza, Erabiltzailea, Pasahitza, Jaiotze_data, Erregistro_data, Mota)
    VALUES (e_izena, e_abizena, e_hizkuntza, e_erabiltzailea, e_pasahitza, e_jaiotze_data, e_erregistro_data, e_mota);
END;
//
CALL insertErabiltzailea('Juan', 'Pérez', 'AR', 'prueba', 'contraseña', '2000-01-01', '2024-05-14', 'Free');

# Hizkuntza bat ezabatzerakoan, Hizkuntza horrek Bezero batek badu, ezin izango da ezabatu.
DELIMITER //
DROP PROCEDURE IF EXISTS ezabatuHizkuntza//
CREATE PROCEDURE ezabatuHizkuntza(
    IN h_ID enum("ES", "EU", "EN", "FR", "DE", "CA", "GA", "AR")
)
BEGIN
    DECLARE fk_constraint_violation CONDITION FOR SQLSTATE '23000';

    DECLARE EXIT HANDLER FOR fk_constraint_violation
    BEGIN
        SELECT 'Errorea: ezin da hizkuntza ezabatu, beste taula batzuetan erlazionatutako erregistroak dituelako';
    END;

    DELETE FROM Hizkuntza WHERE ID_Hizkuntza = h_ID;
END;
//
call ezabatuHizkuntza("AR");




