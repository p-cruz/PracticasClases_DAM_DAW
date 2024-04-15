create table temp (
    id number(10) primary key,
    parImpar varchar2(10)  
);

declare

begin
    for i in 1..100 loop
        if mod(i,2)=0 then
            insert into temp values(i,'par');
        else
            insert into temp values(i,'impar');
        end if;
    end loop;
    commit;
end;