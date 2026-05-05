create database b2;
use b2;

-- tạo bảng
create table Patients (
    Patient_ID int auto_increment primary key,
    Full_Name varchar(100),
    Phone varchar(20),
    Age int,
    Address varchar(255)
);

-- procedure chèn 500k dữ liệu
delimiter //
create procedure SeedPatients()
begin
    declare i int default 1;
    while i <= 500000 do
        insert into Patients (Full_Name, Phone, Age, Address)
        values (
            concat('Patient ', i),
            concat('090', lpad(i,7,'0')),
            floor(rand()*100),
            'HCM'
        );
        set i = i + 1;
    end while;
end //
delimiter ;
call SeedPatients();

-- TEST SELECT (chưa index)

select * from Patients where Phone = '0900001000';
explain select * from Patients where Phone = '0900001000';

-- TẠO INDEX
create index idx_phone on Patients(Phone);

-- TEST SELECT (có index)

select * from Patients where Phone = '0900001000';
explain select * from Patients where Phone = '0900001000';

-- TEST INSERT 1000 DÒNG

delimiter //
create procedure Insert1000()
begin
    declare i int default 1;
    while i <= 1000 do
        insert into Patients (Full_Name, Phone, Age, Address)
        values (
            concat('Test ', i),
            concat('091', lpad(i,7,'0')),
            floor(rand()*100),
            'HN'
        );
        set i = i + 1;
    end while;
end //
delimiter ;

-- chạy khi CÓ index
call Insert1000();

-- xóa index
drop index idx_phone on Patients;

-- chạy khi KHÔNG index
call Insert1000();