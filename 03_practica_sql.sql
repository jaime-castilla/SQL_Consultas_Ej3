--Subconsultas

--Obtener los productos cuyo precio unitario sea mayor al precio promedio de la tabla de productos
select product_id 
from public.products
where unit_price > (select avg(unit_price)
					from public.products)
--Obtener los productos cuya cantidad en stock sea menor al promedio de cantidad en stock de toda la tabla de productos.
select product_id 
from public.products
where units_in_stock < (select avg(units_in_stock) 
						from public.products)			    
--Obtener los productos cuya cantidad en Inventario (UnitsInStock) sea menor a la cantidad mínima del detalle de ordenes (Order Details)
select product_id 
from public.products
where units_in_stock < (select min(quantity) 
						from public.order_details)
--OBTENER LOS PRODUCTOS CUYA CATEGORIA SEA IGUAL A LAS CATEGORIAS DE LOS PRODUCTOS CON PROVEEDOR 1.
select product_id
from public.products
where category_id in (select category_id 
					  from public.products
					  where supplier_id = 1)


--Subconsultas correlacionadas 

--Obtener el número de empleado y el apellido para aquellos empleados que tengan menos de 100 ordenes.
select employee_id, last_name
from public.employees as e
where 100 > (select count(order_id)
			 from public.orders as o
			 where e.employee_id = o.employee_id)
--Obtener la clave de cliente y el nombre de la empresa para aquellos clientes que tengan más de 20 ordenes
select customer_id, company_name
from public.customers as c
where 20 < (select count(order_id)
			from public.orders as o
			where c.customer_id = o.customer_id)
--Obtener el productoid, el nombre del producto, el proveedor de la tabla de productos para aquellos productos -->
-->que se hayan vendido menos de 100 unidades (Consultarlo en la tabla de Orders details).
select product_id, product_name, supplier_id
from public.products  p
where 100 > (select count(quantity)
			 from public.order_details  d
			 where p.product_id = d.product_id)
--Obtener los datos del empleado IDEmpleado y nombre completo De aquellos que tengan mas de 100 ordenes
select employee_id, first_name, last_name
from public.employees as e
where 100 < (select count(order_id)
			 from public.orders as o
			 where e.employee_id = o.employee_id)
--Obtener los datos de Producto ProductId, ProductName, UnitsinStock, UnitPrice (Tabla Products) de los productos --> 
-->que la sumatoria de la cantidad (Quantity) de orders details sea mayor a 450
select product_id, product_name, units_in_stock, unit_price
from public.products as p
where 450 < (select sum(quantity)
			 from public.order_details as d
			 where p.product_id = d.product_id)
--Obtener la clave de cliente y el nombre de la empresa para aquellos clientes que tengan más de 20 ordenes.
select customer_id, company_name
from public.customers as c
where 20 < (select count(order_id)
		    from public.orders as o
		    where c.customer_id = o.customer_id)


--insert

--Insertar un registro en la tabla de Categorias, únicamente se quiere insertar --> 
-->la información del CategoryName y la descripción los Papelería y papelería escolar
insert into categories (category_id, category_name, description) values (10001, 'Papeleria', 'Papeleria escolar')
--Dar de alta un producto con Productname, SupplierId, CategoryId, UnitPrice, UnitsInStock Como esta tabla --> 
-->tiene dos clave foraneas hay que ver los datos a dar de alta
insert into products (product_id, product_name, supplier_id, category_id, unit_price, units_in_stock, discontinued) values (10001, 'Cuadernos', 10, 1, 1, 9000, 0)
--Dar de alta un empleado con LastName, FistName, Title, BrithDate
insert into employees (employee_id, last_name, first_name, title, birth_date) values (10001, 'de Castilla', 'Jaime', 'Manager', '1992-03-10')
--Dar de alta una orden, CustomerId, Employeeid, Orderdate, ShipVia Como esta tabla tiene dos clave foraneas hay que ver los datos a dar de alta
insert into orders (order_id, customer_id, employee_id, order_date, ship_via) values (10001, 'BLAUS', 6, '1992-10-08', 3)
--Dar de alta un Order details, con todos los datos
insert into order_details (order_id, product_id, unit_price, quantity, discount) values (10001, 11, 9, 15, 0)


--update

--0Cambiar el CategoryName a Verduras de la categoria 10
update public.categories
set category_name = 'Verduras'
where category_id = 10
--0Actualizar los precios de la tabla de Productos para incrementarlos un 10%
update public.products
set unit_price = unit_price + (unit_price * 0.1)
--0ACTUALIZAR EL PRODUCTNAME DEL PRODUCTO 80 A ZANAHORIA ECOLOGICA
update public.products
set product_name = 'Zanahoria ecologica'
where product_id = 80
--0ACTUALIZAR EL FIRSTNAME DEL EMPLOYEE 10 A ROSARIO 
update public.employees
set first_name = 'Rosario'
where employee_id = 10
--0ACTUALIZAR EL ORDERS DETAILS DE LA 11079 PARA QUE SU CANTIDAD SEA 10
update public.order_details
set quantity = 10
where order_id = 11079


--Delete

--diferencia entre delete y truncate
--BORRAR EL EMPLEADO 10
delete from public.employees
where employee_id = 10001


