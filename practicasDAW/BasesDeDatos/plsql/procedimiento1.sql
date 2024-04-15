create or replace procedure listarCien
is 
begin
    for i in 1..100 loop
        dbms_output.put_line(i);
    end loop;
end;
-------------------------------
create or replace procedure llamaCien
is
begin 
    dbms_output.put_line('Voy a llamar al procedimiento listarCien');
    listarCien();
    dbms_output.put_line('Ya lo he llamado');
    dbms_output.put_line('Sigo haciendo cosas');
end;
-------------------------------

create or replace procedure interchange(a IN number, b IN number)
is
begin
    dbms_output.put_line('El valor de a es: '|| b || chr(10) || 'El valor de b es:'||a);
end;


-------------------------------
declare
    a number :=40;
    b number :=50;
begin
    dbms_output.put_line('El valor de a es: '|| a || chr(10) || 'El valor de b es:'||b);
    interchange(a,b);
    dbms_output.put_line('El valor de a es: '|| a || chr(10) || 'El valor de b es:'||b);
end;
-------------------------------
create or replace procedure SalariosInterchange(user1 IN emple.emple_no%type,
                                                user2 IN emple.emple_no%type)
is
    salario1 emple.salario%type;
    salario2 emple.salario%type;
begin
    select salario into salario2
    from emple
    where emple_no=user1;

    select salario into salario1
    from emple
    where emple_no=user2;

    update emple set salario=salario1 where emple_no=user1;
    update emple set salario=salario2 where emple_no=user2;
    dbms_output.put_line('salarios intercambiados');
end;

-------------------------------
create or replace procedure ej1(nTope IN integer)
is
begin
    for i in 0..nTope loop
        dbms_output.put_line(i);
    end loop;
end;
-------------------------------
call ej1(9)
-------------------------------
declare
    n integer:=9;
begin
    ej1(n);
end;
-------------------------------
create or replace procedure ej2 (dividendo IN number, divisor IN number, 
                                cociente OUT number, resto OUT number)
is
BEGIN
    cociente:= trunc(dividendo/divisor);
    resto:=mod(dividendo,divisor);
END;

declare
    a integer;
    b integer;
begin
    ej2(&Dividendo, &Divisor, a, b);
    dbms_output.put_line('Cociente: '||a || '    Resto: ' || b);
end;
