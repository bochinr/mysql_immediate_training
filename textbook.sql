-- textbook数据库创建示例
create database textbook character set gbk;
use textbook;

-- 设置客户端默认字符集
SET @saved_cs_client = @@character_set_client;
SET @@character_set_client = gbk;

-- 出版社信息
create table publisher
(
	pub_id int primary key auto_increment,
	pub_name varchar(50) not null,
	contacter varchar(30) not null,
	mobile varchar(12) not null
)ENGINE=InnoDB DEFAULT CHARSET=gbk;

set names gbk;
insert into publisher(pub_name,contacter,mobile) values('清华大学出版社','尚小云','13588889999');
insert into publisher(pub_name,contacter,mobile) values('电子工业出版社','廖时飞','13588887777');
insert into publisher(pub_name,contacter,mobile) values('人民邮电出版社','宋凌枫','13588886666');
insert into publisher(pub_name,contacter,mobile) values('人民教育出版社','刘小纳','13588885555');

-- 课程信息
create table course
(
	course_id int primary key auto_increment,
	course_name varchar(50) not null,
	period int default 0,
	credit int default 0
)ENGINE=InnoDB DEFAULT CHARSET=gbk;

set names gbk;
insert into course(course_name,period,credit) values('高等数学Ⅰ',102,5);
insert into course(course_name,period,credit) values('数据结构',72,4);
insert into course(course_name,period,credit) values('数据库原理与应用',72,4);
insert into course(course_name,period,credit) values('程序设计基础',72,4);

-- 教材信息
create table book
(
	book_id int primary key auto_increment,
	book_name varchar(50) not null,
	isbn varchar(18) not null,
	price float not null default 0.0,
	pub_date datetime not null,
	warehousing_date datetime not null,
	author varchar(50) not null,
    	inventory int not null default 0,
	pub_id int default 0,
	course_id int default 0,
	constraint fk_book_publisher foreign key(pub_id) references publisher(pub_id),
	constraint fk_book_course foreign key(course_id) references course(course_id)
)ENGINE=InnoDB DEFAULT CHARSET=gbk;

set names gbk;
insert into book(book_name,isbn,price,pub_date, warehousing_date,inventory,author,pub_id,course_id) values('数据结构教程','978-7-115-45789-7',58.5,'2020-12-08', '2022-08-26',100,'宋立本',1,2);
insert into book(book_name,isbn,price,pub_date, warehousing_date,inventory,author,pub_id,course_id) values('数据库系统原理','978-7-115-45657-3',48.0,'2021-03-12', '2022-08-26',200,'梁知敏',2,3);
insert into book(book_name,isbn,price,pub_date, warehousing_date,inventory,author,pub_id,course_id) values('C语言程序设计教程','978-7-121-44449-7',65.0,'2021-08-28', '2022-08-26',300,'宋立本',1,4);
insert into book(book_name,isbn,price,pub_date, warehousing_date,inventory,author,pub_id,course_id) values('高等数学（上）','978-7-121-54875-3',65.0,'2020-05-18', '2022-08-26',400,'韓立',1,1);

-- 系统角色
create table role
(
	role_id int primary key auto_increment,
	role_name varchar(50) not null
)ENGINE=InnoDB DEFAULT CHARSET=gbk;

set names gbk;
insert into role(role_name) values('系统管理员');
insert into role(role_name) values('业务管理员');
insert into role(role_name) values('教师');

-- 系统用户
create table user
(
	user_id int primary key auto_increment,
	login_name varchar(50) not null unique,
	password varchar(50) not null,
	user_name varchar(50) not null,
	mobile char(11) not null
)ENGINE=InnoDB DEFAULT CHARSET=gbk;

set names gbk;
insert into user(login_name,password,user_name,mobile) values('admin', '888888', '张安亮', '13535553658');
insert into user(login_name,password,user_name,mobile) values('szhou', '888888', '周远方', '13568975588');
insert into user(login_name,password,user_name,mobile) values('tfeng', '888888', '冯伟才', '13825479652');
insert into user(login_name,password,user_name,mobile) values('tlin', '888888', '林卫海', '13568975426');

-- 用户和角色关联表
create table user_role(
    user_id int not null,
    role_id int not null,
    constraint pk_user_role primary key(user_id,role_id),
    constraint fk_user_role_user foreign key(user_id) references user(user_id),
    constraint fk_user_role_role foreign key(role_id) references role(role_id)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

set names gbk;
insert into user_role values(1,1);
insert into user_role values(1,2);
insert into user_role values(2,2);
insert into user_role values(2,3);
insert into user_role values(3,3);
insert into user_role values(4,3);


-- 教材发放
create table distribute_book
(
	book_id int,
	user_id int,
	distribute_date datetime not null,
	distribute_count int default 0,
	constraint fk_user_book_book foreign key(book_id) references book(book_id),
	constraint fk_user_book_user foreign key(user_id) references user(user_id),
    constraint pk_user_book primary key(book_id,user_id)
)ENGINE=InnoDB DEFAULT CHARSET=gbk;

set names gbk;
insert into distribute_book values(1,1,'2022-07-28',51);
insert into distribute_book values(2,1,'2022-07-28',38);
insert into distribute_book values(3,2,'2022-06-26',2);

-- 教材申请及审批
create table apply_book	 
(
	book_id int,
	user_id int,
	apply_date datetime not null,	-- 申请日期
	apply_count int default 0,	-- 申请教材数量
	apply_status int default 0, 	-- 0表示未审批；1表示已审批
	approver int,	-- 审批人
	approve_date datetime,	-- 审批日期
	constraint fk_apply_book_book foreign key(book_id) references book(book_id),
	constraint fk_apply_book_user foreign key(user_id) references user(user_id),
	constraint fk_apply_book_user_approver foreign key(approver) references user(user_id),
    constraint pk_user_book primary key(book_id,user_id)
)ENGINE=InnoDB DEFAULT CHARSET=gbk;

set names gbk;
insert into apply_book(book_id,user_id,apply_date,apply_count,approver,approve_date) values(1,1,'2022-07-28',51,1,'2022-11-28');
insert into apply_book(book_id,user_id,apply_date,apply_count,approver,approve_date) values(2,1,'2022-07-28',38,2,'2022-11-12');
insert into apply_book(book_id,user_id,apply_date,apply_count,approver,approve_date) values(3,2,'2022-06-26',2,1,'2022-12-05');

-- 恢复客户端默认字符集
SET @@character_set_client = @saved_cs_client;
