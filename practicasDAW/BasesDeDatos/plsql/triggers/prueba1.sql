CREATE OR REPLACE TRIGGER TR1
    before DELETE ON Depart
    FOR EACH ROW
DECLARE
    -- local variables 
BEGIN
    -- dbms_output.put_line('Departamento borrado');
    raise_application_error(-20500, 'No se puede borrar departamentos')
END;
/
