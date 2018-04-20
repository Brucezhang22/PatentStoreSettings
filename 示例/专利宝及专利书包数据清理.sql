#select * from st_patentinfo_ext;
#select table_name,column_name,column_comment from information_schema.COLUMNS where table_name=upper('st_patentinfo_ext');
#此版本主要是做替换操作 
#不做清除
#重命名接口表
rename table st_patentinfo_sub1         to st_patentinfo_sub1_rename;
rename table st_patentinfo_sub3         to st_patentinfo_sub3_rename;
rename table st_legalstatusinfo         to st_legalstatusinfo_rename;
rename table st_patfeeinfo              to st_patfeeinfo_rename;
rename table st_patprsexploitationinfo  to st_patprsexploitationinfo_rename;
rename table st_patprspreservationinfo  to st_patprspreservationinfo_rename;
rename table st_patprstransferinfo      to st_patprstransferinfo_rename;
rename table st_scoreinfo               to st_scoreinfo_rename;
#重新导入数据
  #通过navicat 
  #或者后台mysql dump 导入导出
#清理数据


#清理
#生成单专利唯一可用ID
select * from st_patentinfo_sub1;
drop table st_patentinfo_uid_tmp;
CREATE TABLE `st_patentinfo_uid_tmp` (
  `IDPATENT` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键', 
  `AN` varchar(20) DEFAULT NULL COMMENT '申请号', 
  PRIMARY KEY (`IDPATENT`), 
  KEY `ANINDEX` (`AN`) USING BTREE 
) ENGINE=InnoDB AUTO_INCREMENT=2283371 DEFAULT CHARSET=utf8;

insert into st_patentinfo_uid_tmp(idpatent,an)
select w.idpatent,w.an
 from st_patentinfo w,(select an,max(pd) pd
						 from st_patentinfo
					   group by an)n
 where w.an = n.an 
   and w.pd = n.pd;
 					 
#select idpatent from st_patentinfo_uid_tmp group by an having count(*)>=2
#select * from st_patentinfo_sub1 where an ='CN86103008';
#select * from st_patentinfo_uid_tmp where an ='CN86103008';
#去重
/*delete from st_patentinfo_uid_tmp 
 where idpatent in
(select idpatent 
 from st_patentinfo_sub1 
 where idpatent in (select idpatent from st_patentinfo_uid_tmp group by an having count(*)>=2 ) 
  and  sectionname ='FMZL');*/
  
delete from st_patentinfo_uid_tmp 
 where idpatent in( 305511,305513,305515,305540,320664,320665,320666,320667,320668,320669,320670,320685,320713,320854,320861,320863,320976,321035
,321050,321131,321150,502156,561740,690699,779557,1139729,1139731,1139735,1139743,1139750,1139759,1139882,1550491,1684552,1950239);
 
#清理专利书包 
#清理专利宝   
#清理专利宝 专利书包共有数据 
#select table_name,column_name,column_comment from information_schema.COLUMNS where table_name=upper('up_goods'); 
select table_name,column_name,column_comment
 from information_schema.columns 
where column_name like '%idpatent%'
or column_name like '%patentid%'
or column_name like '%patid%'
or column_name like '%patent_id%'
or column_name like '%id_patent%';

#c_开头内容管理
#select* from c_taxonomy; #如行业新闻 产业动态  政策法规
#select* from c_comment;#评论 未使用
#select* from c_content;#文章 type 类型
#select* from c_template;#模板定义
#select* from c_template_file;#具体模板
#select* from c_attachment;#附件  一般都是上传 
#主机建了NFS同一目录           ***
#静态资源如成果转化UPYUN 小梅   ***
#select* from c_map_content_taxonomy;#文章与分类的关联alter

#统计表 
#指导价 相关评分，相同评分范围内 最高价格 最低价格 查看价格
#select* from dim_account_create_time;#计算中间表
#select* from dim_goods_price;#计算中间表


#egg_未用
#select * from egg_data_cube;
#select * from egg_datasource;
#select * from egg_query_config;

