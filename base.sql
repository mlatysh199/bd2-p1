CREATE TABLE CATEGORIA(
    id VARCHAR2(10) NOT NULL,
    descripcion VARCHAR2(100) NOT NULL,
    CONSTRAINT pk_categoria PRIMARY KEY(id)
);

CREATE TABLE PRODUCTO(
    id NUMBER(10) NOT NULL,
    nombre VARCHAR2(40) NOT NULL,
    descripcion VARCHAR2(100) NOT NULL,
    precio NUMBER(10,2) NOT NULL,
    categoria_id VARCHAR2(10) NOT NULL,
    inventario NUMBER(10) NOT NULL,
    CONSTRAINT pk_producto PRIMARY KEY(id),
    CONSTRAINT fk_categoria FOREIGN KEY(categoria_id) REFERENCES CATEGORIA(id)
);


CREATE TABLE CLIENTE(
    id NUMBER(10) NOT NULL,
    nombre VARCHAR2(50) NOT NULL,
    fecha_ultima_compra DATE,
    correo VARCHAR2(50) NOT NULL,
    direccion VARCHAR2(100) NOT NULL,
    cantidad_compras NUMBER(10) NOT NULL,
    CONSTRAINT pk_cliente PRIMARY KEY(id)
);

CREATE TABLE RECIBO(
    id NUMBER(10) NOT NULL,
    fecha DATE NOT NULL,
    cliente_id NUMBER(10) NOT NULL,
    CONSTRAINT pk_recibo PRIMARY KEY(id),
    CONSTRAINT fk_cliente FOREIGN KEY(cliente_id) REFERENCES CLIENTE(id)
);

CREATE TABLE PRODUCTO_RECIBO(
    producto_id NUMBER(10) NOT NULL,
    recibo_id NUMBER(10) NOT NULL,
    cantidad NUMBER(10) NOT NULL,
    CONSTRAINT pk_producto_recibo PRIMARY KEY(producto_id, recibo_id),
    CONSTRAINT fk_producto_recibo_producto FOREIGN KEY(producto_id) REFERENCES PRODUCTO(id),
    CONSTRAINT fk_producto_recibo_recibo FOREIGN KEY(recibo_id) REFERENCES RECIBO(id)
);

CREATE TABLE RECIBO_DETALLE(
    id NUMBER(10) NOT NULL,
    recibo_id NUMBER(10) NOT NULL,
    monto NUMBER(10,2) NOT NULL,
    cantidad NUMBER(10) NOT NULL,
    metodo_pago VARCHAR2(30) NOT NULL,
    descripcion VARCHAR2(100) NOT NULL,
    CONSTRAINT pk_recibo_detalle PRIMARY KEY(id),
    CONSTRAINT fk_recibo_detalle_recibo FOREIGN KEY(recibo_id) REFERENCES RECIBO(id)
);

CREATE TABLE PROVEEDOR(
    id NUMBER(10) NOT NULL,
    nombre VARCHAR2(50) NOT NULL,
    descripcion VARCHAR2(100) NOT NULL,
    direccion VARCHAR2(100) NOT NULL,
    CONSTRAINT pk_proveedor PRIMARY KEY(id)
);

CREATE TABLE COMPRA_PRODUCTO(
    id NUMBER(10) NOT NULL,
    producto_id NUMBER(10) NOT NULL,
    proveedor_id NUMBER(10) NOT NULL,
    fecha DATE NOT NULL,
    CONSTRAINT pk_compra_producto PRIMARY KEY(id),
    CONSTRAINT fk_producto FOREIGN KEY(producto_id) REFERENCES PRODUCTO(id),
    CONSTRAINT fk_proveedor FOREIGN KEY(proveedor_id) REFERENCES PROVEEDOR(id)
);

CREATE TABLE COMPRA_DETALLE(
    id NUMBER(10) NOT NULL,
    compra_producto_id NUMBER(10) NOT NULL,
    cantidad NUMBER(10) NOT NULL,
    monto NUMBER(10,2) NOT NULL,
    descripcion VARCHAR2(100) NOT NULL,
    CONSTRAINT pk_compra_detalle PRIMARY KEY(id),
    CONSTRAINT fk_compra_producto FOREIGN KEY(compra_producto_id) REFERENCES COMPRA_PRODUCTO(id)
);

CREATE TABLE BITACORA_PRODUCTO(
    id NUMBER(10) NOT NULL,
    fecha TIMESTAMP NOT NULL,
    descripcion VARCHAR2(600) NOT NULL,
    usuario_db VARCHAR2(50) NOT NULL,
    CONSTRAINT pk_bitacora_producto PRIMARY KEY(id)
);

-- Path: base.sql
-- Implement, using ORACLE SQL, automatic sequences for all the tables that need it.

