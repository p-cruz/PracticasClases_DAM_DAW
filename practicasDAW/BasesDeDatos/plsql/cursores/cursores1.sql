DECLARE
		CURSOR cEmple IS SELECT apellido, oficio, depart_no FROM emple;
		regEmple cEmple%ROWTYPE;
BEGIN
		OPEN cEmple;
		LOOP
        	FETCH cEmple INTO regEmple; --lee primera fila
            exit when cEmple%NOTFOUND;
			dbms_output.put_line(regEmple.apellido ||', '|| regEmple.oficio 
                                ||', ' || regEmple.depart_no || chr(10));
		END LOOP;
		CLOSE cEmple;
END;

DECLARE
		CURSOR cEmple2 IS SELECT apellido, oficio, depart_no 
							FROM emple;
BEGIN
	FOR regEmple IN cEmple2 LOOP
dbms_output.put_line(regEmple.apellido ||', '|| regEmple.oficio ||', ' || regEmple.depart_no || chr(10));
	END LOOP;
END;




CREATE OR REPLACE FUNCTION EJ1_cursores(numDep number) 
return number
IS
    cursor cEj1 is select apellido, oficio, salario from emple where depart_no=numDep;
    total number:=0;
BEGIN
    for regEmple in cEj1 LOOP
        dbms_output.put_line(regEmple.apellido || ', '|| regEmple.oficio || ', '|| regEmple.salario);
        total:=total+regEmple.salario;
    end loop;
    return total;
end;
