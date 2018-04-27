INSERT INTO `iptp1v`.`up_storage` (`storage_name`, `st_storage_id`, `storage_no`, `storage_desc`, `create_user`, `create_time`, `fetch_time`, `fetch_status`, `type`, `total_pat_cnt`, `valid_pat_cnt`) VALUES ('河海大学题库', '99', '99', '河海大学题库', '1', '2018-04-20 13:40:39', '2018-04-20 13:40:39', '1', '1', '0', '0');


UPDATE `iptp1v`.`up_college` SET `system_id`='10000', `dept_id`='1', `storage_id`='99', `storage_name`='河海大学题库', `is_show`='1', `is_storage_open`='1', `is_goods_share`='1', `sign_platform_name`='中国高校知识产权运营平台', `show_order`='99', `alias_name`='hhdx' WHERE `id`='56';


insert into up_patent_storage(patent_id,storage_id)
select s1.IDPATENT,99
  from st_patentinfo_sub1 s1 
  join st_patentinfo_uid_tmp st on st.IDPATENT = s1.IDPATENT
  where s1.pa like '%河海大学%';


INSERT INTO `iptp1v`.`sys_account` (`prod_type`, `username`, `password`, `salt`, `name`, `status`, `create_time`, `platform_id`, `sex`) VALUES ('2', 'hhdx', 'uIss8e4XU1zphoesnfarNwzUrlE=', 'SFez5kL0MZg=', '河海大学', '1', '2018-04-27 09:13:03', '20', '3');


INSERT INTO `sys_user` (`account_id`, `user_type`, `college_id`, `create_time`, `update_time`, `platform_id`, `login_times`) 
VALUES ('651', '2', '56', '2018-04-20 09:30:00', '2018-04-20 09:33:00', '20', '0');


INSERT INTO `sys_account_role` (`platform_id`, `account_id`, `role_id`) VALUES ('20', '651', '201');