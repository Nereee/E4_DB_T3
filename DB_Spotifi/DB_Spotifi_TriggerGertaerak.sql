use DB_Sprotify;


/*--------------Trigerrak--------------*/
DELIMITER //
drop trigger if exists instertPremium//
CREATE TRIGGER instertPremium
AFTER INSERT ON Bezeroa
FOR EACH ROW
BEGIN
    IF NEW.Mota = 'Premium' THEN
        INSERT INTO Premium (ID_Bezeroa, Iraungitze_data)
        VALUES 
			(NEW.ID_Bezeroa, DATE_ADD(current_date(), INTERVAL 1 YEAR));
    END IF;
END 
//

DELIMITER //
drop trigger if exists updatePremium//
CREATE TRIGGER updatePremium
AFTER UPDATE ON Bezeroa
FOR EACH ROW
BEGIN
    IF OLD.Mota = 'Free' AND NEW.Mota = 'Premium' THEN
        INSERT INTO Premium (ID_Bezeroa, Iraungitze_data)
        VALUES (
            NEW.ID_Bezeroa,
            DATE_ADD(current_date(), INTERVAL 1 YEAR)
        );
    END IF;
END 
//

DELIMITER //
drop trigger if exists estadistikaEguna//
create trigger estadistikaEguna 
after insert on Erreprodukzioak
for each row
begin
	declare valueKop long;
    set valueKop = (select Erreprodukzio_Kop from Erreprodukzio_Eguna where ID_audio = (select ID_audio from Erreprodukzioak where ID_audio = new.ID_audio limit 1) and Eguna = (select fecha from Erreprodukzioak where fecha = new.Fecha limit 1) limit 1) + 1;
    update Erreprodukzio_Eguna 
    set Erreprodukzio_Kop = valueKop 
    where ID_audio = (select ID_audio from Erreprodukzioak where ID_audio = new.ID_audio limit 1) and Eguna = (select fecha from Erreprodukzioak where fecha = new.Fecha limit 1);
end;
//


/*--------------Gertaerak--------------*/
SHOW events;

DELIMITER //
drop event if exists newRowsData//
create event if not exists newRowsData
ON SCHEDULE EVERY 1 DAY 
STARTS '2024-05-14 09:15:00' DO
begin
	call instertNewEgunaCaller();
end
//

DELIMITER //
DROP EVENT IF EXISTS updateMonthlyReproductions//
CREATE EVENT updateMonthlyReproductions
ON SCHEDULE EVERY 1 MONTH
STARTS '2024-06-01 00:00:00' 
DO
BEGIN
    DECLARE last_month_start DATE;
    DECLARE last_month_end DATE;

    SET last_month_start = DATE_SUB(LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH), INTERVAL DAY(LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH)) - 1 DAY);
    SET last_month_end = LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH);

    INSERT INTO Erreprodukzio_Hilabete (ID_Audio, Hilabetea, Erreprodukzio_Kop)
    SELECT ID_Audio, last_month_start, SUM(Erreprodukzio_Kop)
    FROM Erreprodukzio_Eguna
    WHERE Eguna BETWEEN last_month_start AND last_month_end
    GROUP BY ID_Audio
    ON DUPLICATE KEY UPDATE Erreprodukzio_Kop = VALUES(Erreprodukzio_Kop);
END 
//

DELIMITER //
drop event if exists avgUrtero//
CREATE EVENT avgUrtero
ON SCHEDULE EVERY 1 year 
STARTS '2025-01-01 00:00:00' 
DO
BEGIN
    INSERT INTO Erreprodukzio_Urtea (ID_Audio, Urtea, Erreprodukzio_Kop)
    SELECT ID_Audio, YEAR(CURRENT_DATE()) -1, SUM(Erreprodukzio_Kop)
    FROM Erreprodukzio_Eguna
    WHERE YEAR(Eguna) = YEAR(CURRENT_DATE()) - 1
    GROUP BY ID_Audio;
END 
//

DELIMITER //
DROP EVENT IF EXISTS avgEstaditikak//
CREATE EVENT avgEstaditikak
ON SCHEDULE EVERY 1 DAY 
STARTS '2024-05-14 09:10:00' 
DO
BEGIN
    DECLARE current_month INT;
    DECLARE current_year INT;

    SET current_month = MONTH(CURRENT_TIMESTAMP);
    SET current_year = YEAR(CURRENT_TIMESTAMP);

    IF DAY(CURRENT_TIMESTAMP) = 1 THEN
        CALL insertEstadistikak(2); -- Nuevo año, pasa 2
    ELSEIF current_month != (SELECT MONTH(MAX(Eguna)) FROM Erreprodukzio_Eguna) THEN
        CALL insertEstadistikak(1); -- Nuevo mes, pasa 1
    ELSE
        CALL insertEstadistikak(0); -- Día normal, pasa 0
    END IF;
END 
//



