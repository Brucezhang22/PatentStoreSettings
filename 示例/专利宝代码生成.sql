 #专利宝新建流程： 建仓库up_storage->
			    建高校up_college->
                设置高校对应专利up_college_patent->
                建高校登录账号（sys_account）->
                分配权限（sys_account_role）->
                建高校对应用户(sys_user)->
                更新高校up_college_dict 对应college_id
 #中高仓库系统里面的仓库
 select * from storage where name like '%北京大学%';#该表废弃
 #专利宝映射仓库 st_storage_id 10000031986925 调中高仓库获取分析url     ----------------需要改造----------------------
 #up_storage 上加个字段直接调用url 
 #http://58.213.198.76:4/thirdparty/topic/NTUyJiYmbmxnIyMjMEw0OSVnTUZhYnNNajg0RlA=
 #url http://58.213.198.76:4/thirdparty/topic/ 
 #实例 NTUyJiYmbmxnIyMjMEw0OSVnTUZhYnNNajg0RlA=
 select * from up_storage where storage_name like '%北京大学%'; 
 #专利宝加up_storage
 INSERT INTO `up_storage`(`storage_name`, `storage_desc`,`create_user`,`create_time`,`fetch_time`,`fetch_status`,`type`)
                  VALUES('{}专题库','{}专题库',1,current_time(),current_time(),1,1);
 UPDATE up_storage SET st_storage_id = {id},storage_no={id} where id = {id};  
 update up_storage set topicid ='' where id = {id};
 
  update up_storage 
    set analysis_url_pre ='http://58.213.198.76:4/thirdparty/topic/',
		topicid='NTUyJiYmbmxnIyMjMEw0OSVnTUZhYnNNajg0RlA='
   where id = 25;
 #专利宝高校
 select * from up_college where college_name like '%北京大学%';
   
 #专利宝加高校
 INSERT INTO `up_college`
( `system_id`,`dept_id`,`college_name`,`short_name`,`description`,`storage_id`,`storage_name`,
`is_show`,`is_storage_open`,`is_goods_share`,`status`,`sign_platform_id`,`sign_platform_name`,
`show_order`,`create_time`,`create_user`,`favorite_count`,`alias_name`)
VALUES
( 10000,1,'{college_name}','{short_name}','{描述}','{storage_id}','{storage_name}',
1,1,1,1,10,'中高知识产权运营交易平台',
99,current_time(),1,0,'{alias_name}');
 #专利宝高校对应专利
 select count(*) from up_patent_storage where storage_id =25;
 #加专利宝高校对应专利up_patent_storage
 insert into up_patent_storage(patent_id,storage_id)
 select idpatent ,{storage_id}
   from st_patentinfo
  where sectionname in ('SYXX','WGZL','FMSQ')
    and pa like '%%'
  
insert into up_patent_storage(patent_id,storage_id)
 select w.idpatent  ,{storage_id}
   from st_patentinfo w 
  where w.sectionname in ('FMZL')
    and w.pa like '%北京大学%' 
    and  not exists(
		select n.an
	   from st_patentinfo n
	  where n.sectionname in ('FMSQ')
		and n.pa like '%北京大学%' 
        and n.an = w.an
    );
 
  select distinct  sectionname
    from st_patentinfo where pa like '%北京大学%'
 
 #select table_name,column_name,column_comment from information_schema.COLUMNS where table_name=upper('up_college');
 #select * from sys_platform
 #专利宝账号 prod_type 1 个人会员 2企业会员 3专家会员 4 高校会员
 select * from sys_account where platform_id =20;
 #加专利宝账号 默认密码123456
 insert into sys_account(prod_type,username,password,salt,name,status,create_time,platform_id,sex)
 #values(2,'onKAPwJvDezD9FYFmOt5s2q/Zm0=','UZUAnuWkQk0=','{name}',1,current_time(),20,3); 
 values(2,'','SFez5kL0MZg=','{name}',1,current_time(),20,3); 

 #加专利宝账号对应角色
 insert into sys_account_role(platform_id,accout_id,role_id)
 values(20,'{sys_accout_id}',201);
 #加专利宝账号对应用户 login_times =0 初次登陆
 insert into sys_user(account_id,user_type,college_id,create_time,platform_id,login_times)
 values('{sys_accout_id}',2,'{college_id}',current_time(),20,0);
 
 
 
 
 
 #
 #加专利宝高校对应专利up_patent_storage
 select * from up_patent_storage;
 select * from up_college; 
 select * from up_storage;
 
 select * from up_college_dict where college_id is not null;
 select * from sys_user where account_id = 300;
 select table_name,column_name,column_comment from information_schema.COLUMNS where table_name=upper('up_college');
 select *  from sys_platform;
select * from up_college_dict ud,sys_data_dict sd
 where key_id =110 and ud.province = sd.value;
select * 
  from sys_data_dict sd
left join up_college_dict ud on key_id =110 and ud.province = sd.value

select w.idpatent,w.an
   from st_patentinfo w 
  where w.sectionname in ('FMZL') 
    and not exists(
		select n.an
	   from st_patentinfo n
	  where n.sectionname in ('FMSQ') 
        and n.an = w.an
    );

 select idpatent,an
   from st_patentinfo
  where sectionname in ('SYXX','WGZL','FMSQ') ;
insert into st_patentinfo_uid_tmp(idpatent,an)
 select w.idpatent,w.an
   from st_patentinfo w 
  where w.sectionname in ('FMZL') 
    and not exists(
		select n.an
	   from st_patentinfo n
	  where n.sectionname in ('FMSQ') 
        and n.an = w.an
    );