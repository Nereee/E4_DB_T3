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
STARTS '2024-05-10 10:00:00' DO
begin
	call instertNewEgunaCaller();
end
//

select * from information_schema.events;

show processlist;

SET GLOBAL event_scheduler = ON;

show warnings;

DELIMITER //
drop event if exists avgHilabetero//
CREATE EVENT avgHilabetero
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
             
            (SELECT ID_Audio, MONTHNAME(Eguna), SUM(Erreprodukzio_Kop) FROM Erreprodukzio_Eguna WHERE ID_Audio = 
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
drop event if exists avgUrtero//
CREATE EVENT avgUrtero
ON SCHEDULE EVERY 1 year 
STARTS '2025-01-01 00:00:00' 
DO
BEGIN
    INSERT INTO Erreprodukzio_Urtea (ID_Audio, Urtea, Erreprodukzio_Kop)
    SELECT ID_Audio, YEAR(CURRENT_DATE()) -1, SUM(Erreprodukzio_Kop) AS Total_Reproducciones 
    FROM Erreprodukzio_Eguna
    WHERE YEAR(Eguna) = YEAR(CURRENT_DATE()) - 1
    GROUP BY ID_Audio;
END 
//


