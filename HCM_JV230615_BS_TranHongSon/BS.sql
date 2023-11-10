DROP DATABASE IF EXISTS test;
CREATE DATABASE IF NOT EXISTS test;
USE test;

-- I. Thiết kế CSDL
-- YC1: Sử dụng câu lệnh để tạo database và các bảng có cấu trúc như sau: (30đ)

-- 1. Bảng categories:
create table categories(
id int auto_increment primary key,
`name` varchar(100) not null unique,
`status` tinyint default 0
);

-- 2. Bảng products
create table products(
id int auto_increment primary key,
`name` varchar(200) not null ,
`price` float not null ,
`image` varchar(200) ,
`category_id` int,
foreign key (category_id) references categories(id)
);

-- 3. Bảng customers
create table customers(
id int auto_increment primary key,
`name` varchar(100) not null ,
`email` varchar(100) not null unique,
`image` varchar(200) ,
`birthday` date,
`gender` tinyint 
);

-- 4. Bảng orders
create table orders(
id int auto_increment primary key,
`customer_id` int,
foreign key (customer_id) references customers(id),
`created` timestamp default now(),
`status` tinyint default 0
);

-- 5. Bảng order_details
create table order_details(
`order_id` int,
foreign key (order_id) references orders(id),
`product_id` int,
foreign key (product_id) references products(id),
`quantity` int not null,
`price` int not null
);

-- YC2: Sử dụng câu lệnh thêm dữ liệu vào các bảng như sau: (10đ).

-- 1. Bảng categories:
insert into categories(name, status) values 
('Áo', 1), ('Quần', 1), ('Mũ', 1), ('Giày', 1);

-- 2. Bảng products
insert into products(name, category_id, price) values 
('Áo sơ mi', 1, 150000), ('Áo khoác dạ', 1, 500000), ('Quần Kaki', 2, 200000),
('Giày tây', 4, 1000000), ('Mũ bảo hiểm A1', 3, 100000);

-- 3. Bảng customers
insert into customers(name, email, birthday, gender) values 
('Nguyễn Minh Khôi', 'khoi@gmail.com', '2021-12-21', 1),
('Nguyễn Khánh Linh', 'linh@gmail.com', '2001-12-12', 0),
('Đỗ Khánh Linh', 'linh2@gmail.com', '1999-01-01', 0);


-- 4. Bảng orders
insert into orders(customer_id, created, status) values 
(1, '2023-11-08', 0),
(2, '2023-11-09', 0),
(1, '2023-11-09', 0),
(3, '2023-11-09', 0);

-- 5. Bảng order_details
insert into order_details values 
(1, 1, 1, 149000),
(1, 2, 1, 499000),
(2, 2, 2, 499000),
(3, 2, 1, 499000),
(4, 1, 1, 149000);

-- II. Thực hiện các truy vấn dữ liệu.(60đ)

-- 1. Hiển thị danh sách danh mục gồm id,name,status (3đ).
select id, name, status from categories;

-- 2. Hiển thị danh sách sản phẩm gồm id,name,price,sale_price,category_name(têndanh mục) (7đ).
select p.id, p.name, p.price, c.name  from products p join categories c on p.category_id = c.id;

-- 3. Hiển thị danh sách sản phẩm có giá lớn hơn 200000 (5đ).
select * from products where price > 200000;

-- 4. Hiển thị 3 sản phẩm có giá cao nhất (5đ).
select * from products order by price desc limit 3;

-- 5. Hiển thị danh sách đơn hàng gồm id,customer_name,created,status.(5đ)
select o.id, c.name, o.created, o.status from orders o join customers c on c.id = o.customer_id;

-- 6. Cập nhật trạng thái đơn hàng có id là 1(5đ)
update orders set status = 1 where id = 1;

-- 7. Hiển thị chi tiết đơn hàng của đơn hàng có id là 1, bao gồm
-- order_id,product_name,quantity,price,total_money là giá trị của (price * quantity)(10đ)
select od.order_id, p.name, od.quantity, od.price, od.price * od.quantity as total_money from order_details od join products p on od.product_id = p.id where od.order_id = 1;

-- 8. Danh sách danh mục gồm, id,name, quantity_product(đếm trong bảng product) (20đ)
select c.id, c.name, count(*) as quantity_product from categories c join products p on c.id = p.category_id group by c.id;