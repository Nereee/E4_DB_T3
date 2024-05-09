use DB_Sprotify;

/*--------------Funtzioak--------------*/
DELIMITER //
drop function if exists hilabeteTraduktor;
CREATE FUNCTION hilabeteTraduktor(fecha DATE) RETURNS VARCHAR(20)
READS SQL DATA
BEGIN
    DECLARE hilabetea VARCHAR(20);
    
    IF MONTHNAME(fecha) = 'January' THEN SET hilabetea = 'urtarrila';
    ELSEIF MONTHNAME(fecha) = 'February' THEN SET hilabetea = 'otsaila';
    ELSEIF MONTHNAME(fecha) = 'March' THEN SET hilabetea = 'martxoa';
    ELSEIF MONTHNAME(fecha) = 'April' THEN SET hilabetea = 'apirila';
    ELSEIF MONTHNAME(fecha) like 'May' THEN SET hilabetea = 'maiatza';
    ELSEIF MONTHNAME(fecha) = 'June' THEN SET hilabetea = 'ekaina';
    ELSEIF MONTHNAME(fecha) = 'July' THEN SET hilabetea = 'uztaila';
    ELSEIF MONTHNAME(fecha) = 'August' THEN SET hilabetea = 'abuztua';
    ELSEIF MONTHNAME(fecha) = 'September' THEN SET hilabetea = 'iraila';
    ELSEIF MONTHNAME(fecha) = 'October' THEN SET hilabetea = 'urria';
    ELSEIF MONTHNAME(fecha) = 'November' THEN SET hilabetea = 'azaroa';
    ELSE SET hilabetea = 'abendua';
    END IF;
    
    RETURN hilabetea;
END;
//



/*--------------Trigerrak--------------*/
DELIMITER //
drop trigger if exists estadistikaEguna;
create trigger if not exists estadistikaEguna 
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

DELIMITER //
drop trigger if exists instertPremium;
CREATE TRIGGER instertPremium
AFTER INSERT ON Bezeroa
FOR EACH ROW
BEGIN
    IF NEW.Mota = 'Premium' THEN
        INSERT INTO Premium (ID_Bezeroa, Iraungitze_data)
        VALUES 
			(NEW.ID_Bezeroa, DATE_ADD(CURDATE(), INTERVAL 1 YEAR));
    END IF;
END 
//

DELIMITER //
drop trigger if exists updatePremium;
CREATE TRIGGER updatePremium
AFTER UPDATE ON Bezeroa
FOR EACH ROW
BEGIN
    IF OLD.Mota = 'Free' AND NEW.Mota = 'Premium' THEN
        INSERT INTO Premium (ID_Bezeroa, Iraungitze_data)
        VALUES (
            NEW.ID_Bezeroa,
            DATE_ADD(CURDATE(), INTERVAL 1 YEAR)
        );
    END IF;
END 
//



/*--------------Gertaerak--------------*/
SHOW events;

DELIMITER //
drop event if exists newRowsData;
create event if not exists newRowsData
ON SCHEDULE EVERY 1 DAY 
STARTS '2024-05-09 09:30:00' DO
INSERT INTO Erreprodukzio_Eguna (ID_Audio, Eguna, Erreprodukzio_Kop) 
VALUES 
('AU003', current_date(), 0),
('AU004', current_date(), 0),
('AU007', current_date(), 0),
('AU008', current_date(), 0);
//

DELIMITER //
drop event if exists avgHilabetero;
CREATE EVENT IF NOT EXISTS avgHilabetero
ON SCHEDULE EVERY 1 MONTH 
STARTS '2024-06-01 00:00:00' 
DO
BEGIN
    DECLARE abestiKop INT;
    DECLARE bukle INT;
    
    SET abestiKop = (SELECT COUNT(ID_Audio) FROM Audio WHERE mota = 'abestia');
    SET bukle = 0;
    
    WHILE abestiKop > bukle DO
        INSERT INTO Erreprodukzio_Hilabete (ID_Audio, Hilabetea, Erreprodukzio_Kop)
        VALUES (
            (SELECT ID_Audio FROM Audio WHERE mota = 'abestia' LIMIT 1 OFFSET bukle),
            
            (SELECT MONTHNAME(Eguna) FROM Erreprodukzio_Eguna WHERE ID_Audio = 
                (SELECT ID_Audio FROM Audio WHERE mota = 'abestia' LIMIT 1 OFFSET bukle) 
             ORDER BY Eguna DESC LIMIT 1),
             
            (SELECT SUM(Erreprodukzio_Kop) FROM Erreprodukzio_Eguna WHERE ID_Audio = 
                (SELECT ID_Audio FROM Audio WHERE mota = 'abestia' LIMIT 1 OFFSET bukle) 
             AND MONTHNAME(Eguna) = 
                (SELECT MONTHNAME(Eguna) FROM Erreprodukzio_Eguna 
                 WHERE ID_Audio = (SELECT ID_Audio FROM Audio WHERE mota = 'abestia' LIMIT 1 OFFSET bukle)
                 ORDER BY Eguna DESC LIMIT 1))
        );
        SET bukle = bukle + 1;
    END WHILE;
    
END 
//

DELIMITER //
drop event if exists avgUrtero;
CREATE EVENT IF NOT EXISTS avgUrtero
ON SCHEDULE EVERY 1 year 
STARTS '2025-01-01 00:00:00' 
DO
BEGIN
    INSERT INTO Erreprodukzio_Urtea (ID_Audio, Urtea, Erreprodukzio_Kop)
    SELECT ID_Audio, YEAR(CURDATE()) -1, SUM(Erreprodukzio_Kop) AS Total_Reproducciones 
    FROM Erreprodukzio_Eguna
    WHERE YEAR(Eguna) = YEAR(CURDATE()) - 1
    GROUP BY ID_Audio;
END 
//


