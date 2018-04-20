select * from up_storage where storage_name in('河北师范大学专题库', '暨南大学专题库','淮海工学院专题库');#88 89 90
select * from up_college where college_name in('河北师范大学', '暨南大学','淮海工学院');#130 131 132
INSERT INTO `up_storage`(`storage_name`, `storage_desc`,`create_user`,`create_time`,`fetch_time`,`fetch_status`,`type`)
	VALUES('河北师范大学专题库','河北师范大学专题库',1,current_time(),current_time(),1,1);
INSERT INTO `up_storage`(`storage_name`, `storage_desc`,`create_user`,`create_time`,`fetch_time`,`fetch_status`,`type`)
	VALUES('暨南大学专题库','暨南大学专题库',1,current_time(),current_time(),1,1);
INSERT INTO `up_storage`(`storage_name`, `storage_desc`,`create_user`,`create_time`,`fetch_time`,`fetch_status`,`type`)
	VALUES('淮海工学院专题库','淮海工学院专题库',1,current_time(),current_time(),1,1);
    
 INSERT INTO `up_college`
( `system_id`,`dept_id`,`college_name`,`short_name`,`description`,`storage_id`,`storage_name`,
`is_show`,`is_storage_open`,`is_goods_share`,`status`,`sign_platform_id`,`sign_platform_name`,
`show_order`,`create_time`,`create_user`,`favorite_count`,`alias_name`)
VALUES
( 10000,1,'河北师范大学','河北师范大学','河北师范大学','88','河北师范大学专题库',
1,1,1,1,10,'中高知识产权运营交易平台',
99,current_time(),1,0,'hbsfdx');
 INSERT INTO `up_college`
( `system_id`,`dept_id`,`college_name`,`short_name`,`description`,`storage_id`,`storage_name`,
`is_show`,`is_storage_open`,`is_goods_share`,`status`,`sign_platform_id`,`sign_platform_name`,
`show_order`,`create_time`,`create_user`,`favorite_count`,`alias_name`)
VALUES
( 10000,1,'暨南大学','暨南大学','暨南大学','89','暨南大学专题库',
1,1,1,1,10,'中高知识产权运营交易平台',
99,current_time(),1,0,'jndx');
 INSERT INTO `up_college`
( `system_id`,`dept_id`,`college_name`,`short_name`,`description`,`storage_id`,`storage_name`,
`is_show`,`is_storage_open`,`is_goods_share`,`status`,`sign_platform_id`,`sign_platform_name`,
`show_order`,`create_time`,`create_user`,`favorite_count`,`alias_name`)
VALUES
( 10000,1,'淮海工学院','淮海工学院','淮海工学院','90','淮海工学院专题库',
1,1,1,1,10,'中高知识产权运营交易平台',
99,current_time(),1,0,'hhgxy');

select * from up_college_dict where name in ('河北师范大学', '暨南大学','淮海工学院');
select * from sys_account where name in('河北师范大学', '暨南大学','淮海工学院');#130 131 132
insert into sys_account(prod_type,username,password,salt,name,status,create_time,platform_id,sex) 
 values(2,'hbsfdx','uIss8e4XU1zphoesnfarNwzUrlE=','SFez5kL0MZg=','河北师范大学',1,current_time(),20,3);   
insert into sys_account_role(platform_id,account_id,role_id)
 values(20,583,201);  
insert into sys_user(account_id,user_type,college_id,create_time,platform_id,login_times)
 values(583,2,130,current_time(),20,0);
 
insert into sys_account(prod_type,username,password,salt,name,status,create_time,platform_id,sex) 
 values(2,'jndx','uIss8e4XU1zphoesnfarNwzUrlE=','SFez5kL0MZg=','暨南大学',1,current_time(),20,3);   
insert into sys_account_role(platform_id,account_id,role_id)
 values(20,584,201);  
insert into sys_user(account_id,user_type,college_id,create_time,platform_id,login_times)
 values(584,2,131,current_time(),20,0);
 
insert into sys_account(prod_type,username,password,salt,name,status,create_time,platform_id,sex) 
 values(2,'hhgxy','uIss8e4XU1zphoesnfarNwzUrlE=','SFez5kL0MZg=','淮海工学院',1,current_time(),20,3);   
insert into sys_account_role(platform_id,account_id,role_id)
 values(20,585,201);  
insert into sys_user(account_id,user_type,college_id,create_time,platform_id,login_times)
 values(585,2,132,current_time(),20,0);

#
insert into up_patent_storage(patent_id,storage_id)
select s1.IDPATENT,88
  from st_patentinfo_sub1 s1 
  join st_patentinfo_uid_tmp st on st.IDPATENT = s1.IDPATENT
  where s1.pa like '%河北师范大学%';
  
insert into up_patent_storage(patent_id,storage_id)
select s1.IDPATENT,89
  from st_patentinfo_sub1 s1 
  join st_patentinfo_uid_tmp st on st.IDPATENT = s1.IDPATENT
  where s1.pa like '%暨南大学%';
  
insert into up_patent_storage(patent_id,storage_id)
select s1.IDPATENT,90
  from st_patentinfo_sub1 s1 
  join st_patentinfo_uid_tmp st on st.IDPATENT = s1.IDPATENT
  where s1.pa like '%淮海工学院%';
select * from up_patent_storage where storage_id in(88,89,90);


select username '用户名','624341!a',name '高校名称' from sys_account where name in('河北师范大学', '暨南大学','淮海工学院');#130 131 132
select * from sys_user where account_id >=583