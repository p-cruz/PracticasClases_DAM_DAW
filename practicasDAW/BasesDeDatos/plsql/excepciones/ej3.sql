create table personas (
    nombre varchar2(100),
    fechaNac  date
);

declare
    type persona is record (
        nombre varchar2(100),
        fechaNac  date
    );
    p1 persona;
begin
        p1.nombre:='&DimeNombre';
        p1.fechaNac:='&DimeFNac';
        insert into personas values p1;
         p1.nombre:='&DimeNombre';
        p1.fechaNac:='&DimeFNac';
        insert into personas values p1;
         p1.nombre:='&DimeNombre';
        p1.fechaNac:='&DimeFNac';
        insert into personas values p1;

end;
/

create or replace procedure dimeDatos(d1 OUT Varchar2(100), d2 out date)
is
begin
    d1:='&DimeNOmbre';
    d2:='&DimeFEcha';
end;


declare
    type persona is record (
        nombre varchar2(100),
        fechaNac  date
    );
    p1 persona;
begin
    FOR I in 1..2 
        dimeDatos(p1.nombre, p2.fechaNac);
        insert into personas values p1;
    end loop;
end;
/



