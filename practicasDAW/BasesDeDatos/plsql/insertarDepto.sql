declare
    codigoDepto depart.depart_no%type;
begin
    select max(depart_no) into codigoDepto
    from depart;

    insert into depart (depart_no, dnombre) values (codigoDepto+10, '&DimeNombreDepto');
end;
/