create database hackathon;
use hackathon;

create table Customer(
	customer_id varchar(10) primary key,
    customer_full_name varchar(150) not null,
    customer_email varchar(255) unique,
    customer_address varchar(255) not null 
);
create table Room(
	room_id varchar(10) primary key,
	room_price float,
    room_status enum ("Available", "Booked"),
    room_area int
);
create table Booking(
	booking_id int auto_increment primary key,
    customer_id varchar(10),
    room_id varchar(10),
    check_in_date date not null,
    check_out_date date not null,
    total_amount float,
    foreign key(customer_id) references Customer(customer_id) on delete cascade,
    foreign key(room_id) references Room(room_id) on delete cascade
);

create table Payment(
	payment_id int auto_increment primary key,
    booking_id int not null,
    payment_method varchar(50),
    payment_date date,
    payment_amount float ,
    foreign key(booking_id) references Booking(booking_id) on delete cascade
);
-- PHẦN 2: Thiết kế cơ sở dữ liệu
-- 2. Thêm cột room_type có kiểu dữ liệu là enum gồm các giá trị "single", "double", "suite" trong bảng Room.
alter table Room add column room_type enum("single", "double", "suite");
-- 3. Thêm cột số điện thoại khách hàng (customer_phone) trong bảng Customer có kiểu dữ liệu char(15), có rằng buộc not null và unique.
alter table Customer add column customer_phone varchar(15) not null unique;
-- 4. Thêm ràng buộc cho cột total_amount trong bảng Booking phải có giá trị lớn hơn hoặc bằng 0.
alter table Booking modify column total_amount float check(total_amount > 0);

-- PHẦN 3: Thao tác với dữ liệu các bảng
-- 1. Thêm dữ liệu vào các bảng theo yêu cầu sau
insert into Customer(customer_id, customer_full_name, customer_email, customer_phone, customer_address)
values
("C001", "Nguyen Anh Tu", "tu.nguyen@example.com", "0912345678", "Hanoi, Vietnam"),
("C002", "Tran Thi Mai", "mai.tran@example.com", "0923456789", "Ho Chi Minh, Vietnam"),
("C003", "Le Minh Hoang", "hoang.le@example.com", "0934567890", "Danang, Vietnam"),
("C004", "Pham Hoang Nam", "nam.pham@example.com", "0945678901", "Hue, Vietnam"),
("C005", "Vu Minh Thu", "thu.vu@example.com", "0956789012", "Hai Phong, Vietnam"),
("C006", "Nguyen Thi Lan", "lan.nguyen@example.com", "0967890123", "Quang Ninh, Vietnam"),
("C007", "Bui Minh Tuan", "tuan.bui@example.com", "0978901234", "Bac Giang, Vietnam"),
("C008", "Pham Quang Hieu", "hieu.pham@example.com", "0989012345", "Quang Nam, Vietnam"),
("C009", "Le Thi Lan", "lan.le@example.com", "0990123456", "Da Lat, Vietnam"),
("C010", "Nguyen Thi Mai", "mai.nguyen@example.com", "0901234567", "Can Tho, Vietnam");

insert into Room(room_id, room_type, room_price, room_status, room_area)
values
("R001", "Single", 100.0, "Available", 25),
("R002", "Double", 150.0, "Booked", 40),
("R003", "Suite", 250.0, "Available", 60),
("R004", "Single", 120.0, "Booked", 30),
("R005", "Double", 160.0, "Available", 35);

insert into Booking(booking_id, customer_id, room_id, check_in_date, check_out_date, total_amount)
values
(1, "C001", "R001", "2025-03-01", "2025-03-05", 400.0),
(2, "C002", "R002", "2025-03-02", "2025-03-06", 600.0),
(3, "C003", "R003", "2025-03-03", "2025-03-07", 1000.0),
(4, "C004", "R004", "2025-03-04", "2025-03-08", 480.0),
(5, "C005", "R005", "2025-03-05", "2025-03-09", 800.0),
(6, "C006", "R001", "2025-03-06", "2025-03-10", 400.0),
(7, "C007", "R002", "2025-03-07", "2025-03-11", 600.0),
(8, "C008", "R003", "2025-03-08", "2025-03-12", 1000.0),
(9, "C009", "R004", "2025-03-09", "2025-03-13", 480.0),
(10, "C010", "R005", "2025-03-10", "2025-03-14", 800.0);

