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
    fecha_ultima_compra DATE NOT NULL,
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
    id NUMBER(10) NOT NULL,
    producto_id NUMBER(10) NOT NULL,
    recibo_id NUMBER(10) NOT NULL,
    cantidad NUMBER(10) NOT NULL,
    CONSTRAINT pk_producto_recibo PRIMARY KEY(id),
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
CREATE SEQUENCE seq_producto_recibo START WITH 1 INCREMENT BY 1;
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

-- Create package for the tables PRODUCTOS, CLIENTE, RECIBO, and PROVEEDOR to INSERT, UPDATE, and DELETE:

CREATE OR REPLACE PACKAGE paquete_modificar AS
    PROCEDURE insertar_producto(nombre VARCHAR2, descripcion VARCHAR2, precio NUMBER, categoria_id VARCHAR2, inventario NUMBER);
    PROCEDURE actualizar_producto(id NUMBER, nombre VARCHAR2, descripcion VARCHAR2, precio NUMBER, categoria_id VARCHAR2, inventario NUMBER);
    PROCEDURE eliminar_producto(id NUMBER);
    PROCEDURE insertar_cliente(nombre VARCHAR2, fecha_ultima_compra DATE, correo VARCHAR2, direccion VARCHAR2, cantidad_compras NUMBER);
    PROCEDURE actualizar_cliente(id NUMBER, nombre VARCHAR2, fecha_ultima_compra DATE, correo VARCHAR2, direccion VARCHAR2, cantidad_compras NUMBER);
    PROCEDURE eliminar_cliente(id NUMBER);
    PROCEDURE insertar_recibo(fecha DATE, cliente_id NUMBER);
    PROCEDURE actualizar_recibo(id NUMBER, fecha DATE, cliente_id NUMBER);
    PROCEDURE eliminar_recibo(id NUMBER);
    PROCEDURE insertar_proveedor(nombre VARCHAR2, descripcion VARCHAR2, direccion VARCHAR2);
    PROCEDURE actualizar_proveedor(id NUMBER, nombre VARCHAR2, descripcion VARCHAR2, direccion VARCHAR2);
    PROCEDURE eliminar_proveedor(id NUMBER);

    -- recibo detalle, compra_producto, compra_detalle
    PROCEDURE insertar_recibo_detalle(recibo_id NUMBER, monto NUMBER, cantidad NUMBER, metodo_pago VARCHAR2, descripcion VARCHAR2);
    PROCEDURE actualizar_recibo_detalle(id NUMBER, recibo_id NUMBER, monto NUMBER, cantidad NUMBER, metodo_pago VARCHAR2, descripcion VARCHAR2);
    PROCEDURE eliminar_recibo_detalle(id NUMBER);
    PROCEDURE insertar_recibo_completo(fecha DATE, cliente_id NUMBER, monto NUMBER, cantidad NUMBER, metodo_pago VARCHAR2, descripcion VARCHAR2);
    PROCEDURE insertar_compra_producto(producto_id NUMBER, proveedor_id NUMBER, fecha DATE);
    PROCEDURE actualizar_compra_producto(id NUMBER, producto_id NUMBER, proveedor_id NUMBER, fecha DATE);
    PROCEDURE eliminar_compra_producto(id NUMBER);
    PROCEDURE insertar_compra_detalle(compra_producto_id NUMBER, cantidad NUMBER, monto NUMBER, descripcion VARCHAR2);
    PROCEDURE actualizar_compra_detalle(id NUMBER, compra_producto_id NUMBER, cantidad NUMBER, monto NUMBER, descripcion VARCHAR2);
    PROCEDURE eliminar_compra_detalle(id NUMBER);
    PROCEDURE insertar_compra_producto_completo(producto_id NUMBER, proveedor_id NUMBER, fecha DATE, cantidad NUMBER, monto NUMBER, descripcion VARCHAR2);
END;

-- Create package for the tables PRODUCTOS, BITACORA_PRODUCTO, CLIENTE, RECIBO, and PROVEEDOR to SELECT:

