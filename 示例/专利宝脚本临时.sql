select * from sys_account where platform_id=20;
 
select * from sys_account 
where platform_id=20 and name in ('中国药科大学','北京化工大学','中国地质大学（武汉）','华北水利水电大学','河北大学');
select storage_name,topicid from up_storage where id in (39,13,16,21);
#'南京理工大学' '南京工业大学'
select * from up_college where college_name in ('中国药科大学','北京化工大学','中国地质大学（武汉）','华北水利水电大学','河北大学');
#'南京理工大学' '南京工业大学' '南京航空航天大学' '东南大学' 
select * from up_college_dict where name in ('中国药科大学','北京化工大学','中国地质大学（武汉）','华北水利水电大学','河北大学');
select * from up_college_dict where name like '%南京%';


insert into sys_account(prod_type,username,password,salt,name,status,create_time,platform_id,sex) 
 values(2,'njgcxy','uIss8e4XU1zphoesnfarNwzUrlE=','SFez5kL0MZg=','南京工程学院',1,current_time(),20,3);   
insert into sys_account_role(platform_id,account_id,role_id)
 values(20,526,201);  
insert into sys_user(account_id,user_type,college_id,create_time,platform_id,login_times)
 values(526,2,109,current_time(),20,0);
 
 select * from sys_account_role where role_id =201;
 select * from sys_account where name ='南京工程学院';#account_id 526
 select * from up_college where college_name ='南京工程学院';#college_id 109
 select * from sys_user where account_id in (320,371,524,525,526);
 select * from up_storage;
 select college_name,topicid,us.id from up_college uc ,up_storage us where uc.storage_id = us.id
 and uc.college_name in ('中国药科大学','北京化工大学','中国地质大学（武汉）','华北水利水电大学','河北大学');
 
 
 select name '学校名',username '用户名','654321!a' from sys_account where name in ('南京理工大学','南京航空航天大学','南京工业大学','东南大学','南京工程学院','中国药科大学','北京化工大学','中国地质大学（武汉）','华北水利水电大学','河北大学');
  select * from sys_user where platform_id=20;
  update up_storage set topicid ='NzM0JiYmbmxnIyMjMEw0OSVnTUZhYnNNajg0RlA=' where id = 41;  