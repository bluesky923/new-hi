create schema `digitak_jsp`;
create database `digital_jsp`;
/*
	insert select update delete
    create read update delete
    crud
*/
create table if not exists member(
	num int primary key auto_increment, 	-- 회원번호
    id varchar(300) not null unique,		-- 회원 아이디
    pass varchar(300) not null, 			-- 비밀번호
    name varchar(50),						-- 이름
    addr varchar(50)						-- 주소	
);

select * from member;

-- table에 값 삽입, insert into table values(값...)
-- num, id pass name addr
insert into member values(null, 'id001','pw001','김동하','광안리');

insert into member(id,pass,name,addr)
values('id002','pw002','iron man','new york');

select * from member order by num desc;

select num, id, name, addr From member order by num desc;

delete from member where id = 'id001';
delete from member where num = 10;

rollback;

select @@autocommit;

set Autocommit = true;

update member set name = 'spider man' , addr =  '퀸즈'
where num = 20;

select * from member;

select * from member where id = '1' and pass = '1';

-- sql injection
-- id001' -- 
-- select * from member where id = 'fdsa'-- ' and pass = 'erwer';

-- prepare execute 문
PREPARE mQuery FROM "SELECT * FROM member WHERE id = ? AND pass = ?";

SET @tempVal1 = '1';
SET @tempVal2 = '1';

execute mQuery using @tempVal1, @tempVal2;

-- Procedure
delimiter $$
	create Procedure logincheck(
		in _id varchar(300),
		in _pass varchar(300)
    )
begin
	SELECT * FROM member WHERE id = _id AND pass = _pass;
end $$
delimiter ;

call logincheck('1','1');