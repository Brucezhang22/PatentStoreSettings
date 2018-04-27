INSERT INTO `iptp1v`.`sys_account` (`prod_type`, `username`, `password`, `salt`, `name`, `status`, `create_time`, `platform_id`, `sex`) 
VALUES ('2', 'njnydx', 'uIss8e4XU1zphoesnfarNwzUrlE=', 'SFez5kL0MZg=', '南京农业大学', '1', '2018-04-27 09:13:03', '20', '3');


INSERT INTO `sys_user` (`account_id`, `user_type`, `college_id`, `create_time`, `update_time`, `platform_id`, `login_times`) 
VALUES ('653', '2', '21', '2018-04-20 09:30:00', '2018-04-20 09:33:00', '20', '0');


INSERT INTO `sys_account_role` (`platform_id`, `account_id`, `role_id`) VALUES ('20', '653', '201');