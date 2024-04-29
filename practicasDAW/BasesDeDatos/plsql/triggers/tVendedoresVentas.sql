create or replace procedure tVendedoresVentas
as
begin
   update emple set depart_no=30 where oficio='VENDEDOR';
   update emple set oficio='VENDEDOR' where depart_no=30;
   commit;
end;

CREATE OR REPLACE TRIGGER vendedoresEnVentas
           BEFORE INSERT OR UPDATE of oficio,depart_no
            ON emple
            FOR EACH ROW
        DECLARE
            dep emple.depart_no%type;
        BEGIN
              select depart_no into dep from depart where lower(dnombre)='ventas';
              if (lower(:new.oficio)='vendedor' and :new.depart_no!=dep) then
                  raise_application_error(-20000, 'Intentas insertar un VENDEDOR fuera del departamento de VENTAS');
              end if;
       	      IF (lower(:new.oficio)!='vendedor' and :new.depart_no=dep) then
                   raise_application_error(-20001,'En el departamento VENTAS no puede haber otros oficios que no sean VENDEDOR');
              end if;
        EXCEPTION
          when no_data_found then
              dbms_output.put_line('No existe el departamento VENTAS');
    END;
/
