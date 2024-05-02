CREATE OR REPLACE TRIGGER noBorrarJefes
  FOR DELETE or UPDATE of dir 
  ON emple 
  COMPOUND TRIGGER
	TYPE TJefes  IS TABLE OF emple.dir%type;
 	Jefes TJefes; 
   	n number;
  	i number:=1;

 BEFORE STATEMENT IS
  BEGIN
  	select UNIQUE dir 
		BULK COLLECT into Jefes 
		from emple;
	select count(unique dir) into n
		from emple;
  END BEFORE STATEMENT;

-- Ejecución antes de cada fila, variables :NEW, :OLD son permitidas
  BEFORE EACH ROW IS
  BEGIN
     LOOP 
     	IF (Jefes(i)=:old.emple_no) THEN
		raise_application_error(-20000,'No puedes borrar un jefe');
		EXIT;
	END IF;
	if (i>n) then
		exit;
	end if;
	i:=i+1;
     END LOOP;
  END BEFORE EACH ROW;

-- Ejecución despues de cada fila, variables :NEW, :OLD son permitidas
  AFTER EACH ROW IS
  BEGIN
  NULL;
  END AFTER EACH ROW;

--Ejecución despues de una consulta DML
  AFTER STATEMENT IS
  BEGIN
  NULL;
  END AFTER STATEMENT;
END;