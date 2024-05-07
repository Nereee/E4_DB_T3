use DB_Sprotify;

DELIMITER //
drop trigger if exists estadistika;
create trigger estadistika 
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
drop event if exists newRowsData;
create event newRowsData
ON SCHEDULE EVERY 1 DAY 
STARTS '2024-05-08 09:30:00' DO
INSERT INTO Erreprodukzio_Eguna (ID_Audio, Eguna, Erreprodukzio_Kop) 
VALUES 
('AU003', current_date(), 0),
('AU004', current_date(), 0),
('AU007', current_date(), 0),
('AU008', current_date(), 0);
//