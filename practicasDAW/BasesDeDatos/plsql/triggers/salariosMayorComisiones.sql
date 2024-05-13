create or replace procedure SalariosMayorComisiones
is
    cursor c1 is select depart_no, sum(nvl(salario,0)) as tsalarios, 
                        sum(nvl(comision,0)) as tcomisiones
    from emple
    group by depart_no;
begin
    for r1 in c1 loop
        if r1.tcomisiones > r1.tsalarios then
            dbms_output. put_line('Error, el departamento ' || r1.depart_no || ' tiene mas comisiones que salarios');
        else
            dbms_output. put_line('El departamento ' || r1.depart_no || ' tiene mas salarios que comisiones');
        end if;
    end loop;
end;
/