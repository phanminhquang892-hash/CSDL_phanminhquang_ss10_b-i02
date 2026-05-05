create database b1;
use b1;

create table Patients (
    Patient_ID int primary key,
    Full_Name varchar(100),
    Age int,
    Room_Number int,
    HIV_Status varchar(50),
    Mental_Health_History varchar(255)
);

-- chèn dữ liệu mẫu
insert into Patients (Patient_ID, Full_Name, Age, Room_Number, HIV_Status, Mental_Health_History)
values
(1, 'Minh Thu', 30, 101, 'Negative', 'None'),
(2, 'Hồng Vân', 40, 102, 'Positive', 'Anxiety'),
(3, 'Cao Cường', 25, 103, 'Negative', 'None');

-- tạo view bảo mật
create view Reception_Patient_View as
select Patient_ID, Full_Name, Age, Room_Number
from Patients
where Age >= 0
with check option;

-- kiểm tra view 
select * from Reception_Patient_View;

-- update hợp lệ 
update Reception_Patient_View
set Age = 35
where Patient_ID = 1;

-- update không hợp lệ 
update Reception_Patient_View
set Age = -5
where Patient_ID = 2;

drop database b1;