#cnipr同步完成改这边状态
#select * from job_cnipr;#同步cnipr 任务，然后kettle 后异部跑任务 status 0  1
#同步cnipr 任务，然后kettle 后异部跑任务  ***

#临时表
#select* from maxpdan;

#op_同步用的 未使用

#play 自己建的 
#SELECT * FROM iptp.play_evolutions;

#pmes 
select * from op_evaluate_attr;
select * from op_evaluate_value;
select * from op_pmes_evaluate;
select * from origin_pmes_evaluate ;
#放弃
rename table op_evaluate_attr to op_evaluate_attr_rename_for_drop;
rename table op_evaluate_value to op_evaluate_value_rename_for_drop;
rename table op_pmes_evaluate to op_pmes_evaluate_rename_for_drop;
rename table origin_pmes_evaluate to origin_pmes_evaluate_rename_for_drop;





#update origin_pmes_evaluate w  set w.IDPATENT = (select n.IDPATENT from st_patentinfo_sub1 n where n.sysid =w.sysid);
 
#爬虫
select * from patent_fee_future;
select * from patent_fee_future_task;
delete from patent_fee_future;
delete from patent_fee_future_task;

#接口：手工同步
select * from pmes_evaluate; 
update pmes_evaluate w
  set w.idpatent = (select n.idpatent from st_patentinfo_sub1 n where n.sysid= w.sysid ) ;
select * from pmes_evaluate_value;
update pmes_evaluate_value w
  set w.idpatent = (select n.idpatent from st_patentinfo_sub1 n where n.sysid= w.sysid ) ;
#st使用
#接口问题  *** 
#手工同步
select * from storage;#专题库 idstorage
#select * from st_patentinfo_sub1;
#select * from st_patentinfo_sub3;#sub1 sub3 建了视图
#select * from st_patfeeinfo;
#select * from st_patprsexploitationinfo;
#select * from st_patprspreservationinfo;
#select * from st_patprstransferinfo;
#select * from st_legalstatusinfo;
#select * from st_scoreinfo;
select * from st_patentinfo_ext where is_signed is not null or is_goods is not null;
select count(*) from st_patentinfo_ext;#409721 
#清理非高校数据
delete ww from st_patentinfo_ext ww
where not exists (select * 
                    from st_patentinfo_sub1_rename s ,st_patentinfo_uid_tmp su
				   where s.IDPATENT = ww.IDPATENT 
					 and s.an = su.an );
#更新高校专利                      
update st_patentinfo_ext w
  set w.idpatent = (select su.IDPATENT
                      from st_patentinfo_sub1_rename s,st_patentinfo_uid_tmp su
					 where s.IDPATENT = w.IDPATENT
                       and s.an =  su.an);
#补高校专利
INSERT INTO `st_patentinfo_ext`(`IDPATENT`,`AN_LATEST`,`is_signed`,`is_goods`)
select su.idpatent,1,0,0
  from st_patentinfo_uid_tmp su 
where not exists(select * from st_patentinfo_ext n where n.idpatent = su.idpatent);                        
 
#放弃
select * from st_analyse;
select * from st_collect;
select * from st_history;
select * from sto_and_pat;
select * from st_patentassign;
#select * from st_patent_fees_deadline;
#rename table st_patent_fees_deadline_rename_for_drop to st_patent_fees_deadline;

select * from stpool_and_pat;
select * from st_poolassign;
select * from st_sub_patentinfo;
select * from st_xmlfile;

rename table st_analyse to st_analyse_rename_for_drop;
rename table st_collect to st_collect_rename_for_drop;
rename table st_history to st_history_rename_for_drop;
rename table sto_and_pat to sto_and_pat_rename_for_drop;
rename table st_patentassign to st_patentassign_rename_for_drop;
rename table stpool_and_pat to stpool_and_pat_rename_for_drop;
rename table st_poolassign to st_poolassign_rename_for_drop;
rename table st_sub_patentinfo to st_sub_patentinfo_rename_for_drop;
rename table st_xmlfile to st_xmlfile_rename_for_drop;

