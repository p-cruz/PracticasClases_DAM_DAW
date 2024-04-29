CREATE OR REPLACE TRIGGER T_EMPLEINSERT
  AFTER INSERT
  or update
  or delete 
  on emple
  FOR EACH ROW
DECLARE
BEGIN
    if inserting then 
        insert into log values ('Registro insertado', sysdate,user);
    elsif updating then
        insert into log values ('Registro actualizado', sysdate,user);
    else 
        insert into log values ('Registro borrado', sysdate,user);
    end if;
END ; 


CREATE OR REPLACE TRIGGER TR_PRODUCTOS1
    AFTER INSERT OR DELETE  or update
    ON DetallePedidos
    FOR EACH ROW
DECLARE
BEGIN
    if inserting then 
            UPDATE Pedidos set total = nvl(total,0)+(:new.cantidad * :new.preciounidad) 
                WHERE codigopedido=:new.codigopedido;
    elsif deleting then
            UPDATE Pedidos set total = nvl(total,0)-(:old.cantidad * :old.preciounidad) 
                WHERE codigopedido=:old.codigopedido;
    else
            update pedidos set total=nvl(total,0)-(:old.cantidad * :old.preciounidad)
                                        +(:new.cantidad * :new.preciounidad)
                WHERE codigopedido=:old.codigopedido;
    end if;
END; 
/


update pedidos set total=
