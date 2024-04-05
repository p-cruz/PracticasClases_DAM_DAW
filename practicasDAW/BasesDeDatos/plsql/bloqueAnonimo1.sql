declare
    cantidad number(2,0);
begin
    commit;
    
    update emple set salario=salario*1.15 
    where oficio='VENDEDOR' and comision>500;
    
    select count(*) into cantidad
    from emple
    where  oficio='VENDEDOR' and comision>500;

    if (cantidad>3) then
        dbms_output.put_line('Hay más de 3 empleados con esas condiciones, se deshace la operación de subida de salario');
        rollback;
    else
        dbms_output.put_line('Se sube el salario de los vendedores con más de 600€ de comisión, ya que no hay más de 3');
    end if;
end;
/