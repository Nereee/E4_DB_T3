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
		((SELECT ID_Audio FROM Audio WHERE mota = 'abestia' LIMIT 1 OFFSET bukle), '2024-05-06', 0);
		SET bukle = bukle + 1;
    END WHILE;
END;
//