CREATE SEQUENCE seq_producto START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_cliente START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_recibo START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_recibo_detalle START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_proveedor START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_compra_producto START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_compra_detalle START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_bitacora_producto START WITH 1 INCREMENT BY 1;

-- Implement, using ORACLE SQL, the triggers for bitacora_producto table [the triggers have to log all the changes to the product table] (all of the triggers have to occur after the event):

CREATE OR REPLACE TRIGGER bitacora_producto_insert
AFTER INSERT ON PRODUCTO
FOR EACH ROW
    DECLARE
        producto_id NUMBER(10);
        producto_nombre VARCHAR2(40);
BEGIN
    producto_id := :NEW.id;
    producto_nombre := :NEW.nombre;
    INSERT INTO BITACORA_PRODUCTO(id, fecha, descripcion, usuario_db)
    VALUES(seq_bitacora_producto.NEXTVAL, SYSTIMESTAMP,'Se insertó el producto '|| producto_nombre || ' con id '|| TO_CHAR(producto_id), USER);
END;

CREATE OR REPLACE TRIGGER bitacora_producto_update
AFTER UPDATE ON PRODUCTO
FOR EACH ROW
    DECLARE
        producto_id NUMBER(10);
        producto_nombre VARCHAR2(40);
        mensaje VARCHAR2(600);
        producto_nombre_nuevo VARCHAR2(40);
        producto_nombre_anterior VARCHAR2(40);
        producto_descripcion_nuevo VARCHAR2(100);
        producto_descripcion_anterior VARCHAR2(100);
        producto_precio_nuevo NUMBER(10,2);
        producto_precio_anterior NUMBER(10,2);
        producto_categoria_nuevo VARCHAR2(10);
        producto_categoria_anterior VARCHAR2(10);
        producto_inventario_nuevo NUMBER(10);
        producto_inventario_anterior NUMBER(10);
BEGIN
    producto_id := :NEW.id;
    producto_nombre := :OLD.nombre;
    producto_nombre_nuevo := :NEW.nombre;
    producto_nombre_anterior := :OLD.nombre;
    producto_descripcion_nuevo := :NEW.descripcion;
    producto_descripcion_anterior := :OLD.descripcion;
    producto_precio_nuevo := :NEW.precio;
    producto_precio_anterior := :OLD.precio;
    producto_categoria_nuevo := :NEW.categoria_id;
    producto_categoria_anterior := :OLD.categoria_id;
    producto_inventario_nuevo := :NEW.inventario;
    producto_inventario_anterior := :OLD.inventario;

    mensaje := 'Se actualizó el producto ' || producto_nombre || ' con id ' || TO_CHAR(producto_id);

    IF producto_nombre_nuevo <> producto_nombre_anterior THEN
        mensaje := mensaje || '; su nombre cambió de "' || producto_nombre_anterior || '" a "' || producto_nombre_nuevo || '"';
    END IF;

    IF producto_descripcion_nuevo <> producto_descripcion_anterior THEN
        mensaje := mensaje || '; su descripción cambió de "' || producto_descripcion_anterior || '" a "' || producto_descripcion_nuevo || '"';
    END IF;

    IF producto_precio_nuevo <> producto_precio_anterior THEN
        mensaje := mensaje || '; su precio cambió de ' || TO_CHAR(producto_precio_anterior) || ' a ' || TO_CHAR(producto_precio_nuevo);
    END IF;

    IF producto_categoria_nuevo <> producto_categoria_anterior THEN
        mensaje := mensaje || '; su categoría cambió de ' || producto_categoria_anterior || ' a ' || producto_categoria_nuevo;
    END IF;

    IF producto_inventario_nuevo <> producto_inventario_anterior THEN
        mensaje := mensaje || '; su inventario cambió de ' || TO_CHAR(producto_inventario_anterior) || ' a ' || TO_CHAR(producto_inventario_nuevo);
    END IF;

    INSERT INTO BITACORA_PRODUCTO(id, fecha, descripcion, usuario_db) VALUES(seq_bitacora_producto.NEXTVAL, SYSTIMESTAMP, mensaje, USER);
END;

CREATE OR REPLACE TRIGGER bitacora_producto_delete
AFTER DELETE ON PRODUCTO
FOR EACH ROW
    DECLARE
        producto_id NUMBER(10);
        producto_nombre VARCHAR2(40);
BEGIN
    producto_id := :OLD.id;
    producto_nombre := :OLD.nombre;
    INSERT INTO BITACORA_PRODUCTO(id, fecha, descripcion, usuario_db)
    VALUES(seq_bitacora_producto.NEXTVAL, SYSTIMESTAMP, 'Se eliminó el producto '|| producto_nombre || ' con id '|| TO_CHAR(producto_id), USER);
END;

