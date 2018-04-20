select * from up_storage;#id topicid
select * from up_college;#id college_name storage_id
select * from up_college_dict;#college_id 
select * from up_patent_storage;
insert into up_patent_storage(patent_id,storage_id)
select s1.IDPATENT,{storage_id}
  from st_patentinfo_sub1 s1 
  join st_patentinfo_uid_tmp st on st.IDPATENT = s1.IDPATENT
  where s1.pa like '%西安理工大学%';
select * from sys_account where platform_id =20; 
select * from sys_account_role;
select * from sys_user;
insert into sys_account(prod_type,username,password,salt,name,status,create_time,platform_id,sex) 
 values(2,'njgcxy','uIss8e4XU1zphoesnfarNwzUrlE=','SFez5kL0MZg=','南京工程学院',1,current_time(),20,3);   
insert into sys_account_role(platform_id,account_id,role_id)
 values(20,526,201);  
insert into sys_user(account_id,user_type,college_id,create_time,platform_id,login_times)
 values(526,2,109,current_time(),20,0);