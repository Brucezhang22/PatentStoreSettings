INSERT INTO `iptp1v`.`up_storage` (`storage_name`, `st_storage_id`, `storage_no`, `storage_desc`, `create_user`, `create_time`, `fetch_time`, `fetch_status`, `type`, `total_pat_cnt`, `valid_pat_cnt`, `topicid`) VALUES ('南陵旺科知识产权运营有限公司题库', '95', '95', '南陵旺科知识产权运营有限公司题库', '1', '2018-04-20 09:18:00', '2018-04-20 09:18:00', '1', '1', '0', '0', 'ODI9JiYmbmxnIyMjMEw0OSVnTUZhYnNNajg0RlA=');


INSERT INTO `iptp1v`.`up_college` (`system_id`, `dept_id`, `college_name`, `short_name`, `description`, `storage_id`, `storage_name`, `is_show`, `is_storage_open`, `is_goods_share`, `status`, `sign_platform_id`, `sign_platform_name`, `show_order`, `create_time`, `create_user`, `update_time`, `favorite_count`, `alias_name`) VALUES ('10000', '1', '南陵旺科知识产权运营有限公司', '南陵旺科知识产权运营有限公司', '南陵旺科知识产权运营有限公司', '95', '南陵旺科知识产权运营有限公司题库', '1', '1', '1', '1', '10', '中高知识产权运营交易平台', '99', '2018-04-20 09:23:09', '1', '2018-04-20 09:23:09', '0', 'nlwkzscqyxgs');


insert into up_patent_storage(patent_id,storage_id)
select s1.IDPATENT,95
  from st_patentinfo_sub1 s1 
  join st_patentinfo_uid_tmp st on st.IDPATENT = s1.IDPATENT
  where s1.pa like '%南陵旺科知识产权运营有限公司%';


INSERT INTO `iptp1v`.`sys_account` (`prod_type`, `username`, `password`, `salt`, `name`, `status`, `create_time`, `platform_id`, `sex`) VALUES ('2', 'nlwkzscqyyyxgs', 'uIss8e4XU1zphoesnfarNwzUrlE=', 'SFez5kL0MZg=', '南陵旺科知识产权运营有限公司', '1', '2018-04-20 09:13:03', '20', '3');


INSERT INTO `sys_user` (`account_id`, `user_type`, `college_id`, `create_time`, `update_time`, `platform_id`, `login_times`) VALUES ('618', '2', '147', '2018-04-20 09:30:00', '2018-04-20 09:33:00', '20', '0');


INSERT INTO `sys_account_role` (`platform_id`, `account_id`, `role_id`) VALUES ('20', '618', '201');