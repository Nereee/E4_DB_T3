USE DB_Sprotify;

/*--------------Trigerrak--------------*/

-- Bezeroaren insert bakoitzean Premium motaren arabera eguneratzen da
DELIMITER //
DROP TRIGGER IF EXISTS instertPremium//
CREATE TRIGGER instertPremium
AFTER INSERT ON Bezeroa
FOR EACH ROW
BEGIN
    IF NEW.Mota = 'Premium' THEN
        INSERT INTO Premium (ID_Bezeroa, Iraungitze_data)
        VALUES 
			(NEW.ID_Bezeroa, DATE_ADD(CURRENT_DATE(), INTERVAL 1 YEAR));
    END IF;
END //
DELIMITER ;

-- Bezeroaren eguneraketan Free-etik Premium-era pasatzen denean, Premiumren datuak eguneratu
DELIMITER //
DROP TRIGGER IF EXISTS updatePremium//
CREATE TRIGGER updatePremium
AFTER UPDATE ON Bezeroa
FOR EACH ROW
BEGIN
    IF OLD.Mota = 'Free' AND NEW.Mota = 'Premium' THEN
        INSERT INTO Premium (ID_Bezeroa, Iraungitze_data)
        VALUES (
            NEW.ID_Bezeroa,
            DATE_ADD(CURRENT_DATE(), INTERVAL 1 YEAR)
        );
    END IF;
END //
DELIMITER ;

-- Erreprodukzioak sartzeko trigerra
DELIMITER //
DROP TRIGGER IF EXISTS estadistikaEguna//
CREATE TRIGGER estadistikaEguna 
AFTER INSERT ON Erreprodukzioak
FOR EACH ROW
BEGIN
	-- Erreprodukzio kopurua eguneratzen da
	DECLARE valueKop LONG;
    SET valueKop = (SELECT Erreprodukzio_Kop FROM Erreprodukzio_Eguna WHERE ID_audio = (SELECT ID_audio FROM Erreprodukzioak WHERE ID_audio = NEW.ID_audio LIMIT 1) AND Eguna = (SELECT fecha FROM Erreprodukzioak WHERE fecha = NEW.Fecha LIMIT 1) LIMIT 1) + 1;
    UPDATE Erreprodukzio_Eguna 
    SET Erreprodukzio_Kop = valueKop 
    WHERE ID_audio = (SELECT ID_audio FROM Erreprodukzioak WHERE ID_audio = NEW.ID_audio LIMIT 1) AND Eguna = (SELECT fecha FROM Erreprodukzioak WHERE fecha = NEW.Fecha LIMIT 1);
END;
//
DELIMITER ;


/*--------------Gertaerak--------------*/

-- Gertaerak erakusteko
SHOW EVENTS;

-- Eguna bakoitzean erabiltzaileen datuak eguneratzen dira
DELIMITER //
DROP EVENT IF EXISTS newRowsData//
CREATE EVENT IF NOT EXISTS newRowsData
ON SCHEDULE EVERY 1 DAY 
STARTS '2024-05-14 09:15:00' DO
BEGIN
	CALL instertNewEgunaCaller();
END //
DELIMITER ;

-- Hilabetean behin, aurreko hilabeterako erreprodukzio kopurua eguneratzen da
DELIMITER //
DROP EVENT IF EXISTS updateMonthlyReproductions//
CREATE EVENT IF NOT EXISTS updateMonthlyReproductions
ON SCHEDULE EVERY 1 MONTH
STARTS '2024-06-01 00:00:00' 
DO
BEGIN
    DECLARE last_month_start DATE;
    DECLARE last_month_end DATE;

    SET last_month_start = DATE_SUB(LAST_DAY(CURRENT_DATE() - INTERVAL 1 MONTH), INTERVAL DAY(LAST_DAY(CURRENT_DATE() - INTERVAL 1 MONTH)) - 1 DAY);
    SET last_month_end = LAST_DAY(CURRENT_DATE() - INTERVAL 1 MONTH);

    INSERT INTO Erreprodukzio_Hilabete (ID_Audio, Hilabetea, Erreprodukzio_Kop)
    SELECT ID_Audio, last_month_start, SUM(Erreprodukzio_Kop)
    FROM Erreprodukzio_Eguna
    WHERE Eguna BETWEEN last_month_start AND last_month_end
    GROUP BY ID_Audio
    ON DUPLICATE KEY UPDATE Erreprodukzio_Kop = VALUES(Erreprodukzio_Kop);
END //
DELIMITER ;

-- Urte bakoitzean, aurreko urtean erreprodukzio kopurua eguneratzen da
DELIMITER //
DROP EVENT IF EXISTS avgUrtero//
CREATE EVENT IF NOT EXISTS avgUrtero
ON SCHEDULE EVERY 1 YEAR 
STARTS '2025-01-01 00:00:00' 
DO
BEGIN
    INSERT INTO Erreprodukzio_Urtea (ID_Audio, Urtea, Erreprodukzio_Kop)
    SELECT ID_Audio, YEAR(CURRENT_DATE()) - 1, SUM(Erreprodukzio_Kop)
    FROM Erreprodukzio_Eguna
    WHERE YEAR(Eguna) = YEAR(CURRENT_DATE()) - 1
    GROUP BY ID_Audio;
END //
DELIMITER ;

-- Egunero, estadistikak eguneratzen dira
DELIMITER //
DROP EVENT IF EXISTS avgEstaditikak//
CREATE EVENT IF NOT EXISTS avgEstaditikak
ON SCHEDULE EVERY 1 DAY 
STARTS '2024-05-14 09:10:00' 
DO
BEGIN
    DECLARE current_month INT;
    DECLARE current_year INT;

    SET current_month = MONTH(CURRENT_TIMESTAMP);
    SET current_year = YEAR(CURRENT_TIMESTAMP);

    IF DAY(CURRENT_TIMESTAMP) = 1 THEN
        CALL insertEstadistikak(2); -- Urte berria, 2 pasa
    ELSEIF current_month != (SELECT MONTH(MAX(Eguna)) FROM Erreprodukzio_Eguna) THEN
        CALL insertEstadistikak(1); -- Hilabete berria, 1 pasa
    ELSE
        CALL insertEstadistikak(0); -- Egun normala, 0 pasa
    END IF;
END //
DELIMITER ;
