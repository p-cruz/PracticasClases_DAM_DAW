CREATE OR REPLACE TRIGGER actualizaestadisticas
    AFTER INSERT OR DELETE OR UPDATE of cantidad,preciounidad
    ON detallepedidos 
    FOR EACH ROW
DECLARE
    emp integer;
    emp2 integer;
BEGIN
    IF inserting THEN
        dbms_output.put_line('if inserting');
        select CodigoEmpleadoRepVentas into emp 
            from pedidos, clientes
            where clientes.codigocliente=pedidos.codigocliente and 
                    pedidos.codigopedido=:new.codigopedido;
        dbms_output.put_line('Empleado: '||emp);
        select codigoempleado into emp2
            from estadisticasempleados
            where codigoempleado=emp;
        update estadisticasempleados 
            set total = total + (:new.cantidad*:new.preciounidad) 
            where codigoempleado=emp;
    ELSIF updating('cantidad') OR updating('preciounidad') THEN
        dbms_output.put_line('if updating');
        select CodigoEmpleadoRepVentas into emp 
            from pedidos, clientes
             where clientes.codigocliente=pedidos.codigocliente and
                    pedidos.codigopedido=:new.codigopedido;
        dbms_output.put_line('Empleado: '||emp);
        update estadisticasempleados 
            set total = total -(:old.cantidad*:old.preciounidad) + (:new.cantidad*:new.preciounidad) 
            where codigoempleado=emp;     
    ELSE
        dbms_output.put_line('if deleting');
        select CodigoEmpleadoRepVentas into emp 
             where clientes.codigocliente=pedidos.codigocliente and pedidos.codigopedido=:old.codigopedido;
        dbms_output.put_line('Empleado: '||emp);
        update estadisticasempleados 
            set total = total -(:old.cantidad*:old.preciounidad)
            where codigoempleado=emp;
    END IF;
EXCEPTION
    when no_data_found then
        insert into estadisticasempleados values (emp, :new.cantidad*:new.preciounidad); 
END;
/