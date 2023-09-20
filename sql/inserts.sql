-- Antonio
BEGIN
    INSERT INTO CLIENTE VALUES (seq_cliente.NEXTVAL, 'Pedro Perez', DATE '2023-05-05', 'pedro@gmail.com', 'Grecia Centro', 79);
    INSERT INTO CLIENTE VALUES (seq_cliente.NEXTVAL, 'Juan Paez', DATE '2023-05-05', 'juan@gmail.com', 'Grecia Centro', 69);
    INSERT INTO CLIENTE VALUES (seq_cliente.NEXTVAL, 'Julio Asir', DATE '2023-05-07', 'julio@gmail.com', 'Grecia Centro', 89);
    INSERT INTO CLIENTE VALUES (seq_cliente.NEXTVAL, 'Vardimir Yusuf', DATE '2023-02-05', 'tusuf@gmail.com', 'Grecia Centro', 10);
    INSERT INTO CLIENTE VALUES (seq_cliente.NEXTVAL, 'Isaias Reque', DATE '2023-05-01', 'reque@gmail.com', 'Grecia Centro', 99);
    INSERT INTO CLIENTE VALUES (seq_cliente.NEXTVAL, 'Manuel Calderon', DATE '2023-03-05', 'manuel@gmail.com', 'Grecia Centro', 69);
    INSERT INTO CLIENTE VALUES (seq_cliente.NEXTVAL, 'Melvin Ramirez', DATE '2023-05-09', 'mel@gmail.com', 'Grecia Centro', 10);
    INSERT INTO CLIENTE VALUES (seq_cliente.NEXTVAL, 'Koky Saldo', DATE '2023-02-05', 'koky@gmail.com', 'Grecia Centro', 12);
    INSERT INTO CLIENTE VALUES (seq_cliente.NEXTVAL, 'Probabilidad Fernandez', DATE '2023-05-05', 'proba@gmail.com', 'Grecia Centro', 80);
    INSERT INTO CLIENTE VALUES (seq_cliente.NEXTVAL, 'Fundamentos Charpentier', DATE '2023-04-05', 'funda@gmail.com', 'Grecia Centro', 56);
    INSERT INTO CLIENTE VALUES (seq_cliente.NEXTVAL, 'Arquitectura Gomez', DATE '2023-05-08', 'arqui@gmail.com', 'Grecia Centro', 23);
    INSERT INTO CLIENTE VALUES (seq_cliente.NEXTVAL, 'Tzu Rue', DATE '2023-09-05', 'tzurue@gmail.com', 'Grecia Centro', 12);
    INSERT INTO CLIENTE VALUES (seq_cliente.NEXTVAL, 'Algebra Gonzales', DATE '2023-05-01', 'alge@gmail.com', 'Grecia Centro', 90);
    INSERT INTO CLIENTE VALUES (seq_cliente.NEXTVAL, 'Discreta Alvarez', DATE '2023-05-01', 'discreta@gmail.com', 'Grecia Centro', 67);
    INSERT INTO CLIENTE VALUES (seq_cliente.NEXTVAL, 'Volador Enriquez', DATE '2023-08-02', 'volador@gmail.com', 'Grecia Centro', 11);
    INSERT INTO CLIENTE VALUES (seq_cliente.NEXTVAL, 'Manrique Lopez', DATE '2023-01-01', 'manriquito@gmail.com', 'Grecia Centro', 78);
    INSERT INTO CLIENTE VALUES (seq_cliente.NEXTVAL, 'Kosta Latysh', DATE '2023-03-03', 'kosta@gmail.com', 'Grecia Centro', 12);
    INSERT INTO CLIENTE VALUES (seq_cliente.NEXTVAL, 'Yargen Humberto', DATE '2023-05-01', 'yargen@gmail.com', 'Grecia Centro', 44);
    INSERT INTO CLIENTE VALUES (seq_cliente.NEXTVAL, 'Leonardo Hulio', DATE '2023-02-02', 'leonardo@gmail.com', 'Grecia Centro', 90);
    INSERT INTO CLIENTE VALUES (seq_cliente.NEXTVAL, 'Erling Lopez', DATE '2023-02-05', 'erling@gmail.com', 'Grecia Centro', 290);
    INSERT INTO CLIENTE VALUES (seq_cliente.NEXTVAL, 'Manfred Messi', DATE '2023-05-01', 'godfred@gmail.com', 'Grecia Centro', 80);
    INSERT INTO CLIENTE VALUES (seq_cliente.NEXTVAL, 'Alejandro Ronaldo', DATE '2023-09-01', 'ale@gmail.com', 'Grecia Centro', 71);
    INSERT INTO CLIENTE VALUES (seq_cliente.NEXTVAL, 'Federico Roman', DATE '2023-05-09', 'fede@gmail.com', 'Grecia Centro', 123);
    INSERT INTO CLIENTE VALUES (seq_cliente.NEXTVAL, 'Julian Nuñez', DATE '2023-02-08', 'julia@gmail.com', 'Grecia Centro', 6);
    INSERT INTO CLIENTE VALUES (seq_cliente.NEXTVAL, 'Maria Messi', DATE '2023-01-05', 'maria@gmail.com', 'Grecia Centro', 100);
    INSERT INTO CLIENTE VALUES (seq_cliente.NEXTVAL, 'Danna Porras', DATE '2023-05-01', 'danna@gmail.com', 'Grecia Centro', 12);
    INSERT INTO CLIENTE VALUES (seq_cliente.NEXTVAL, 'Bad Bunny', DATE '2023-03-05', 'chambea@gmail.com', 'Grecia Centro', 90);
    INSERT INTO CLIENTE VALUES (seq_cliente.NEXTVAL, 'Juan Balvin', DATE '2023-02-05', 'jbalvin@gmail.com', 'Grecia Centro', 4);
    INSERT INTO CLIENTE VALUES (seq_cliente.NEXTVAL, 'Maluma Baby', DATE '2023-02-09', 'maluma@gmail.com', 'Grecia Centro', 69);
    INSERT INTO CLIENTE VALUES (seq_cliente.NEXTVAL, 'Maripaz Cespedes', DATE '2023-02-05', 'koky@gmail.com', 'Grecia Centro', 55);

    INSERT INTO PROVEEDOR VALUES (seq_proveedor.NEXTVAL, 'Quesos Rubi', 'Trae quesos', 'Alajuela centro');
    INSERT INTO PROVEEDOR VALUES (seq_proveedor.NEXTVAL, 'Carnes San Jose', 'Trae carnes', 'San Jose centro');
    INSERT INTO PROVEEDOR VALUES (seq_proveedor.NEXTVAL, 'Electronicos Luisito', 'Trae aparatos electronicos', 'Grecia, Alajuela');
    INSERT INTO PROVEEDOR VALUES (seq_proveedor.NEXTVAL, 'Papas El carton', 'Proveedor de papas', 'Grecia, Alajuela');
    INSERT INTO PROVEEDOR VALUES (seq_proveedor.NEXTVAL, 'Carnes San Carlos', 'Trae carnes de San Carlos', 'San Carlos, Alajuela');
    INSERT INTO PROVEEDOR VALUES (seq_proveedor.NEXTVAL, 'Leche San Osito', 'Trae lacteos', 'Cartago centro');
    INSERT INTO PROVEEDOR VALUES (seq_proveedor.NEXTVAL, 'Arroces el Burro', 'Proveedor de arroz', 'Puntarenas centro');
    INSERT INTO PROVEEDOR VALUES (seq_proveedor.NEXTVAL, 'Frijolera Ruiz', 'Proveedor de frijoles', 'San Ramon, Alajuela');
    INSERT INTO PROVEEDOR VALUES (seq_proveedor.NEXTVAL, 'Mantequillas San Humberto', 'Trae mantequillas', 'Barva, Heredia');
    INSERT INTO PROVEEDOR VALUES (seq_proveedor.NEXTVAL, 'Tortillera El maicito', 'Proveedor de tortillas', 'San Carlos, Alajuela');
    INSERT INTO PROVEEDOR VALUES (seq_proveedor.NEXTVAL, 'Especias Marito', 'Proveedor de especias', 'San Jose centro');
    INSERT INTO PROVEEDOR VALUES (seq_proveedor.NEXTVAL, 'Filtros el Hugo', 'Trae filtros para cafeteras', 'Guanacaste');
    INSERT INTO PROVEEDOR VALUES (seq_proveedor.NEXTVAL, 'Chapstick Life', 'Proveedor de chapsticks', 'Alajuela, centro');
    INSERT INTO PROVEEDOR VALUES (seq_proveedor.NEXTVAL, 'Lapiceros Manuelito', 'Proveedor de lapiceros', 'Escazú, San José');
    INSERT INTO PROVEEDOR VALUES (seq_proveedor.NEXTVAL, 'Fundas CeluWorld', 'Proveedor de fundas para telefono', 'Heredia centro');
    INSERT INTO PROVEEDOR VALUES (seq_proveedor.NEXTVAL, 'Frescos La hortaliza', 'Trae refescos variados', 'San Carlos, Alajuela');
    INSERT INTO PROVEEDOR VALUES (seq_proveedor.NEXTVAL, 'Cafes el grano', 'Proveedor de cafes', 'San Jose centro');
    INSERT INTO PROVEEDOR VALUES (seq_proveedor.NEXTVAL, 'Cafes el Cafe', 'Proveedor de cafes', 'Pavas, San José');
    INSERT INTO PROVEEDOR VALUES (seq_proveedor.NEXTVAL, 'Grapas el grapon', 'Proveedor de grapas', 'San Jose centro');
    INSERT INTO PROVEEDOR VALUES (seq_proveedor.NEXTVAL, 'Borradores Lucho', 'Proveedor de borradores', 'Santo Domingo, Heredia');
    INSERT INTO PROVEEDOR VALUES (seq_proveedor.NEXTVAL, 'Paquetillos el enamorado', 'Proveedor de de tostadospaquetillos ', 'San Luis, Grecia');
    INSERT INTO PROVEEDOR VALUES (seq_proveedor.NEXTVAL, 'Caramelos el dulce', 'Proveedor de caramelos', 'San Jose centro');
    INSERT INTO PROVEEDOR VALUES (seq_proveedor.NEXTVAL, 'Confites el Ruso', 'Proveedor de confites rusos', 'San Jose centro');
    INSERT INTO PROVEEDOR VALUES (seq_proveedor.NEXTVAL, 'Porcelana la Porcelana fina', 'Proveedor de porcelana', 'Leon 13');
    INSERT INTO PROVEEDOR VALUES (seq_proveedor.NEXTVAL, 'Relojes el Reoljito', 'Proveedor de relojes', 'San Ramon, Alajuela');
    INSERT INTO PROVEEDOR VALUES (seq_proveedor.NEXTVAL, 'Yucas la Fortuna', 'Proveedor de caramelos', 'La fortuna');
    INSERT INTO PROVEEDOR VALUES (seq_proveedor.NEXTVAL, 'Paperia las papitas', 'Proveedor de papas', 'Cartago');
    INSERT INTO PROVEEDOR VALUES (seq_proveedor.NEXTVAL, 'Carnes la Chuleteria', 'Trae chuketas', 'San Jose centro');
    INSERT INTO PROVEEDOR VALUES (seq_proveedor.NEXTVAL, 'Pipo Pages', 'Trae hojas', 'San Jose centro');
    INSERT INTO PROVEEDOR VALUES (seq_proveedor.NEXTVAL, 'El manjar del perro', 'Trae comida de perros', 'Grecia, Alajuela');
    INSERT INTO PROVEEDOR VALUES (seq_proveedor.NEXTVAL, 'El manjar del gato', 'Trae comida de gatos', 'San Jose centro');



    -- Josué
    --Categorías

    INSERT INTO CATEGORIA  VALUES ('Electrónica', 'Productos electrónicos para el consumo diario.'); 
    INSERT INTO CATEGORIA  VALUES ('Ropa', 'Ropa y accesorios de moda para hombres y mujeres.');
    INSERT INTO CATEGORIA  VALUES ('Calzado', 'Calzado de diversos estilos y tallas.');
    INSERT INTO CATEGORIA  VALUES ('Electrodomésticos', 'Electrodomésticos para el hogar');
    INSERT INTO CATEGORIA  VALUES ('Joyería', 'Joyas y bisutería');
    INSERT INTO CATEGORIA  VALUES ('Muebles', 'Muebles y decoración para el hogar.');
    INSERT INTO CATEGORIA  VALUES ('Productos de Belleza', 'Productos de cuidado personal y belleza.');
    INSERT INTO CATEGORIA  VALUES ('Juguetes', 'Juguetes para niños.');
    INSERT INTO CATEGORIA  VALUES ('Librería', 'Productos para estudio u oficina.');
    INSERT INTO CATEGORIA  VALUES ('Deportivo', 'Artículos para deporte');
    INSERT INTO CATEGORIA  VALUES ('Carnes', 'Productos hechos de carne');
    INSERT INTO CATEGORIA  VALUES ('Bebés', 'Productos para bebés y cuidado infantil.');
    INSERT INTO CATEGORIA  VALUES ('Bebidas', 'Productos que se consumen tomandolo');
    INSERT INTO CATEGORIA  VALUES ('Ferretería', 'Herramientas y suministros de ferretería.');
    INSERT INTO CATEGORIA  VALUES ('Mariscos', 'Productos provenientes del mar');
    INSERT INTO CATEGORIA  VALUES ('Limpieza', 'Productos de limpieza');
    INSERT INTO CATEGORIA  VALUES ('Snacks', 'Productos para picar');
    INSERT INTO CATEGORIA  VALUES ('Jardinería', 'Suministros y herramientas para jardinería.');
    INSERT INTO CATEGORIA  VALUES ('Mascotas', 'Suministros y alimentos para mascotas.');
    INSERT INTO CATEGORIA  VALUES ('Congelados', 'Productos congelados');
    INSERT INTO CATEGORIA  VALUES ('Instrumentos Musicales', 'Instrumentos musicales y accesorios.');
    INSERT INTO CATEGORIA  VALUES ('Sexo', 'Productos relacionado al coito');
    INSERT INTO CATEGORIA  VALUES ('Cocina', 'Utensilios y productos para cocina.');
    INSERT INTO CATEGORIA  VALUES ('Dulces', 'Confites, chocolates, etc...');
    INSERT INTO CATEGORIA  VALUES ('Fiesta', 'Suministros para fiestas y eventos especiales.');
    INSERT INTO CATEGORIA  VALUES ('Embutidos', 'Productos embutidos');
    INSERT INTO CATEGORIA  VALUES ('Frutas', 'Frutas para la familia');
    INSERT INTO CATEGORIA  VALUES ('Vegetales', 'Verduras para la familia');
    INSERT INTO CATEGORIA  VALUES ('Enlatados', 'Productos que vienen en una lata');
    INSERT INTO CATEGORIA  VALUES ('Lácteos', 'Productos provenientes de la leche');

    -- Productos


    INSERT INTO PRODUCTO VALUES (seq_producto.NEXTVAL, 'Samsung 78', 'Teléfono móvil inteligente', 250000 , 'Electrónica', 15);
    INSERT INTO PRODUCTO VALUES (seq_producto.NEXTVAL, 'Vestido Shein', 'Elegante vestido de noche', 15000, 'Ropa', 32);
    INSERT INTO PRODUCTO VALUES (seq_producto.NEXTVAL, 'Naik', 'Calzado deportivo para correr y hacer ejercicio', 35000, 'Calzado', 5);
    INSERT INTO PRODUCTO VALUES (seq_producto.NEXTVAL, 'Refrigerador Samsung', 'Refrigerador de gran capacidad', 650000, 'Electrodomésticos', 3);
    INSERT INTO PRODUCTO VALUES (seq_producto.NEXTVAL, 'Anillo de plata', 'Anillo con plata de alta calidad', 80000, 'Joyería', 2);
    INSERT INTO PRODUCTO VALUES (seq_producto.NEXTVAL, 'Sofá', 'Sofá de cuero de lujo', 350000, 'Muebles', 1);
    INSERT INTO PRODUCTO VALUES (seq_producto.NEXTVAL, 'Crema Hidratante', 'Crema hidratante para el cuidado de la piel', 13000, 'Productos de Belleza', 67);
    INSERT INTO PRODUCTO VALUES (seq_producto.NEXTVAL, 'Blocks', 'Set de construcción de bloques para niños', 10000, 'Juguetes', 43);
    INSERT INTO PRODUCTO VALUES (seq_producto.NEXTVAL, 'Cuaderno de Notas', 'Cuaderno de notas para tomar apuntes', 3000, 'Librería', 13);
    INSERT INTO PRODUCTO VALUES (seq_producto.NEXTVAL, 'Balón de Fútbol', 'Balón de fútbol oficial', 20000, 'Deportivo', 17);
    INSERT INTO PRODUCTO VALUES (seq_producto.NEXTVAL, 'Filete de Res', 'Filete de res de primera calidad', 2000, 'Carnes', 120);
    INSERT INTO PRODUCTO VALUES (seq_producto.NEXTVAL, 'Pañales para Bebés', 'Pañales desechables para bebés', 24000, 'Bebés', 23);
    INSERT INTO PRODUCTO VALUES (seq_producto.NEXTVAL, 'Vino Tinto', 'Botella de vino tinto de alta calidad', 50000, 'Bebidas', 20);
    INSERT INTO PRODUCTO VALUES (seq_producto.NEXTVAL, 'Martillo', 'Herramienta para clavar', 7000, 'Ferretería', 100);
    INSERT INTO PRODUCTO VALUES (seq_producto.NEXTVAL, 'Camarones Frescos', 'Camarones frescos para cocinar', 16000, 'Mariscos', 30);
    INSERT INTO PRODUCTO VALUES (seq_producto.NEXTVAL, 'Detergente Líquido', 'Detergente líquido para lavar ropa', 5000, 'Limpieza', 14);
    INSERT INTO PRODUCTO VALUES (seq_producto.NEXTVAL, 'Papiola', 'Chips de papas crujientes y sabrosos', 300, 'Snacks', 300);
    INSERT INTO PRODUCTO VALUES (seq_producto.NEXTVAL, 'Tijeras', 'Tijeras para jardín', 4500, 'Jardinería', 12);
    INSERT INTO PRODUCTO VALUES (seq_producto.NEXTVAL, 'Alimento para Gatos', 'Alimento de alta calidad para gatos', 3600, 'Mascotas', 25);
    INSERT INTO PRODUCTO VALUES (seq_producto.NEXTVAL, 'Pizza Congelada', 'Pizza congelada para una cena rápida', 3000, 'Congelados', 60);
    INSERT INTO PRODUCTO VALUES (seq_producto.NEXTVAL, 'Flauta', 'Flauta para músicos aficionados', 15000, 'Instrumentos Musicales', 15);
    INSERT INTO PRODUCTO VALUES (seq_producto.NEXTVAL, 'Condones', 'Condones de calidad para la protección', 2500, 'Sexo', 200);
    INSERT INTO PRODUCTO VALUES (seq_producto.NEXTVAL, 'Cuchillo', 'Cuchillo para cocinar', 5500, 'Cocina', 40);
    INSERT INTO PRODUCTO VALUES (seq_producto.NEXTVAL, 'Barra de Chocolate', 'Barra de chocolate suizo premium', 1500, 'Dulces', 25);
    INSERT INTO PRODUCTO VALUES (seq_producto.NEXTVAL, 'Globos', 'Globos para fiestas', 2500, 'Fiesta', 26);
    INSERT INTO PRODUCTO VALUES (seq_producto.NEXTVAL, 'Salchichas Ahumadas', 'Salchichas ahumadas para parrilladas', 4500, 'Embutidos', 50);
    INSERT INTO PRODUCTO VALUES (seq_producto.NEXTVAL, 'Manzanas', 'Manzanas frescas y crujientes', 1000, 'Frutas', 200);
    INSERT INTO PRODUCTO VALUES (seq_producto.NEXTVAL, 'Zanahorias', 'Zanahorias orgánicas', 1250, 'Vegetales', 96);
    INSERT INTO PRODUCTO VALUES (seq_producto.NEXTVAL, 'Atún', 'Atún de agua', 400, 'Enlatados', 56);
    INSERT INTO PRODUCTO VALUES (seq_producto.NEXTVAL, 'Leche Entera', 'Leche entera fresca y nutritiva', 1700, 'Lácteos', 80);

    INSERT INTO USUARIO(nombre, passhash1, passhash2, nivel) VALUES('admin', 133524947, 894447882, 1);

    COMMIT;
END;