select count(*) from st_patentinfo;
#sys系统管理
#select * from st_account;#账号 登陆 最基础信息
#select * from sys_account_role;#角色账号关系
#select * from sys_data_dict;#数据字典表
#select * from sys_department;#部门
#select * from sys_eccode;#国民经济分类
#select * from sys_option;#常量 目录配置 外接口配置
#select * from sys_platform;#平台alter
#select * from sys_resource;#菜单图表
#select * from sys_resource_url;#菜单URLid对应

#select * from sys_role;#角色
#select * from sys_role_resource;#角色对应权限
#select * from sys_sequence;#没用 导数据
#select * from sys_station_mes;#站内信 to_user 用户或者角色 订单自动插表
#select * from sys_station_mes_sender;#定时推送 未启用
#select * from sys_syslog;#未用
#select * from sys_system;#未用
#select * from sys_user;#业务的信息 身份证 照片
drop table sys_resource_deprecated;
drop table sys_user_deprecated; 

#up_ 业务表
select * from up_agent;#经纪人表
select * from up_agent_company;#经纪人表通讯录 自己的资源
select * from up_agent_recommend;#专家推荐 专利推荐
select * from up_agent_verify_trace;#经纪人审批流水
#up_an_info 定时统计任务 
select * from up_an_info;#国知局费用信息 表很大 专利书包 专利宝 缴费截止日 缴费后 缴费信息 
rename table up_an_info to up_an_info_rename_2;
#狗日的对接口表改写了 我草他妈
ALTER TABLE `iptp`.`st_patfeeinfo` 
ADD COLUMN `AN` VARCHAR(20) NULL COMMENT '申请号' AFTER `SIGNTIME`,
ADD COLUMN `paid_year` TINYINT(4) NULL COMMENT '第N年年费' AFTER `AN`;
ALTER TABLE `iptp`.`st_patfeeinfo` 
ADD INDEX `IDX_ST_PATFEEINFO_AN` (`AN` ASC),
ADD INDEX `IDX_ST_PATFEEINFO_ANFEETYPE` (`AN` ASC, `FEETYPE` ASC);
select * from st_patfeeinfo ;
update st_patfeeinfo set an = concat('CN',APPLYNUM) 
where an is null limit 3000000;
update st_patfeeinfo set an = concat('CN',APPLYNUM) 
where an is null limit 3000000;
update st_patfeeinfo set an = concat('CN',APPLYNUM) 
where an is null limit 3000000;
update st_patfeeinfo set an = concat('CN',APPLYNUM) 
where an is null limit 3000000;
select distinct feetype from st_patfeeinfo ;
select * from st_patfeeinfo ;
update st_patfeeinfo set paid_year =1  where feetype like '%第1年年费%';
update st_patfeeinfo set paid_year =2 where feetype like '%第2年年费%';
update st_patfeeinfo set paid_year =3  where feetype like '%第3年年费%';
update st_patfeeinfo set paid_year =4  where feetype like '%第4年年费%';
update st_patfeeinfo set paid_year =5  where feetype like '%第5年年费%';
update st_patfeeinfo set paid_year =6  where feetype like '%第6年年费%';
update st_patfeeinfo set paid_year =7  where feetype like '%第7年年费%';
update st_patfeeinfo set paid_year =8  where feetype like '%第8年年费%';
update st_patfeeinfo set paid_year =9  where feetype like '%第9年年费%';
update st_patfeeinfo set paid_year =10  where feetype like '%第10年年费%';
update st_patfeeinfo set paid_year =11  where feetype like '%第11年年费%';
update st_patfeeinfo set paid_year =12  where feetype like '%第12年年费%';
update st_patfeeinfo set paid_year =13  where feetype like '%第13年年费%';
update st_patfeeinfo set paid_year =14  where feetype like '%第14年年费%';
update st_patfeeinfo set paid_year =15  where feetype like '%第15年年费%';
update st_patfeeinfo set paid_year =16  where feetype like '%第16年年费%';
update st_patfeeinfo set paid_year =17  where feetype like '%第17年年费%';
update st_patfeeinfo set paid_year =18  where feetype like '%第18年年费%';
update st_patfeeinfo set paid_year =19  where feetype like '%第19年年费%';
update st_patfeeinfo set paid_year =20  where feetype like '%第20年年费%'; 


