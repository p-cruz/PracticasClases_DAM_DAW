update emple
set salario =(select salario/2 from emple where apellido like '%REY%')
where depart_no=(select depart_no from emple where apellido like '%REY%')
and apellido not like '%REY%';

update emple
set salario =(select salario*2/3 from emple where apellido like '%REY%'),
    comision = (select max(comision) from emple)
where depart_no=(select depart_no from emple where apellido like '%REY%')
and apellido not like '%REY%';

update emple
set (salario,comision) =(select (select salario*2/3 from emple where apellido like '%REY%')
                                ,(select max(comision) from emple) from dual)
where depart_no=(select depart_no from emple where apellido like '%REY%')
and apellido not like '%REY%';

update emple
set (salario,comision) =(select salario*2/3, (select max(comision) from emple)
                            from emple where apellido like '%REY%')
where depart_no=(select depart_no from emple where apellido like '%REY%')
and apellido not like '%REY%';

alter table resumendepto add (fechaAntiguo date, fechaNuevo date);

update resumendepto
set (fechaantiguo,fechanuevo) =(select min(fecha_alt), max(fecha_alt) 
                                from emple
                                where resumendepto.dep_no=emple.depart_no)

update emple
set salario=salario*1.03
where ((sysdate-fecha_alt)/365)>27;

update emple
set salario=salario*1.0275
where ((sysdate-fecha_alt)/365)<=27;

update resumendepto
set sumsalarios=(select sum(salario) 
                    from emple
                    where emple.depart_no=resumendepto.dep_no)