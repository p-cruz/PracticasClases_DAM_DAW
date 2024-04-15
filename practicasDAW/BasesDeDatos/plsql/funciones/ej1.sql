create or replace function mayor(n1 in number, n2 in number) 
	return number is
begin
	if (n2>n1) then
		return n2;
	elsif (n1>n2) then
		return n1;
    else 
        dbms_output.put_line('Son iguales');
        return 0;
	end if;
end;



create or replace function cuentaEmpleados(dep in depart.depart_no%type) 
	return number 
    is
        numEmpleados number:=0;
    begin
	    select count(*) into numEmpleados from emple where depart_no=dep;
        return numEmpleados;
    end;


create or replace procedure insertaDep(nombre depart.dnombre%type, localidad depart.loc%type)
is
    numDepartamento depart.depart_no%type;
begin
    -- select max(depart_no)+10 into numDepartamento from depart;
    insert into depart values (25, nombre, localidad);
    dbms_output.put_line('REgistro insertado');
    EXCEPTION
        WHEN dup_val_on_index then
            dbms_output.put_line('Intento de insercion con clave duplicada');
end;
/