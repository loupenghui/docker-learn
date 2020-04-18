drop table if exists SC_RoleAuthority;
drop table if exists SC_OperatorRole;
drop table if exists SC_Module;
drop table if exists SC_Operator;
drop table if exists SC_Role;

/*==============================================================*/
/* Table: SC_Module                                             */
/*==============================================================*/
create table SC_Module
(
   moduleCode           varchar(9) not null,
   parentCode           varchar(9),
   moduleName           varchar(128),
   icon                 varchar(128) comment '图标样式',
   isAuthority          SMALLINT,
   moduleTag            varchar(128),
   sortId               int comment '同级排序',
   remark               varchar(128),
   primary key (moduleCode)
);



/*==============================================================*/
/* Table: SC_Role                                               */
/*==============================================================*/
create table SC_Role
(
   roleId               varchar(32) not null comment '全库唯一',
   roleName         varchar(32) comment '同一使用单位不允许重复',
   recFlag              SMALLINT comment '1 启用 2 禁用',
   remark               varchar(32),
   orgId                int comment '组织ID',
   createDate           datetime,
   modifyDate           datetime,
   primary key (roleId)
);




/*==============================================================*/
/* Table: SC_Operator                                           */
/*==============================================================*/
create table SC_Operator
(
   operatorId           varchar(32) not null,
   orgId                int comment '组织ID',
   operatorAccount      varchar(32) comment '操作员账号',
   operatorPwd          varchar(32) comment 'MD5加密 操作员密码',
   operatorName         varchar(32) comment '操作员名字',
   operatorTel          varchar(32) comment '手机号码',
   operatorEmail        varchar(64) comment '电子邮箱',
   operatorIdType       SMALLINT comment '证件类型',
   operatorIdNo         varchar(32) comment '证件号码',
   recFlag              SMALLINT comment '1-启用，2-禁用。',
   remark               varchar(128) comment '备注',
   operatorExpand       varchar(128) comment '操作员扩展信息',
   isDefault            int comment '是否默认密码  1  是  2 否',
   operatorImage        varchar(128),
   createDate           datetime,
   modifyDate           datetime,
   primary key (operatorId)
);



/*==============================================================*/
/* Table: SC_RoleAuthority                                      */
/*==============================================================*/
create table SC_RoleAuthority
(
   roleId               varchar(32) not null,
   moduleCode           varchar(9) not null
);

alter table SC_RoleAuthority add constraint FK_RoleAuthority_Role foreign key (roleId)
      references SC_Role (roleId) on delete restrict on update restrict;

alter table SC_RoleAuthority add constraint FK_RoleAuthority_Moule foreign key (moduleCode)
      references SC_Module (moduleCode) on delete restrict on update restrict;
	  
	  


/*==============================================================*/
/* Table: SC_OperatorRole                                       */
/*==============================================================*/
create table SC_OperatorRole
(
   operatorId           varchar(32),
   roleId               varchar(32)
);

alter table SC_OperatorRole add constraint FK_OperatorRole_Operator foreign key (operatorId)
      references SC_Operator (operatorId) on delete restrict on update restrict;

alter table SC_OperatorRole add constraint FK_OperatorRole_Role foreign key (roleId)
      references SC_Role (roleId) on delete restrict on update restrict;

	  
/*--系统管理模块--*/
insert into sc_module (MODULECODE, PARENTCODE, MODULENAME, SORTID, REMARK, ISAUTHORITY, MODULETAG) values ('001', null, '系统管理', 1, null, 1, null);
/*--角色管理菜单--*/
insert into sc_module (MODULECODE, PARENTCODE, MODULENAME, SORTID, REMARK, ISAUTHORITY, MODULETAG) values ('00101', '001', '角色管理', 1, null, 1, '');
insert into sc_module (MODULECODE, PARENTCODE, MODULENAME, SORTID, REMARK, ISAUTHORITY, MODULETAG) values ('0010101', '00101', '新增', 1, null, 1, null);
insert into sc_module (MODULECODE, PARENTCODE, MODULENAME, SORTID, REMARK, ISAUTHORITY, MODULETAG) values ('0010102', '00101', '修改', 2, null, 1, null);
insert into sc_module (MODULECODE, PARENTCODE, MODULENAME, SORTID, REMARK, ISAUTHORITY, MODULETAG) values ('0010103', '00101', '删除', 3, null, 1, null);
/*--用户管理菜单--*/
insert into sc_module (MODULECODE, PARENTCODE, MODULENAME, SORTID, REMARK, ISAUTHORITY, MODULETAG) values ('00102', '001', '用户管理', 2, null, 1, '');
insert into sc_module (MODULECODE, PARENTCODE, MODULENAME, SORTID, REMARK, ISAUTHORITY, MODULETAG) values ('0010201', '00102', '新增', 1, null, 1, null);
insert into sc_module (MODULECODE, PARENTCODE, MODULENAME, SORTID, REMARK, ISAUTHORITY, MODULETAG) values ('0010202', '00102', '修改', 2, null, 1, null);
insert into sc_module (MODULECODE, PARENTCODE, MODULENAME, SORTID, REMARK, ISAUTHORITY, MODULETAG) values ('0010203', '00102', '删除', 3, null, 1, null);
insert into sc_module (MODULECODE, PARENTCODE, MODULENAME, SORTID, REMARK, ISAUTHORITY, MODULETAG) values ('0010204', '00102', '清密', 4, null, 1, null);
/*--应用管理菜单--*/
insert into sc_module (MODULECODE, PARENTCODE, MODULENAME, SORTID, REMARK, ISAUTHORITY, MODULETAG) values ('00103', '001', '应用管理', 3, null, 1, '');
insert into sc_module (MODULECODE, PARENTCODE, MODULENAME, SORTID, REMARK, ISAUTHORITY, MODULETAG) values ('0010301', '00103', '新增', 1, null, 1, null);
insert into sc_module (MODULECODE, PARENTCODE, MODULENAME, SORTID, REMARK, ISAUTHORITY, MODULETAG) values ('0010302', '00103', '修改', 2, null, 1, null);

