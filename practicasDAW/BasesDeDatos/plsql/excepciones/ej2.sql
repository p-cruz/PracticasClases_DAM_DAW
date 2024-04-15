declare
    depCod number;
    depNombre varchar2(200);
    depLoc varchar2(10);
    cod number;
    msg varchar2(100);
    depExiste EXCEPTION;
    datoGrande EXCEPTION;
    nombreDep varchar2(200);
    pragma exception_init(datoGrande, -12899); --6502
begin
    depCod:=&NumeroDepartamento;
    depNombre:='&NombreDepartamento';
    depLoc:='&LocalidadDepartamento';
    begin
            select dnombre into nombreDep from depart where lower(dnombre)=lower(depNombre);
            raise depExiste;
    exception
            when no_data_found then
                insert into depart values (depCod, depNombre, depLoc);
    end;
    exception
        when dup_val_on_index then
    	    cod := SQLCODE;
            insert into temp values (cod, 'NUMERO dep '||depCod ||' ya existe');
        when depExiste then
            insert into temp values (1,'departamento '||depNombre ||' ya existe');
        when datoGrande then
    		cod := SQLCODE;
            INSERT INTO temp VALUES (cod,'dato grande para la columna');
        when others then
            cod := SQLCODE;
            msg := SUBSTR(SQLERRM, 1, 40);
            INSERT INTO temp VALUES (cod , msg);
end;
/