CREATE OR REPLACE TRIGGER recibo_insert
AFTER INSERT ON RECIBO
FOR EACH ROW
    DECLARE
        recibo_fecha DATE;
        recibo_cliente_id NUMBER(10);
BEGIN
    recibo_fecha := :NEW.fecha;
    recibo_cliente_id := :NEW.cliente_id;
    UPDATE CLIENTE
    SET fecha_ultima_compra = recibo_fecha, cantidad_compras = cantidad_compras + 1
    WHERE id = recibo_cliente_id;
END;

-- Create package for the tables PRODUCTOS, CLIENTE, RECIBO, and PROVEEDOR to INSERT, UPDATE, and DELETE:

CREATE OR REPLACE PACKAGE paquete_modificar AS
    PROCEDURE insertar_producto(p_nombre VARCHAR2, p_descripcion VARCHAR2, p_precio NUMBER, p_categoria_id VARCHAR2, p_inventario NUMBER);
    PROCEDURE actualizar_producto(p_id NUMBER, p_nombre VARCHAR2, p_descripcion VARCHAR2, p_precio NUMBER, p_categoria_id VARCHAR2, p_inventario NUMBER);
    PROCEDURE eliminar_producto(p_id NUMBER);
    PROCEDURE insertar_cliente(p_nombre VARCHAR2, p_fecha_ultima_compra DATE, p_correo VARCHAR2, p_direccion VARCHAR2, p_cantidad_compras NUMBER);
    PROCEDURE actualizar_cliente(p_id NUMBER, p_nombre VARCHAR2, p_fecha_ultima_compra DATE, p_correo VARCHAR2, p_direccion VARCHAR2, p_cantidad_compras NUMBER);
    PROCEDURE eliminar_cliente(p_id NUMBER);
    PROCEDURE insertar_recibo(p_fecha DATE, p_cliente_id NUMBER);
    PROCEDURE actualizar_recibo(p_id NUMBER, p_fecha DATE, p_cliente_id NUMBER);
    PROCEDURE eliminar_recibo(p_id NUMBER);
    PROCEDURE insertar_proveedor(p_nombre VARCHAR2, p_descripcion VARCHAR2, p_direccion VARCHAR2);
    PROCEDURE actualizar_proveedor(p_id NUMBER, p_nombre VARCHAR2, p_descripcion VARCHAR2, p_direccion VARCHAR2);
    PROCEDURE eliminar_proveedor(p_id NUMBER);

    -- Also, producto_recibo
    PROCEDURE insertar_producto_recibo(p_producto_id NUMBER, p_recibo_id NUMBER, p_cantidad NUMBER);
    PROCEDURE actualizar_producto_recibo(p_id NUMBER, p_producto_id NUMBER, p_recibo_id NUMBER, p_cantidad NUMBER);
    PROCEDURE eliminar_producto_recibo(p_id NUMBER);
    PROCEDURE eliminar_producto_recibo_completo(p_recibo_id NUMBER);

    -- recibo detalle, compra_producto, compra_detalle
    PROCEDURE insertar_recibo_detalle(p_recibo_id NUMBER, p_monto NUMBER, p_cantidad NUMBER, p_metodo_pago VARCHAR2, p_descripcion VARCHAR2);
    PROCEDURE actualizar_recibo_detalle(p_id NUMBER, p_recibo_id NUMBER, p_monto NUMBER, p_cantidad NUMBER, p_metodo_pago VARCHAR2, p_descripcion VARCHAR2);
    PROCEDURE eliminar_recibo_detalle(p_id NUMBER);
    PROCEDURE insertar_recibo_completo(p_fecha DATE, p_cliente_id NUMBER, p_monto NUMBER, p_cantidad NUMBER, p_metodo_pago VARCHAR2, p_descripcion VARCHAR2);
    PROCEDURE insertar_compra_producto(p_producto_id NUMBER, p_proveedor_id NUMBER, p_fecha DATE);
    PROCEDURE actualizar_compra_producto(p_id NUMBER, p_producto_id NUMBER, p_proveedor_id NUMBER, p_fecha DATE);
    PROCEDURE eliminar_compra_producto(p_id NUMBER);
    PROCEDURE insertar_compra_detalle(p_compra_producto_id NUMBER, p_cantidad NUMBER, p_monto NUMBER, p_descripcion VARCHAR2);
    PROCEDURE actualizar_compra_detalle(p_id NUMBER, p_compra_producto_id NUMBER, p_cantidad NUMBER, p_monto NUMBER, p_descripcion VARCHAR2);
    PROCEDURE eliminar_compra_detalle(p_id NUMBER);
    PROCEDURE insertar_compra_producto_completo(p_producto_id NUMBER, p_proveedor_id NUMBER, p_fecha DATE, p_cantidad NUMBER, p_monto NUMBER, p_descripcion VARCHAR2);