#kettle ***
#select * from up_class;#专利分类 如IPC LOC分类 
#select * from up_college;#高校有库 
#select * from up_college_dict;#高校数据字典 college_id 同步
#select * from up_college_image;#高校图片
#select * from up_college_patent;#高校托管专利 专利宝
#更新up_college_patent
update up_college_patent w set w.patent_id = (select n.idpatent from st_patentinfo_uid_tmp n where n.an = w.patent_an);
 
select * from up_college_patent_count;#高校对应专利统计  ???

#统计任务
#select * from up_college_platform;#高校在那些平台展示
#select * from up_comment;#未使用 专利评论
#select * from up_company;#企业会员 注册时企业会员信息放在这里
#select * from up_count_day;#统计用 交易统计 会员统计
#统计用涉及任务
#select * from up_disposition;#处置权表 专家 高校
#select * from up_disposition_auth;#处置权 审批表
#select * from up_disposition_image;#处置权附件
select * from up_disposition_patent;#处置权专利 清单
#清楚CNPIR专利
delete ww from up_disposition_patent ww
where not exists (select * 
                    from st_patentinfo_sub1_rename s ,st_patentinfo_uid_tmp su
				   where s.IDPATENT = ww.patent_id 
					 and s.an = su.an );
                     
update up_disposition_patent w
  set w.patent_id = (select su.IDPATENT
                      from st_patentinfo_sub1_rename s,st_patentinfo_uid_tmp su
					 where s.IDPATENT = w.patent_id
                       and s.an =  su.an);
                       

#select * from up_domain;#专家领域
#select * from up_expert;#平台专家 
select * from up_expert_patent;#平台专家专利
delete ww from up_expert_patent ww
where not exists (select * 
                    from st_patentinfo_sub1_rename s ,st_patentinfo_uid_tmp su
				   where s.IDPATENT = ww.patent_id 
					 and s.an = su.an );
update up_expert_patent w
  set w.patent_id = (select su.IDPATENT
                      from st_patentinfo_sub1_rename s,st_patentinfo_uid_tmp su
					 where s.IDPATENT = w.patent_id
                       and s.an =  su.an);
                       
#select * from up_expert_platform;#平台专家平台展示
select * from up_favorite;#收藏夹 收藏专利
delete from up_favorite;

select * from up_fee_order;#缴费订单
delete from up_fee_order;
select * from  up_fee_order
#select * from up_fee_order_operation;#缴费订单 未用
select * from up_fee_order_patent;#缴费订单对应专利 
delete from up_fee_order_patent;
 
select * from up_goods;#商品表 都包括

select  *  from up_goods ww
where not exists (select * 
                    from st_patentinfo_uid_tmp su
				   where su.IDPATENT = ww.patent_id  );
/*delete ww from up_goods ww
where not exists (select * 
                    from st_patentinfo_sub1_rename s ,st_patentinfo_uid_tmp su
				   where s.IDPATENT = ww.patent_id 
					 and s.an = su.an );*/
update up_goods w
  set w.patent_id = (select su.IDPATENT
                      from st_patentinfo_sub1_rename s,st_patentinfo_uid_tmp su
					 where s.IDPATENT = w.patent_id
                       and s.an =  su.an);
                       
#select * from up_goods_class;#商品分类
#select * from up_goods_comment;#商品评论 专家评价信息 平台后台自己加的
#select * from up_goods_image;#商品图片
#select * from up_goods_lock_trace;#商品锁定工单
#select * from up_goods_operation;#上下架流水表
#select * from up_goods_platform;#商品在那个平台展示
#select * from up_goods_tag;#商品标签管理
#select * from up_goods_tag_list;#未启用
#select * from up_group;#商品分组 专利宝 分组检索用 自建分组
select * from up_group_patent;#分组下专利
delete ww from up_group_patent ww
where not exists (select * 
                    from st_patentinfo_sub1_rename s ,st_patentinfo_uid_tmp su
				   where s.IDPATENT = ww.patent_id 
					 and s.an = su.an );
