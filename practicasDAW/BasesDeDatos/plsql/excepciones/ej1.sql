set serveroutput on
create or replace procedure ej1excepciones (id IN emple.emple_no%type)
iS
	empleado emple%ROWTYPE;
begin
	select * into empleado from emple where emple_no=id; --no_data_found
	-- select * into empleado from emple; --too_many_rows
	update emple set salario = salario * 1.1 where emple_no=id;
exception
	when no_data_found then
				dbms_output.put_line('Empleado no encontrado');
	when too_many_rows then
				dbms_output.put_line('Devuelve varios empleados');
end;
/