END;

-- Create package for the tables PRODUCTOS, BITACORA_PRODUCTO, CLIENTE, RECIBO, and PROVEEDOR to SELECT:

CREATE OR REPLACE PACKAGE paquete_select AS
    FUNCTION obtener_productos RETURN SYS_REFCURSOR;
    FUNCTION obtener_producto(p_id NUMBER) RETURN SYS_REFCURSOR;
    FUNCTION obtener_productos_categoria RETURN SYS_REFCURSOR; -- incluir join con categoria
    FUNCTION obtener_producto_categoria(id NUMBER) RETURN SYS_REFCURSOR; -- incluir join con categoria
    FUNCTION obtener_bitacora_productos RETURN SYS_REFCURSOR;
    FUNCTION obtener_bitacora_producto(id NUMBER) RETURN SYS_REFCURSOR;
    FUNCTION obtener_clientes RETURN SYS_REFCURSOR;
    FUNCTION obtener_cliente(id NUMBER) RETURN SYS_REFCURSOR;
    FUNCTION obtener_recibos RETURN SYS_REFCURSOR;
    FUNCTION obtener_recibo(id NUMBER) RETURN SYS_REFCURSOR; -- incluir join con recibo_detalle
    FUNCTION obtener_proveedores RETURN SYS_REFCURSOR;
    FUNCTION obtener_proveedor(id NUMBER) RETURN SYS_REFCURSOR;
    FUNCTION obtener_compra_productos RETURN SYS_REFCURSOR;
    FUNCTION obtener_compra_producto(id NUMBER) RETURN SYS_REFCURSOR; -- incluir join con compra_detalle
    FUNCTION obtener_articulos_vendido_mes(anio_mes DATE) RETURN NUMBER; -- retorna la cantidad vendida por mes en total
    FUNCTION obtener_articulo_vendido_mes(p_id NUMBER, anio_mes DATE) RETURN NUMBER;  
    FUNCTION obtener_producto_recibo_todos RETURN SYS_REFCURSOR;
    FUNCTION obtener_producto_recibo(p_producto_id NUMBER, p_recibo_id NUMBER) RETURN SYS_REFCURSOR;
    FUNCTION obtener_productos_recibo(p_recibo_id NUMBER) RETURN SYS_REFCURSOR;
    FUNCTION obtener_producto_recibos(p_producto_id NUMBER) RETURN SYS_REFCURSOR;
END;

-- Create package body (with exceptions management) for the tables PRODUCTOS, CLIENTE, RECIBO, and PROVEEDOR to INSERT, UPDATE, and DELETE:

CREATE OR REPLACE PACKAGE BODY paquete_modificar AS 
    PROCEDURE insertar_producto(p_nombre VARCHAR2, p_descripcion VARCHAR2, p_precio NUMBER, p_categoria_id VARCHAR2, p_inventario NUMBER) AS
    BEGIN
        INSERT INTO PRODUCTO(id, nombre, descripcion, precio, categoria_id, inventario)
        VALUES(seq_producto.NEXTVAL, p_nombre, p_descripcion, p_precio, p_categoria_id, p_inventario);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20001, 'Error al insertar producto');
    END insertar_producto;

    PROCEDURE actualizar_producto(p_id NUMBER, p_nombre VARCHAR2, p_descripcion VARCHAR2, p_precio NUMBER, p_categoria_id VARCHAR2, p_inventario NUMBER) AS
    BEGIN
        UPDATE PRODUCTO
        SET nombre = p_nombre, descripcion = p_descripcion, precio = p_precio, categoria_id = p_categoria_id, inventario = p_inventario
        WHERE id = p_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'Error al actualizar producto');
    END actualizar_producto;

    PROCEDURE eliminar_producto(p_id NUMBER) AS
    BEGIN
        DELETE FROM PRODUCTO
        WHERE id = p_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20003, 'Error al eliminar producto');
    END eliminar_producto;

    PROCEDURE insertar_cliente(p_nombre VARCHAR2, p_fecha_ultima_compra DATE, p_correo VARCHAR2, p_direccion VARCHAR2, p_cantidad_compras NUMBER) AS
    BEGIN
        INSERT INTO CLIENTE(id, nombre, fecha_ultima_compra, correo, direccion, cantidad_compras)
        VALUES(seq_cliente.NEXTVAL, p_nombre, p_fecha_ultima_compra, p_correo, p_direccion, p_cantidad_compras);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20004, 'Error al insertar cliente');
    END insertar_cliente;

    PROCEDURE actualizar_cliente(p_id NUMBER, p_nombre VARCHAR2, p_fecha_ultima_compra DATE, p_correo VARCHAR2, p_direccion VARCHAR2, p_cantidad_compras NUMBER) AS
    BEGIN
        UPDATE CLIENTE
        SET nombre = p_nombre, fecha_ultima_compra = p_fecha_ultima_compra, correo = p_correo, direccion = p_direccion, cantidad_compras = p_cantidad_compras
        WHERE id = p_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20005, 'Error al actualizar cliente');
    END actualizar_cliente;

    PROCEDURE eliminar_cliente(p_id NUMBER) AS
    BEGIN
        DELETE FROM CLIENTE
        WHERE id = p_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20006, 'Error al eliminar cliente');
    END eliminar_cliente;

    PROCEDURE insertar_recibo(p_fecha DATE, p_cliente_id NUMBER) AS
    BEGIN
        INSERT INTO RECIBO(id, fecha, cliente_id)
        VALUES(seq_recibo.NEXTVAL, p_fecha, p_cliente_id);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20007, 'Error al insertar recibo');
    END insertar_recibo;

    PROCEDURE actualizar_recibo(p_id NUMBER, p_fecha DATE, p_cliente_id NUMBER) AS
    BEGIN
        UPDATE RECIBO
        SET fecha = p_fecha, cliente_id = p_cliente_id
        WHERE id = p_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20008, 'Error al actualizar recibo');
    END actualizar_recibo;

    PROCEDURE eliminar_recibo(p_id NUMBER) AS
    BEGIN
        DELETE FROM RECIBO
        WHERE id = p_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20009, 'Error al eliminar recibo');
    END eliminar_recibo;

    PROCEDURE insertar_proveedor(p_nombre VARCHAR2, p_descripcion VARCHAR2, p_direccion VARCHAR2) AS
    BEGIN
        INSERT INTO PROVEEDOR(id, nombre, descripcion, direccion)
        VALUES(seq_proveedor.NEXTVAL, p_nombre, p_descripcion, p_direccion);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20010, 'Error al insertar proveedor');
    END insertar_proveedor;

    PROCEDURE actualizar_proveedor(p_id NUMBER, p_nombre VARCHAR2, p_descripcion VARCHAR2, p_direccion VARCHAR2) AS
    BEGIN
        UPDATE PROVEEDOR
        SET nombre = p_nombre, descripcion = p_descripcion, direccion = p_direccion
        WHERE id = p_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20011, 'Error al actualizar proveedor');
    END actualizar_proveedor;

    PROCEDURE eliminar_proveedor(p_id NUMBER) AS
    BEGIN
        DELETE FROM PROVEEDOR
        WHERE id = p_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20012, 'Error al eliminar proveedor');
    END eliminar_proveedor;

    PROCEDURE insertar_recibo_detalle(p_recibo_id NUMBER, p_monto NUMBER, p_cantidad NUMBER, p_metodo_pago VARCHAR2, p_descripcion VARCHAR2) AS
    BEGIN
        INSERT INTO RECIBO_DETALLE(id, recibo_id, monto, cantidad, metodo_pago, descripcion)
        VALUES(seq_recibo_detalle.NEXTVAL, p_recibo_id, p_monto, p_cantidad, p_metodo_pago, p_descripcion);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20013, 'Error al insertar recibo detalle');
    END insertar_recibo_detalle;

    PROCEDURE actualizar_recibo_detalle(p_id NUMBER, p_recibo_id NUMBER, p_monto NUMBER, p_cantidad NUMBER, p_metodo_pago VARCHAR2, p_descripcion VARCHAR2) AS
    BEGIN
        UPDATE RECIBO_DETALLE
        SET recibo_id = p_recibo_id, monto = p_monto, cantidad = p_cantidad, metodo_pago = p_metodo_pago, descripcion = p_descripcion
        WHERE id = p_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20014, 'Error al actualizar recibo detalle');
    END actualizar_recibo_detalle;

    PROCEDURE eliminar_recibo_detalle(p_id NUMBER) AS
    BEGIN
        DELETE FROM RECIBO_DETALLE
        WHERE id = p_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20015, 'Error al eliminar recibo detalle');
    END eliminar_recibo_detalle;

    PROCEDURE insertar_recibo_completo(p_fecha DATE, p_cliente_id NUMBER, p_monto NUMBER, p_cantidad NUMBER, p_metodo_pago VARCHAR2, p_descripcion VARCHAR2) AS
    BEGIN
        INSERT INTO RECIBO(id, fecha, cliente_id)
        VALUES(seq_recibo.NEXTVAL, p_fecha, p_cliente_id);
        INSERT INTO RECIBO_DETALLE(id, recibo_id, monto, cantidad, metodo_pago, descripcion)
        VALUES(seq_recibo_detalle.NEXTVAL, seq_recibo.CURRVAL, p_monto, p_cantidad, p_metodo_pago, p_descripcion);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20016, 'Error al insertar recibo completo');
    END insertar_recibo_completo;

    PROCEDURE insertar_compra_producto(p_producto_id NUMBER, p_proveedor_id NUMBER, p_fecha DATE) AS
    BEGIN
        INSERT INTO COMPRA_PRODUCTO(id, producto_id, proveedor_id, fecha)
        VALUES(seq_compra_producto.NEXTVAL, p_producto_id, p_proveedor_id, p_fecha);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20017, 'Error al insertar compra producto');
    END insertar_compra_producto;

    PROCEDURE actualizar_compra_producto(p_id NUMBER, p_producto_id NUMBER, p_proveedor_id NUMBER, p_fecha DATE) AS
    BEGIN
        UPDATE COMPRA_PRODUCTO
        SET producto_id = p_producto_id, proveedor_id = p_proveedor_id, fecha = p_fecha
        WHERE id = p_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20018, 'Error al actualizar compra producto');
    END actualizar_compra_producto;

    PROCEDURE eliminar_compra_producto(p_id NUMBER) AS
    BEGIN
        DELETE FROM COMPRA_PRODUCTO
        WHERE id = p_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20019, 'Error al eliminar compra producto');
    END eliminar_compra_producto;

    PROCEDURE insertar_compra_detalle(p_compra_producto_id NUMBER, p_cantidad NUMBER, p_monto NUMBER, p_descripcion VARCHAR2) AS
    BEGIN
        INSERT INTO COMPRA_DETALLE(id, compra_producto_id, cantidad, monto, descripcion)
        VALUES(seq_compra_detalle.NEXTVAL, p_compra_producto_id, p_cantidad, p_monto, p_descripcion);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20020, 'Error al insertar compra detalle');
    END insertar_compra_detalle;

    PROCEDURE actualizar_compra_detalle(p_id NUMBER, p_compra_producto_id NUMBER, p_cantidad NUMBER, p_monto NUMBER, p_descripcion VARCHAR2) AS
    BEGIN
        UPDATE COMPRA_DETALLE
        SET compra_producto_id = p_compra_producto_id, cantidad = p_cantidad, monto = p_monto, descripcion = p_descripcion
        WHERE id = p_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20021, 'Error al actualizar compra detalle');
    END actualizar_compra_detalle;

    PROCEDURE eliminar_compra_detalle(p_id NUMBER) AS
    BEGIN
        DELETE FROM COMPRA_DETALLE
        WHERE id = p_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20022, 'Error al eliminar compra detalle');
    END eliminar_compra_detalle;

    PROCEDURE insertar_compra_producto_completo(p_producto_id NUMBER, p_proveedor_id NUMBER, p_fecha DATE, p_cantidad NUMBER, p_monto NUMBER, p_descripcion VARCHAR2) AS 
    BEGIN
        INSERT INTO COMPRA_PRODUCTO(id, producto_id, proveedor_id, fecha)
        VALUES(seq_compra_producto.NEXTVAL, p_producto_id, p_proveedor_id, p_fecha);
        INSERT INTO COMPRA_DETALLE(id, compra_producto_id, cantidad, monto, descripcion)
        VALUES(seq_compra_detalle.NEXTVAL, seq_compra_producto.CURRVAL, p_cantidad, p_monto, p_descripcion);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20023, 'Error al insertar compra producto completo');
    END insertar_compra_producto_completo;

    PROCEDURE insertar_producto_recibo(p_producto_id NUMBER, p_recibo_id NUMBER, p_cantidad NUMBER) AS
    BEGIN
        INSERT INTO PRODUCTO_RECIBO(id, producto_id, recibo_id, cantidad)
        VALUES(seq_producto_recibo.NEXTVAL, p_producto_id, p_recibo_id, p_cantidad);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20024, 'Error al insertar producto recibo');
    END insertar_producto_recibo;

    PROCEDURE actualizar_producto_recibo(p_id NUMBER, p_producto_id NUMBER, p_recibo_id NUMBER, p_cantidad NUMBER) AS
    BEGIN
        UPDATE PRODUCTO_RECIBO
        SET producto_id = p_producto_id, recibo_id = p_recibo_id, cantidad = p_cantidad
        WHERE id = p_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20025, 'Error al actualizar producto recibo');
    END actualizar_producto_recibo;

    PROCEDURE eliminar_producto_recibo(p_id NUMBER) AS
    BEGIN
        DELETE FROM PRODUCTO_RECIBO
        WHERE id = p_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20026, 'Error al eliminar producto recibo');
    END eliminar_producto_recibo;

    PROCEDURE eliminar_producto_recibo_completo(p_recibo_id NUMBER) AS
    BEGIN
        DELETE FROM PRODUCTO_RECIBO
        WHERE recibo_id = p_recibo_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20027, 'Error al eliminar producto recibo completo');
    END eliminar_producto_recibo_completo;