insert into Payment(payment_id, booking_id, payment_method, payment_date, payment_amount)
values
(1, 1, "Cash", '2025-03-05', 400.0),
(2, 2, "Credit Card", "2025-03-06", 600.0),
(3, 3, "Bank Transfer", "2025-03-07", 1000.0),
(4, 4, "Cash", "2025-03-08", 480.0),
(5, 5, "Credit Card", "2025-03-09", 800.0),
(6, 6, "Bank Transfer", "2025-03-10", 400.0),
(7, 7, "Cash", "2025-03-11", 600.0),
(8, 8, "Credit Card", "2025-03-12", 1000.0),
(9, 9, "Bank Transfer", "2025-03-13", 480.0),
(10, 10, "Cash", "2025-03-14", 800.0),
(11, 1, "Credit Card", "2025-03-15", 400.0),
(12, 2, "Bank Transfer", "2025-03-16", 600.0),
(13, 3, "Cash", "2025-03-17", 1000.0),
(14, 4, "Credit Card", "2025-03-18", 480.0),
(15, 5, "Bank Transfer", "2025-03-19", 800.0),
(16, 6, "Cash", "2025-03-20", 400.0),
(17, 7, "Credit Card", "2025-03-21", 600.0),
(18, 8, "Bank Transfer", "2025-03-22", 1000.0),
(19, 9, "Cash", "2025-03-23", 480.0),
(20, 10, "Credit Card", "2025-03-24", 800.0);

/*
	2. Viết câu update cho phép cập nhật dữ liệu cho các khách hàng trong bảng Booking
		Công thức tính tổng tiền (total_amount) = giá phòng * số ngày lưu trú.
		Chỉ cập nhật tổng tiền khi trạng thái phòng là "Booked" và ngày nhận phòng (check_in_date) đã qua.
*/
update Booking
join Room on Room.room_id = Booking.room_id
set Booking.total_amount = room_price * (day(Booking.check_out_date) - day(Booking.check_in_date))
where Room.room_id = Booking.room_id;

-- kiểm tra dữ liệu trong bảng Booking
select 
	*
from Booking;

/* 
	3. Xóa các thanh toán trong bảng Payment nếu phương thức thanh toán là "Cash" và tổng tiền thanh toán (payment_amount) nhỏ hơn 500.
*/
delete from Payment
where payment_method = "Cash" and payment_amount < 500;

-- kiểm tra dữ liệu trong bảng Payment
select 
	*
from Payment;

-- PHẦN 4: Truy vấn dữ liệu
-- 1. Lấy thông tin khách hàng gồm mã khách hàng, họ tên, email, số điện thoại và địa chỉ được sắp xếp theo họ tên khách hàng tăng dần.
select 
	customer_id,
    customer_full_name,
    customer_email,
	customer_phone,
    customer_address
from Customer
order by customer_full_name asc;

-- 2. Lấy thông tin các phòng khách sạn gồm mã phòng, loại phòng, giá phòng và diện tích phòng, sắp xếp theo giá phòng giảm dần.
select 
	room_id,
    room_type,
    room_price,
    room_area
from Room
order by room_price desc;

-- 3. Lấy thông tin khách hàng và phòng khách sạn đã đặt, gồm mã khách hàng, họ tên khách hàng, mã phòng, ngày nhận phòng và ngày trả phòng.
select
	Customer.customer_id,
    Customer.customer_full_name,
    Room.room_id,
    Booking.check_in_date,
    Booking.check_out_date
from Customer
join Booking on Customer.customer_id = Booking.customer_id
join Room on Room.room_id = Booking.room_id;

-- 4. Lấy danh sách khách hàng và tổng tiền đã thanh toán khi đặt phòng, gồm mã khách hàng, họ tên khách hàng, phương thức thanh toán và số tiền thanh toán, 
-- sắp xếp theo số tiền thanh toán giảm dần.

