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