update up_group_patent w
  set w.patent_id = (select su.IDPATENT
                      from st_patentinfo_sub1_rename s,st_patentinfo_uid_tmp su
					 where s.IDPATENT = w.patent_id
                       and s.an =  su.an);

#select * from up_home_banner;#首页 banner 已放到内容里面CMS里面
#select * from up_member;#会员信息 已废弃 已合并到user
#select * from up_member_agent;#已废弃
#select * from up_member_favorite;#心原单
#select * from up_member_favorite_group;#心原单名称
#select * from up_member_verify_trace;#会员审批记录
#select * from up_notice_config;#提醒缴费 废弃了
select * from up_notice_patent;#提醒对应专利
delete from up_notice_patent;                 
#select * from up_order;#订单 
#select * from up_order_contract;#订单合同
#select * from up_order_goods;#订单商品 一对一
#select * from up_order_operation;#订单操作流水
#select * from up_order_payment;#订单支付
#select * from up_order_right;#国知局缴费工单
#select * from up_patent_alarm;#专利宝 缴费预警 up_notice_config
#select * from up_patent_alarm_ser;#
select * from up_patent_class;#专利分类表  要全部生成
delete ww from up_patent_class ww
where not exists (select * 
                    from st_patentinfo_sub1_rename s ,st_patentinfo_uid_tmp su
				   where s.IDPATENT = ww.patent_id 
					 and s.an = su.an );
update up_patent_class w
  set w.patent_id = (select su.IDPATENT
                      from st_patentinfo_sub1_rename s,st_patentinfo_uid_tmp su
					 where s.IDPATENT = w.patent_id
                       and s.an =  su.an);
###差insert 生成全部                       
					

#select * from up_patent_fee_config;#专利费用配置
#select * from up_patent_fee_count;#专利费用统计  结果表up_an_info
#任务相关
select * from up_patent_fee_status;#专利费用状态 结果表up_an_info
delete from up_patent_fee_status;

#select * from up_patent_fee_status_college_list;#
#select * from up_patent_fee_status_tmp_stat;#
select * from up_patent_storage;#专利归属仓库
delete ww from up_patent_storage ww
where not exists (select * 
                    from st_patentinfo_sub1_rename s ,st_patentinfo_uid_tmp su
				   where s.IDPATENT = ww.patent_id 
					 and s.an = su.an );
update up_patent_storage w
  set w.patent_id = (select su.IDPATENT
                      from st_patentinfo_sub1_rename s,st_patentinfo_uid_tmp su
					 where s.IDPATENT = w.patent_id
                       and s.an =  su.an);
                       
#select * from up_platform_host;#路由配置
#select * from up_praise;#
#select * from up_price_reference;#价格参考表  接口
#select * from up_professor;#专家 自己注册 专利书包
#select * from up_professor_auth;#专家 审核
select * from up_professor_patent;#专家仓库 托管 
delete ww from up_professor_patent ww
where not exists (select * 
                    from st_patentinfo_sub1_rename s ,st_patentinfo_uid_tmp su
				   where s.IDPATENT = ww.patent_id 
					 and s.an = su.an );
update up_professor_patent w
  set w.patent_id = (select su.IDPATENT
                      from st_patentinfo_sub1_rename s,st_patentinfo_uid_tmp su
					 where s.IDPATENT = w.patent_id
                       and s.an =  su.an);

#select * from up_project;#成果 项目成果
#select * from up_project_image;#成果
#select * from up_requirement;#需求
#select * from up_service;#服务
#select * from up_service_category;#服务大分类
#select * from up_service_faq;#服务热门回答
#select * from up_service_image;#服务图片
#select * from up_service_order;#服务订单
#select * from up_service_provider;#服务提供商
#select * from up_service_provider_case;#服务案例
#select * from up_service_spec;#服务二级分类 商品类型 专利类型
#select * from up_storage;#商品 内部仓库
#select * from up_subject;#专题   首页主题 专题
#select * from up_subject_banner;#专题banner
#select * from up_subject_goods;#专题商品
#select * from up_workorder;#著录工单
#fselect * from up_workorder_log;#著录工单日志