select 
    Customer.customer_id,
    Customer.customer_full_name,
    Payment.payment_method,
    Payment.payment_amount
from Customer
join Booking on Customer.customer_id = Booking.customer_id
join Payment on Booking.booking_id = Payment.booking_id
order by Payment.payment_amount desc;

-- 5. Lấy thông tin khách hàng từ vị trí thứ 2 đến thứ 4 trong bảng Customer được sắp xếp theo tên khách hàng.
select 	
	*
from Customer
order by customer_full_name
limit 3 offset 1;

-- 6. Lấy danh sách khách hàng đã đặt ít nhất 2 phòng và có tổng số tiền thanh toán trên 1000, gồm mã khách hàng, họ tên khách hàng và số lượng phòng đã đặt.
select 
    Customer.customer_id,
    Customer.customer_full_name,
    count(Booking.room_id) as total_rooms_booked,
    sum(Payment.payment_amount) as total_payment
from Customer
join Booking on Customer.customer_id = Booking.customer_id
join Payment on Booking.booking_id = Payment.booking_id
group by Customer.customer_id, Customer.customer_full_name
having total_rooms_booked >= 2 and total_payment > 1000;

-- 7. Lấy danh sách các phòng có tổng số tiền thanh toán dưới 1000 và có ít nhất 3 khách hàng đặt, gồm mã phòng, loại phòng, giá phòng và tổng số tiền thanh toán.
select 
    Room.room_id,
    Room.room_type,
    Room.room_price,
    SUM(Payment.payment_amount) as total_payment,
    COUNT(distinct Booking.customer_id) as total_customers
from Room
join Booking on Room.room_id = Booking.room_id
join Payment on Booking.booking_id = Payment.booking_id
group by Room.room_id, Room.room_type, Room.room_price
having total_payment < 1000 and total_customers >= 3;

-- 8. Lấy danh sách các khách hàng có tổng số tiền thanh toán lớn hơn 1000, gồm mã khách hàng, họ tên khách hàng, mã phòng, tổng số tiền thanh toán.
select
	Customer.customer_id,
    Customer.customer_full_name,
    Room.room_id,
    SUM(Payment.payment_amount) AS total_payment
from Room
join Booking on Room.room_id = Booking.room_id
join Payment on Booking.booking_id = Payment.booking_id
join Customer on Customer.customer_id = Booking.customer_id
group by Customer.customer_id, Customer.customer_full_name, Room.room_id
having total_payment > 1000;

-- 9. Lấy danh sách các phòng có số lượng khách hàng đặt nhiều nhất và ít nhất, gồm mã phòng, loại phòng và số lượng khách hàng đã đặt
select
	Room.room_id,
    Room.room_type,
    count(Booking.room_id) as total_rooms_booked
from Booking
join Room on Room.room_id = Booking.room_id
join Customer on Customer.customer_id = Booking.customer_id
group by Room.room_id
having count(Customer.customer_id) = (select count(Booking.room_id) from Booking join Room on Room.room_id = Booking.room_id join Customer on Customer.customer_id = Booking.customer_id group by count(Booking.room_id) desc limit 1);
	
/*
	10. Lấy danh sách các khách hàng có tổng số tiền thanh toán của lần đặt phòng cao hơn số tiền thanh toán trung bình của tất cả các khách hàng cho cùng phòng, 
    gồm mã khách hàng, họ tên khách hàng, mã phòng, tổng tiền thanh toán
*/
select 
	Customer.customer_id, 
    Customer.customer_full_name, 
    Booking.room_id, sum(Payment.payment_amount) as total_payment
from Customer
join Booking on Customer.customer_id = Booking.customer_id
join Payment on Booking.booking_id = Payment.booking_id
join (
    select Booking.room_id, avg(Payment.payment_amount) as avg_payment
    from Booking
    join Payment on Booking.booking_id = Payment.booking_id
    group by Booking.room_id
) as AvgPayment on Booking.room_id = AvgPayment.room_id
group by Customer.customer_id, Customer.customer_full_name, Booking.room_id, AvgPayment.avg_payment
having total_payment > AvgPayment.avg_payment;