/*--设备管理模块--*/
insert into sc_module (MODULECODE, PARENTCODE, MODULENAME, SORTID, REMARK, ISAUTHORITY, MODULETAG) values ('002', null, '设备管理', 2, null, 1, null);
/*--产品管理菜单--*/
insert into sc_module (MODULECODE, PARENTCODE, MODULENAME, SORTID, REMARK, ISAUTHORITY, MODULETAG) values ('00201', '002', '产品管理', 1, null, 1, '');
insert into sc_module (MODULECODE, PARENTCODE, MODULENAME, SORTID, REMARK, ISAUTHORITY, MODULETAG) values ('0020101', '00201', '新增', 1, null, 1, null);
insert into sc_module (MODULECODE, PARENTCODE, MODULENAME, SORTID, REMARK, ISAUTHORITY, MODULETAG) values ('0020102', '00201', '修改', 2, null, 1, null);
/*--设备管理菜单--*/
insert into sc_module (MODULECODE, PARENTCODE, MODULENAME, SORTID, REMARK, ISAUTHORITY, MODULETAG) values ('00202', '002', '设备管理', 2, null, 1, '');
insert into sc_module (MODULECODE, PARENTCODE, MODULENAME, SORTID, REMARK, ISAUTHORITY, MODULETAG) values ('0020201', '00202', '新增', 1, null, 1, null);
insert into sc_module (MODULECODE, PARENTCODE, MODULENAME, SORTID, REMARK, ISAUTHORITY, MODULETAG) values ('0020202', '00202', '修改', 2, null, 1, null);
/*--授权管理菜单--*/
insert into sc_module (MODULECODE, PARENTCODE, MODULENAME, SORTID, REMARK, ISAUTHORITY, MODULETAG) values ('00203', '002', '授权管理', 3, null, 1, '');
insert into sc_module (MODULECODE, PARENTCODE, MODULENAME, SORTID, REMARK, ISAUTHORITY, MODULETAG) values ('0020301', '00203', '新增', 1, null, 1, null);
insert into sc_module (MODULECODE, PARENTCODE, MODULENAME, SORTID, REMARK, ISAUTHORITY, MODULETAG) values ('0020302', '00203', '修改', 2, null, 1, null);
insert into sc_module (MODULECODE, PARENTCODE, MODULENAME, SORTID, REMARK, ISAUTHORITY, MODULETAG) values ('0020303', '00203', '删除', 3, null, 1, null);

/*--固件管理菜单--*/
insert into sc_module (MODULECODE, PARENTCODE, MODULENAME, SORTID, REMARK, ISAUTHORITY, MODULETAG) values ('00204', '002', '固件管理', 4, null, 1, '');
insert into sc_module (MODULECODE, PARENTCODE, MODULENAME, SORTID, REMARK, ISAUTHORITY, MODULETAG) values ('0020401', '00203', '新增', 1, null, 1, null);
insert into sc_module (MODULECODE, PARENTCODE, MODULENAME, SORTID, REMARK, ISAUTHORITY, MODULETAG) values ('0020402', '00203', '修改', 2, null, 1, null);
insert into sc_module (MODULECODE, PARENTCODE, MODULENAME, SORTID, REMARK, ISAUTHORITY, MODULETAG) values ('0020403', '00203', '删除', 3, null, 1, null);


	
/*--超级管理员--*/
INSERT INTO `sc_operator` (`operatorId`, `orgId`, `operatorAccount`, `operatorPwd`, `operatorName`,  `recFlag`, `remark`, `createDate`)
 VALUES ('1', '1', 'admin', 'admin', '超级管理员', '1', '超级管理员', NOW());
/*--超级角色--*/
INSERT INTO `sc_role` (`roleId`, `roleName`, `recFlag`, `remark`, `orgId`, `createDate`, `modifyDate`) VALUES ('1', '超级管理角色', '1', '超级管理', '1', now(), now());
/*--赋予超级管理员超级角色--*/
INSERT INTO `iot`.`sc_operatorrole` (`operatorId`, `roleId`) VALUES ('1', '1');
/*--赋予超级角色所有功能模块--*/
delete  from sc_roleauthority where roleId=1;
insert into sc_roleauthority (roleId, modulecode) select 1, MODULECODE from sc_module;	
	  
	 
	  
