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
        dbms_output.put_line('Hay mas de 3 empleados con esas condiciones, se deshace la operacion de subida de salario');
        rollback;
    else
        dbms_output.put_line('Se sube el salario de los vendedores con mas de 500 euros de comision, ya que solo hay '|| cantidad ||' empleados con esas condiciones');
    end if;
end;
/