-- PHẦN 5: Tạo View
/* 
	1. Hãy tạo một view để lấy thông tin các phòng và khách hàng đã đặt, với điều kiện ngày nhận phòng nhỏ hơn ngày 2025-03-10. Cần hiển thị các thông tin sau: Mã phòng, Loại phòng, Mã khách hàng, 
    họ tên khách hàng
*/
create view View_Room_Customer_Before_March_10 as
select 
    Room.room_id, 
    Room.room_type, 
    Customer.customer_id, 
    Customer.customer_full_name
from Booking
join Room on Booking.room_id = Room.room_id
join Customer on Booking.customer_id = Customer.customer_id
where Booking.check_in_date < '2025-03-10';

/*
	2. Hãy tạo một view để lấy thông tin khách hàng và phòng đã đặt, với điều kiện diện tích phòng lớn hơn 30 m². Cần hiển thị các thông tin sau: Mã khách hàng, Họ tên khách hàng, Mã phòng, 
    Diện tích phòng
*/
create view View_Customer_Large_Room as
select 
    Customer.customer_id, 
    Customer.customer_full_name, 
    Room.room_id, 
    Room.room_area
from Booking
join Room on Booking.room_id = Room.room_id
join Customer on Booking.customer_id = Customer.customer_id
where Room.room_area > 30;

-- PHẦN 6: Tạo Trigger
/*
	1. Hãy tạo một trigger check_insert_booking để kiểm tra dữ liệu mối khi chèn vào bảng Booking. Kiểm tra nếu ngày đặt phòng mà sau ngày trả phòng thì thông báo lỗi với nội dung 
    “Ngày đặt phòng không thể sau ngày trả phòng được !” và hủy thao tác chèn dữ liệu vào bảng.
*/
delimiter //
create trigger check_insert_booking
before insert on Booking
for each row
begin
    if new.booking_date > new.check_out_date then
        signal sqlstate '45000'
        set message_text = 'Ngày đặt phòng không thể sau ngày trả phòng được!';
    end if;
end;
// delimiter ;

/*
	2. Hãy tạo một trigger có tên là update_room_status_on_booking để tự động cập nhật trạng thái phòng thành "Booked" khi một phòng được đặt (khi có bản ghi được INSERT vào bảng Booking).
*/
delimiter //
	create trigger update_room_status_on_booking
    before insert on Booking
    for each row
    begin
		update Room
			set room_status = "Booked"
            where room_id = new.room_id;
    end;
// delimiter ;

-- PHẦN 7: Tạo Store Procedure
-- 1. Viết store procedure có tên add_customer để thêm mới một khách hàng với đầy đủ các thông tin cần thiết.
delimiter //
	create procedure add_customer(
		new_customer_id varchar(10),
        new_customer_full_name varchar(150),
        new_customer_email varchar(255),
        new_customer_phone varchar(15),
        new_customer_address varchar(255)
    )
    begin
		insert into Customer(customer_id, customer_full_name, customer_email, customer_phone , customer_address)
        values
        (new_customer_id, new_customer_full_name, new_customer_email, new_customer_phone, new_customer_address);
    end;
// delimiter ;

call add_customer("C011", "Nguyễn Văn A", "nva@gmail.com", "0355483082" , "ở nhà");
select 
	*
from Customer;

drop procedure add_customer;

/*
	2. Hãy tạo một Stored Procedure  có tên là add_payment để thực hiện việc thêm một thanh toán mới cho một lần đặt phòng.
		Procedure này nhận các tham số đầu vào:
		p_booking_id: Mã đặt phòng (booking_id).
		p_payment_method: Phương thức thanh toán (payment_method).
		p_payment_amount: Số tiền thanh toán (payment_amount).
		p_payment_date: Ngày thanh toán (payment_date).
*/
delimiter //
	create procedure add_payment(
		p_booking_id int,
        p_payment_method varchar(50),
        p_payment_amount float,
        p_payment_date date
    )
    begin 
		update Payment 
			set booking_id = p_booking_id, payment_method = p_payment_method, payment_amount = p_payment_amount, payment_date = p_payment_date
            where p_booking_id in (select booking_id from Payment);
    end;
// delimiter ;