END paquete_modificar;

-- Create package body (with exceptions management) for the tables PRODUCTOS, BITACORA_PRODUCTO, CLIENTE, RECIBO, and PROVEEDOR to SELECT:

CREATE OR REPLACE PACKAGE BODY paquete_select AS
    FUNCTION obtener_productos RETURN SYS_REFCURSOR AS
        productos SYS_REFCURSOR;
    BEGIN
        OPEN productos FOR
        SELECT * FROM PRODUCTO;
        RETURN productos;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20024, 'Error al obtener productos');
    END obtener_productos;

    FUNCTION obtener_producto(p_id NUMBER) RETURN SYS_REFCURSOR AS
        producto SYS_REFCURSOR;
    BEGIN
        OPEN producto FOR
        SELECT * FROM PRODUCTO
        WHERE id = p_id;
        RETURN producto;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20025, 'Error al obtener producto');
    END obtener_producto;

    FUNCTION obtener_productos_categoria RETURN SYS_REFCURSOR AS
        productos_categoria SYS_REFCURSOR;
    BEGIN
        OPEN productos_categoria FOR
        SELECT * FROM PRODUCTO
        INNER JOIN CATEGORIA
        ON PRODUCTO.categoria_id = CATEGORIA.id;
        RETURN productos_categoria;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20026, 'Error al obtener productos categoria');
    END obtener_productos_categoria;

    FUNCTION obtener_producto_categoria(id NUMBER) RETURN SYS_REFCURSOR AS
        producto_categoria SYS_REFCURSOR;
    BEGIN
        OPEN producto_categoria FOR
        SELECT * FROM PRODUCTO
        INNER JOIN CATEGORIA
        ON PRODUCTO.categoria_id = CATEGORIA.id
        WHERE PRODUCTO.id = id;
        RETURN producto_categoria;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20027, 'Error al obtener producto categoria');
    END obtener_producto_categoria;

    FUNCTION obtener_bitacora_productos RETURN SYS_REFCURSOR AS
        bitacora_productos SYS_REFCURSOR;
    BEGIN
        OPEN bitacora_productos FOR
        SELECT * FROM BITACORA_PRODUCTO;
        RETURN bitacora_productos;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20028, 'Error al obtener bitacora productos');
    END obtener_bitacora_productos;

    FUNCTION obtener_bitacora_producto(id NUMBER) RETURN SYS_REFCURSOR AS
        bitacora_producto SYS_REFCURSOR;
    BEGIN
        OPEN bitacora_producto FOR
        SELECT * FROM BITACORA_PRODUCTO
        WHERE id = id;
        RETURN bitacora_producto;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20029, 'Error al obtener bitacora producto');
    END obtener_bitacora_producto;

    FUNCTION obtener_clientes RETURN SYS_REFCURSOR AS
        clientes SYS_REFCURSOR;
    BEGIN
        OPEN clientes FOR
        SELECT * FROM CLIENTE;
        RETURN clientes;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20030, 'Error al obtener clientes');
    END obtener_clientes;

    FUNCTION obtener_cliente(id NUMBER) RETURN SYS_REFCURSOR AS
        cliente SYS_REFCURSOR;
    BEGIN
        OPEN cliente FOR
        SELECT * FROM CLIENTE
        WHERE id = id;
        RETURN cliente;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20031, 'Error al obtener cliente');
    END obtener_cliente;

    FUNCTION obtener_recibos RETURN SYS_REFCURSOR AS
        recibos SYS_REFCURSOR;
    BEGIN
        OPEN recibos FOR
        SELECT * FROM RECIBO;
        RETURN recibos;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20032, 'Error al obtener recibos');
    END obtener_recibos;

    FUNCTION obtener_recibo(id NUMBER) RETURN SYS_REFCURSOR AS
        recibo SYS_REFCURSOR;
    BEGIN
        OPEN recibo FOR
        SELECT * FROM RECIBO
        INNER JOIN RECIBO_DETALLE
        ON RECIBO.id = RECIBO_DETALLE.recibo_id
        WHERE RECIBO.id = id;
        RETURN recibo;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20033, 'Error al obtener recibo');
    END obtener_recibo;

    FUNCTION obtener_proveedores RETURN SYS_REFCURSOR AS
        proveedores SYS_REFCURSOR;
    BEGIN
        OPEN proveedores FOR
        SELECT * FROM PROVEEDOR;
        RETURN proveedores;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20034, 'Error al obtener proveedores');
    END obtener_proveedores;

    FUNCTION obtener_proveedor(id NUMBER) RETURN SYS_REFCURSOR AS
        proveedor SYS_REFCURSOR;
    BEGIN
        OPEN proveedor FOR
        SELECT * FROM PROVEEDOR
        WHERE id = id;
        RETURN proveedor;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20035, 'Error al obtener proveedor');
    END obtener_proveedor;

    FUNCTION obtener_compra_productos RETURN SYS_REFCURSOR AS
        compra_productos SYS_REFCURSOR;
    BEGIN
        OPEN compra_productos FOR
        SELECT * FROM COMPRA_PRODUCTO;
        RETURN compra_productos;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20036, 'Error al obtener compra productos');
    END obtener_compra_productos;

    FUNCTION obtener_compra_producto(id NUMBER) RETURN SYS_REFCURSOR AS
        compra_producto SYS_REFCURSOR;
    BEGIN  
        OPEN compra_producto FOR
        SELECT * FROM COMPRA_PRODUCTO
        INNER JOIN COMPRA_DETALLE
        ON COMPRA_PRODUCTO.id = COMPRA_DETALLE.compra_producto_id
        WHERE COMPRA_PRODUCTO.id = id;
        RETURN compra_producto;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20037, 'Error al obtener compra producto');
    END obtener_compra_producto;

    FUNCTION obtener_articulos_vendido_mes(anio_mes DATE) RETURN NUMBER AS
        articulos_vendidos NUMBER;
    BEGIN
        SELECT SUM(cantidad)
        INTO articulos_vendidos
        FROM PRODUCTO_RECIBO
        INNER JOIN RECIBO
        ON PRODUCTO_RECIBO.recibo_id = RECIBO.id
        WHERE EXTRACT(MONTH FROM RECIBO.fecha) = EXTRACT(MONTH FROM anio_mes) AND EXTRACT(YEAR FROM RECIBO.fecha) = EXTRACT(YEAR FROM anio_mes);
        IF articulos_vendidos IS NULL THEN
            articulos_vendidos := 0;
        END IF;
        RETURN articulos_vendidos;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20038, 'Error al obtener articulos vendidos');
    END obtener_articulos_vendido_mes;

    FUNCTION obtener_articulo_vendido_mes(p_id NUMBER, anio_mes DATE) RETURN NUMBER AS
        articulo_vendido NUMBER;
    BEGIN
        SELECT SUM(cantidad)
        INTO articulo_vendido
        FROM PRODUCTO_RECIBO
        INNER JOIN RECIBO
        ON PRODUCTO_RECIBO.recibo_id = RECIBO.id
        WHERE EXTRACT(MONTH FROM RECIBO.fecha) = EXTRACT(MONTH FROM anio_mes) AND EXTRACT(YEAR FROM RECIBO.fecha) = EXTRACT(YEAR FROM anio_mes) AND PRODUCTO_RECIBO.producto_id = p_id;
        IF (articulo_vendido IS NULL) THEN
            articulo_vendido := 0;
        END IF;
        RETURN articulo_vendido;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20039, 'Error al obtener articulo vendido');
    END obtener_articulo_vendido_mes;
    
    FUNCTION obtener_producto_recibo_todos RETURN SYS_REFCURSOR AS
        producto_recibo SYS_REFCURSOR;
    BEGIN
        OPEN producto_recibo FOR
        SELECT * FROM PRODUCTO_RECIBO;
        RETURN producto_recibo;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20040, 'Error al obtener producto recibo');
    END obtener_producto_recibo_todos;

    FUNCTION obtener_producto_recibo(p_producto_id NUMBER, p_recibo_id NUMBER) RETURN SYS_REFCURSOR AS
        producto_recibo SYS_REFCURSOR;
    BEGIN
        OPEN producto_recibo FOR
        SELECT * FROM PRODUCTO_RECIBO
        WHERE producto_id = p_producto_id AND recibo_id = p_recibo_id;
        RETURN producto_recibo;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20041, 'Error al obtener producto recibo');
    END obtener_producto_recibo;

    FUNCTION obtener_productos_recibo(p_recibo_id NUMBER) RETURN SYS_REFCURSOR AS
        productos_recibo SYS_REFCURSOR;
    BEGIN
        OPEN productos_recibo FOR
        SELECT * FROM PRODUCTO_RECIBO
        WHERE recibo_id = p_recibo_id;
        RETURN productos_recibo;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20042, 'Error al obtener productos recibo');
    END obtener_productos_recibo;

    FUNCTION obtener_producto_recibos(p_producto_id NUMBER) RETURN SYS_REFCURSOR AS
        producto_recibos SYS_REFCURSOR;
    BEGIN
        OPEN producto_recibos FOR
        SELECT * FROM PRODUCTO_RECIBO
        WHERE producto_id = p_producto_id;
        RETURN producto_recibos;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20043, 'Error al obtener producto recibos');
    END obtener_producto_recibos;

END paquete_select;