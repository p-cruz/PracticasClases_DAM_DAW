create or replace trigger tNoJefes 
before delete or update of dir
on emple
for each row
DECLARE
    directores number;
begin
    select count(dir) into directores 
        from emple 
        where depart_no=:old.depart_no;

    if deleting then
        If directores=1 and :old.dir IS NOT NULL then
            raise_application_error(-20000, 'No puedes borrar el ultimo director de un departamento si es el unico empleado de ese departamento');
        end if;
    elsif updating then
        If directores=1 and :new.dir IS NULL and :old.dir IS NOT NULL then
            raise_application_error(-20000, 'No puedes quitar el ultimo director que queda');
        end if;
    end if;
end;
/


CREATE OR REPLACE TRIGGER NuncaSinJefe
      FOR delete or update of dir 
      ON emple
      COMPOUND TRIGGER
      TYPE TDatos1 is record (depart_no number, cantidadJefes number(2));
      TYPE TCantidadJefes is table of TDatos1;
      cJefesPorDep TCantidadJefes;
      i number:=1;
      nDep number;
    --Ejecuci
      BEFORE STATEMENT IS
     BEGIN
      select depart_no, count(dir)
              BULK COLLECT into cJefesPorDep
              from emple
              group by depart_no
              ORDER BY DEPART_NO;
      select count(distinct depart_no) into nDep
	        from emple;
     END BEFORE STATEMENT;
   -- Ejecuci
    BEFORE EACH ROW IS
    BEGIN
        i:=1;
        loop
            dbms_output.put_line('departamento del empleado a eliminar o modificar:'||:old.depart_no ||' jefe: '||:old.dir);
            dbms_output.put_line('departamento: '||cJefesPorDep(i).depart_no||' jefes: '||cJefesPorDep(i).cantidadJefes);
            if (cJefesPorDep(i).depart_no=:old.depart_no) THEN  
                dbms_output.put_line('estamos en el departamento del empleado que se quiere borrar o modificar su dir: '||:old.depart_no);
                if deleting then
                    if (cJefesPorDep(i).cantidadJefes=1 and :old.dir is not NULL) then
                        dbms_output.put_line('lanzamos el error');
                        raise_application_error(-20003, 'solo hay un jefe en este departamento, y es el que quieres borrar. No se puede quedar el departamento sin jefes');
                    elsif (:old.dir is not NULL) then
                        cJefesPorDep(i).cantidadJefes:=cJefesPorDep(i).cantidadJefes-1;
                    end if;
                elsif updating('dir') then
                    dbms_output.put_line(':new.dir: '||:new.dir||' :old.dir: '||:old.dir);
                    if (cJefesPorDep(i).cantidadJefes=1 and :new.dir is NULL and :old.dir is not NULL) then
                        dbms_output.put_line('lanzamos el error');
                        raise_application_error(-20003, 'solo hay un jefe en este departamento, y es el que quieres borrar. No se puede quedar el departamento sin jefes');
                    elsif (:new.dir is NULL and :old.dir is not NULL) THEN
                        cJefesPorDep(i).cantidadJefes:=cJefesPorDep(i).cantidadJefes-1;
                    end if;
                end if;
            end if;
            i:=i+1;
            if (i>nDep) then --se han terminado de analizar los distintos departamentos
                exit ;
            end if;
        end loop;
     END BEFORE EACH ROW;
   -- Ejecuci
     AFTER EACH ROW IS
     BEGIN
     NULL;
     END AFTER EACH ROW;
   --Ejecuci
     AFTER STATEMENT IS
     BEGIN
     NULL;
     END AFTER STATEMENT;
  END;
/ 
