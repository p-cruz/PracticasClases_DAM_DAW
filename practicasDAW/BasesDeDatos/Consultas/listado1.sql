ttitle LEFT 'LISTADO ' CENTER 'DE EMPLEADOS' RIGHT 'EJERCICIO_LISTADOS'
Btitle 'fecha: &_DATE'

break on depart_no

select apellido, salario, depart_no
from emple
order by depart_no, salario desc;

ttitle off
Btitle off
clear breaks