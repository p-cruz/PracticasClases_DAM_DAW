create or replace function PotenciaPositiva (p_base NUMBER, p_exponente NUMBER)
return FLOAT
is
        v_resultado FLOAT:=1.0;
begin
        for i in 1..p_exponente loop
            v_resultado:=v_resultado*p_base;
        end loop;
        -- dbms_output.put_line(v_resultado);
        return v_resultado;
end;

create or replace function PotenciaNegativa (p_base NUMBER, p_exponente NUMBER)
return FLOAT
is
  v_resultado FLOAT;
begin
  v_resultado:=1/PotenciaPositiva(p_base, p_exponente*-1);
  -- dbms_output.put_line(v_resultado);
  return v_resultado;
end;
/



create or replace procedure Potencia (p_base NUMBER, p_exponente NUMBER)
is
  v_resultado FLOAT:=1.0;
begin
  if p_base = 0 and p_exponente = 0 then
    raise_application_error(-20001,'Datos Erróneos');
  elsif p_base=0 then
    raise_application_error(-20001,'Datos Err¢neos');
  elsif p_exponente < 0 then
       v_resultado:= PotenciaNegativa(p_base, p_exponente);
  elsif p_exponente > 0 then
    v_resultado:= PotenciaPositiva(p_base, p_exponente);
  end if;
  dbms_output.put_line('Resultado= '||v_resultado);
end;

 
create or replace function DevolverCadAlReves(p_cad VARCHAR2)
return VARCHAR2
is
    v_aux VARCHAR2(30):='';
    v_dnombre VARCHAR2(30);
begin
    for i in reverse 1..length(p_cad) loop
        v_aux:=v_aux||substr(p_cad,i,1);
    end loop;
    select dnombre into v_dnombre from depart where dnombre=v_aux;
    return v_aux;
exception
    when no_data_found then
        return 'No corresponde a un departamento valido';
    when others then
        return 'Error';
end;
/


create or replace procedure MuestraEmple (p_nombre depart.dnombre%type)
is
	cursor cEmple IS SELECT apellido from emple natural join depart 
			where dnombre= DevolverCadAlReves(p_nombre);
begin
    for emp in cEmple loop
        dbms_output.put_line(emp.apellido||chr(10));
    end loop;
end;
/


CREATE OR REPLACE PROCEDURE ejercicio12 as
    cursor cdepartamentos is select distinct(depart_no) from emple;
    cursor cempleadosNuevos(dep number) is select * from emple where depart_no=dep 
            order by fecha_alt desc for update;
            -- no funcionaría con fetch first, pero sí con rownum
    mul int:=0;
BEGIN  
	for depart in cdepartamentos loop
		mul:=0;
		for empleados in cempleadosNuevos(depart.depart_no) loop
			DELETE FROM emple
			WHERE CURRENT OF cempleadosNuevos;
			mul:=mul+1;
			exit when mul=2;
		end loop;
	end loop;
END;

set lines 180
set pagesize 100
column proveedor format a30 word_wrapped
column cantidadvendida format 9,990
break on proveedor
compute sum of cantidadvendida on proveedor 

select proveedor, codigoproducto, sum(cantidad) cantidadVendida
  from productos natural join detallepedidos
  group by proveedor,codigoproducto
  order by proveedor, sum(cantidad) desc;

clear columns
clear breaks
clear computes