CREATE OR REPLACE PACKAGE paquete_select AS
    FUNCTION obtener_productos RETURN SYS_REFCURSOR;
    FUNCTION obtener_producto(id NUMBER) RETURN SYS_REFCURSOR;
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
    FUNCTION obtener_articulos_vendido_mes(mes NUMBER) RETURN SYS_REFCURSOR; -- retorna la cantidad vendida por mes por producto
    FUNCTION obtener_articulo_vendido_mes(id NUMBER, mes NUMBER) RETURN NUMBER; -- retorna la cantidad vendidad de un producto en el último mes (utilizar algún tipo de join)
END;

-- Create package body (with exceptions management) for the tables PRODUCTOS, CLIENTE, RECIBO, and PROVEEDOR to INSERT, UPDATE, and DELETE:

CREATE OR REPLACE PACKAGE BODY paquete_modificar AS 
    PROCEDURE insertar_producto(nombre VARCHAR2, descripcion VARCHAR2, precio NUMBER, categoria_id VARCHAR2, inventario NUMBER) AS
    BEGIN
        INSERT INTO PRODUCTO(id, nombre, descripcion, precio, categoria_id, inventario)
        VALUES(seq_producto.NEXTVAL, nombre, descripcion, precio, categoria_id, inventario);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20001, 'Error al insertar producto');
    END insertar_producto;

    PROCEDURE actualizar_producto(id NUMBER, nombre VARCHAR2, descripcion VARCHAR2, precio NUMBER, categoria_id VARCHAR2, inventario NUMBER) AS
    BEGIN
        UPDATE PRODUCTO
        SET nombre = nombre, descripcion = descripcion, precio = precio, categoria_id = categoria_id, inventario = inventario
        WHERE id = id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'Error al actualizar producto');
    END actualizar_producto;

    PROCEDURE eliminar_producto(id NUMBER) AS
    BEGIN
        DELETE FROM PRODUCTO
        WHERE id = id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20003, 'Error al eliminar producto');
    END eliminar_producto;

    PROCEDURE insertar_cliente(nombre VARCHAR2, fecha_ultima_compra DATE, correo VARCHAR2, direccion VARCHAR2, cantidad_compras NUMBER) AS
    BEGIN
        INSERT INTO CLIENTE(id, nombre, fecha_ultima_compra, correo, direccion, cantidad_compras)
        VALUES(seq_cliente.NEXTVAL, nombre, fecha_ultima_compra, correo, direccion, cantidad_compras);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20004, 'Error al insertar cliente');
    END insertar_cliente;

    PROCEDURE actualizar_cliente(id NUMBER, nombre VARCHAR2, fecha_ultima_compra DATE, correo VARCHAR2, direccion VARCHAR2, cantidad_compras NUMBER) AS
    BEGIN
        UPDATE CLIENTE
        SET nombre = nombre, fecha_ultima_compra = fecha_ultima_compra, correo = correo, direccion = direccion, cantidad_compras = cantidad_compras
        WHERE id = id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20005, 'Error al actualizar cliente');
    END actualizar_cliente;

    PROCEDURE eliminar_cliente(id NUMBER) AS
    BEGIN
        DELETE FROM CLIENTE
        WHERE id = id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20006, 'Error al eliminar cliente');
    END eliminar_cliente;

    PROCEDURE insertar_recibo(fecha DATE, cliente_id NUMBER) AS
    BEGIN
        INSERT INTO RECIBO(id, fecha, cliente_id)
        VALUES(seq_recibo.NEXTVAL, fecha, cliente_id);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20007, 'Error al insertar recibo');
    END insertar_recibo;

    PROCEDURE actualizar_recibo(id NUMBER, fecha DATE, cliente_id NUMBER) AS
    BEGIN
        UPDATE RECIBO
        SET fecha = fecha, cliente_id = cliente_id
        WHERE id = id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20008, 'Error al actualizar recibo');
    END actualizar_recibo;

    PROCEDURE eliminar_recibo(id NUMBER) AS
    BEGIN
        DELETE FROM RECIBO
        WHERE id = id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20009, 'Error al eliminar recibo');
    END eliminar_recibo;

    PROCEDURE insertar_proveedor(nombre VARCHAR2, descripcion VARCHAR2, direccion VARCHAR2) AS
    BEGIN
        INSERT INTO PROVEEDOR(id, nombre, descripcion, direccion)
        VALUES(seq_proveedor.NEXTVAL, nombre, descripcion, direccion);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20010, 'Error al insertar proveedor');
    END insertar_proveedor;

    PROCEDURE actualizar_proveedor(id NUMBER, nombre VARCHAR2, descripcion VARCHAR2, direccion VARCHAR2) AS
    BEGIN
        UPDATE PROVEEDOR
        SET nombre = nombre, descripcion = descripcion, direccion = direccion
        WHERE id = id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20011, 'Error al actualizar proveedor');
    END actualizar_proveedor;

    PROCEDURE eliminar_proveedor(id NUMBER) AS
    BEGIN
        DELETE FROM PROVEEDOR
        WHERE id = id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20012, 'Error al eliminar proveedor');
    END eliminar_proveedor;

    PROCEDURE insertar_recibo_detalle(recibo_id NUMBER, monto NUMBER, cantidad NUMBER, metodo_pago VARCHAR2, descripcion VARCHAR2) AS
    BEGIN
        INSERT INTO RECIBO_DETALLE(id, recibo_id, monto, cantidad, metodo_pago, descripcion)
        VALUES(seq_recibo_detalle.NEXTVAL, recibo_id, monto, cantidad, metodo_pago, descripcion);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20013, 'Error al insertar recibo detalle');
    END insertar_recibo_detalle;

    PROCEDURE actualizar_recibo_detalle(id NUMBER, recibo_id NUMBER, monto NUMBER, cantidad NUMBER, metodo_pago VARCHAR2, descripcion VARCHAR2) AS
    BEGIN
        UPDATE RECIBO_DETALLE
        SET recibo_id = recibo_id, monto = monto, cantidad = cantidad, metodo_pago = metodo_pago, descripcion = descripcion
        WHERE id = id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20014, 'Error al actualizar recibo detalle');
    END actualizar_recibo_detalle;

    PROCEDURE eliminar_recibo_detalle(id NUMBER) AS
    BEGIN
        DELETE FROM RECIBO_DETALLE
        WHERE id = id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20015, 'Error al eliminar recibo detalle');
    END eliminar_recibo_detalle;

    PROCEDURE insertar_recibo_completo(fecha DATE, cliente_id NUMBER, monto NUMBER, cantidad NUMBER, metodo_pago VARCHAR2, descripcion VARCHAR2) AS
    BEGIN
        INSERT INTO RECIBO(id, fecha, cliente_id)
        VALUES(seq_recibo.NEXTVAL, fecha, cliente_id);
        INSERT INTO RECIBO_DETALLE(id, recibo_id, monto, cantidad, metodo_pago, descripcion)
        VALUES(seq_recibo_detalle.NEXTVAL, seq_recibo.CURRVAL, monto, cantidad, metodo_pago, descripcion);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20016, 'Error al insertar recibo completo');
    END insertar_recibo_completo;

    PROCEDURE insertar_compra_producto(producto_id NUMBER, proveedor_id NUMBER, fecha DATE) AS
    BEGIN
        INSERT INTO COMPRA_PRODUCTO(id, producto_id, proveedor_id, fecha)
        VALUES(seq_compra_producto.NEXTVAL, producto_id, proveedor_id, fecha);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20017, 'Error al insertar compra producto');
    END insertar_compra_producto;

    PROCEDURE actualizar_compra_producto(id NUMBER, producto_id NUMBER, proveedor_id NUMBER, fecha DATE) AS
    BEGIN
        UPDATE COMPRA_PRODUCTO
        SET producto_id = producto_id, proveedor_id = proveedor_id, fecha = fecha
        WHERE id = id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20018, 'Error al actualizar compra producto');
    END actualizar_compra_producto;

    PROCEDURE eliminar_compra_producto(id NUMBER) AS
    BEGIN
        DELETE FROM COMPRA_PRODUCTO
        WHERE id = id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20019, 'Error al eliminar compra producto');
    END eliminar_compra_producto;

    PROCEDURE insertar_compra_detalle(compra_producto_id NUMBER, cantidad NUMBER, monto NUMBER, descripcion VARCHAR2) AS
    BEGIN
        INSERT INTO COMPRA_DETALLE(id, compra_producto_id, cantidad, monto, descripcion)
        VALUES(seq_compra_detalle.NEXTVAL, compra_producto_id, cantidad, monto, descripcion);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20020, 'Error al insertar compra detalle');
    END insertar_compra_detalle;

    PROCEDURE actualizar_compra_detalle(id NUMBER, compra_producto_id NUMBER, cantidad NUMBER, monto NUMBER, descripcion VARCHAR2) AS
    BEGIN
        UPDATE COMPRA_DETALLE
        SET compra_producto_id = compra_producto_id, cantidad = cantidad, monto = monto, descripcion = descripcion
        WHERE id = id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20021, 'Error al actualizar compra detalle');
    END actualizar_compra_detalle;

    PROCEDURE eliminar_compra_detalle(id NUMBER) AS
    BEGIN
        DELETE FROM COMPRA_DETALLE
        WHERE id = id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20022, 'Error al eliminar compra detalle');
    END eliminar_compra_detalle;

    PROCEDURE insertar_compra_producto_completo(producto_id NUMBER, proveedor_id NUMBER, fecha DATE, cantidad NUMBER, monto NUMBER, descripcion VARCHAR2) AS 
    BEGIN
        INSERT INTO COMPRA_PRODUCTO(id, producto_id, proveedor_id, fecha)
        VALUES(seq_compra_producto.NEXTVAL, producto_id, proveedor_id, fecha);
        INSERT INTO COMPRA_DETALLE(id, compra_producto_id, cantidad, monto, descripcion)
        VALUES(seq_compra_detalle.NEXTVAL, seq_compra_producto.CURRVAL, cantidad, monto, descripcion);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20023, 'Error al insertar compra producto completo');
    END insertar_compra_producto_completo;

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

    FUNCTION obtener_producto(id NUMBER) RETURN SYS_REFCURSOR AS
        producto SYS_REFCURSOR;
    BEGIN
        OPEN producto FOR
        SELECT * FROM PRODUCTO
        WHERE id = id;
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

    FUNCTION obtener_articulos_vendido_mes(mes NUMBER) RETURN SYS_REFCURSOR AS
        articulos_vendido_mes SYS_REFCURSOR;
    BEGIN
        OPEN articulos_vendido_mes FOR
        SELECT PRODUCTO.id, PRODUCTO.nombre, SUM(PRODUCTO_RECIBO.cantidad) AS cantidad_vendida
        FROM PRODUCTO
        INNER JOIN PRODUCTO_RECIBO
        ON PRODUCTO.id = PRODUCTO_RECIBO.producto_id
        INNER JOIN RECIBO
        ON PRODUCTO_RECIBO.recibo_id = RECIBO.id
        WHERE EXTRACT(MONTH FROM RECIBO.fecha) = mes
        GROUP BY PRODUCTO.id, PRODUCTO.nombre;
        RETURN articulos_vendido_mes;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20038, 'Error al obtener articulos vendido por el mes');
    END obtener_articulos_vendido_mes;

    FUNCTION obtener_articulo_vendido_mes(id NUMBER, mes NUMBER) RETURN NUMBER AS
        articulo_vendido_mes NUMBER;
    BEGIN
        SELECT SUM(PRODUCTO_RECIBO.cantidad) INTO articulo_vendido_mes
        FROM PRODUCTO
        INNER JOIN PRODUCTO_RECIBO
        ON PRODUCTO.id = PRODUCTO_RECIBO.producto_id
        INNER JOIN RECIBO
        ON PRODUCTO_RECIBO.recibo_id = RECIBO.id
        WHERE PRODUCTO.id = id AND EXTRACT(MONTH FROM RECIBO.fecha) = mes;
        RETURN articulo_vendido_mes;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20039, 'Error al obtener articulo vendido por el mes');
    END obtener_articulo_vendido_mes;

END paquete_select;