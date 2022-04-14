/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 5.7.19 : Database - ssm_hotel
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`ssm_hotel` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `ssm_hotel`;

/*Table structure for table `sys_dept` */

DROP TABLE IF EXISTS `sys_dept`;

CREATE TABLE `sys_dept` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '部门编号',
  `deptName` varchar(50) DEFAULT NULL COMMENT '部门名称',
  `address` varchar(255) DEFAULT NULL COMMENT '部门地址',
  `createDate` datetime DEFAULT NULL COMMENT '创建时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `sys_dept` */

insert  into `sys_dept`(`id`,`deptName`,`address`,`createDate`,`remark`) values (1,'管理部','111','2021-07-05 21:58:22','管理'),(2,'后勤部','202','2021-07-05 21:58:35','后勤');

/*Table structure for table `sys_employee` */

DROP TABLE IF EXISTS `sys_employee`;

CREATE TABLE `sys_employee` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '职员编号',
  `loginName` varchar(50) DEFAULT NULL COMMENT '账号',
  `loginPwd` varchar(255) DEFAULT NULL COMMENT '密码',
  `name` varchar(50) DEFAULT NULL COMMENT '职员姓名',
  `sex` int(11) DEFAULT NULL COMMENT '职员性别（1-男，2-女）',
  `deptId` int(11) DEFAULT NULL COMMENT '部门编号',
  `hireDate` datetime DEFAULT NULL COMMENT '入职日期',
  `salt` varchar(255) DEFAULT NULL COMMENT '加密盐值（即加密的方式）',
  `createDate` datetime DEFAULT NULL COMMENT '创建日期',
  `createBy` int(11) DEFAULT NULL COMMENT '创建人',
  `modifyDate` datetime DEFAULT NULL COMMENT '修改日期',
  `modifyBy` int(11) DEFAULT NULL COMMENT '修改人',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `sys_employee` */

insert  into `sys_employee`(`id`,`loginName`,`loginPwd`,`name`,`sex`,`deptId`,`hireDate`,`salt`,`createDate`,`createBy`,`modifyDate`,`modifyBy`,`remark`) values (1,'admin','0bf0750318a5c275463cc252d66f0e2d','超级管理员',1,1,'2021-07-04 18:51:29','597e938b8f2d49138cd5773b0c2ea4e3','2021-07-04 18:51:43',1,NULL,NULL,NULL),(5,'t','7c91c433c78968471b392e9bb1a39769','tc',1,1,'2021-07-07 00:00:00','31c60957fe5044c281eee211ef10256d','2021-07-07 21:21:24',1,NULL,NULL,'');

/*Table structure for table `sys_menu` */

DROP TABLE IF EXISTS `sys_menu`;

CREATE TABLE `sys_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '菜单编号',
  `pid` int(11) DEFAULT NULL COMMENT '所属父级菜单',
  `title` varchar(50) DEFAULT NULL COMMENT '菜单名称',
  `href` varchar(255) DEFAULT NULL COMMENT '链接地址',
  `spread` int(11) DEFAULT NULL COMMENT '链接是否展开（0-否，1-是）',
  `target` varchar(50) DEFAULT NULL COMMENT '打开方式',
  `icon` varchar(255) DEFAULT NULL COMMENT '菜单图标样式',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

/*Data for the table `sys_menu` */

insert  into `sys_menu`(`id`,`pid`,`title`,`href`,`spread`,`target`,`icon`) values (1,0,'系统管理',NULL,1,'self','fa fa-users'),(2,0,'客房管理',NULL,1,'self','fa fa-users'),(3,1,'员工管理','/admin/toEmployeeManage',0,NULL,'fa fa-users'),(4,1,'部门管理','/admin/toDeptManage',0,NULL,'fa fa-users'),(5,2,'房型管理','/admin/toRoomTypeManage',0,NULL,'fa fa-users'),(6,2,'房间管理','/admin/toRoomManage',0,NULL,'fa fa-hotel'),(7,1,'角色管理','/admin/toRoleManage',0,NULL,'fa fa-users'),(8,1,'菜单管理','/admin/toMenuManage',0,NULL,'fa fa-users'),(10,2,'楼层管理','/admin/toFloorManage',0,NULL,'fa fa-align-justify'),(11,0,'订单管理',NULL,1,'self','fa fa-calculator'),(12,11,'预订管理','/admin/toOrdersManage',0,NULL,'fa fa-address-book'),(13,11,'入住管理','/admin/toCheckInManage',0,NULL,'fa fa-address-book-o');

/*Table structure for table `sys_role` */

DROP TABLE IF EXISTS `sys_role`;

CREATE TABLE `sys_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色编号',
  `roleName` varchar(255) DEFAULT NULL COMMENT '角色名称',
  `roleDesc` varchar(255) DEFAULT NULL COMMENT '角色权限',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `sys_role` */

insert  into `sys_role`(`id`,`roleName`,`roleDesc`) values (1,'超级管理员','所有操作权限'),(2,'系统管理员','系统管理操作权限'),(3,'资料管理员','资料管理');

/*Table structure for table `sys_role_employee` */

DROP TABLE IF EXISTS `sys_role_employee`;

CREATE TABLE `sys_role_employee` (
  `eid` int(11) NOT NULL COMMENT '员工编号',
  `rid` int(11) NOT NULL COMMENT '角色编号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_role_employee` */

insert  into `sys_role_employee`(`eid`,`rid`) values (1,1),(1,2),(1,3),(5,2);

/*Table structure for table `sys_role_menu` */

DROP TABLE IF EXISTS `sys_role_menu`;

CREATE TABLE `sys_role_menu` (
  `mid` int(11) NOT NULL COMMENT '菜单编号',
  `rid` int(11) NOT NULL COMMENT '角色编号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_role_menu` */

insert  into `sys_role_menu`(`mid`,`rid`) values (1,2),(3,2),(4,2),(7,2),(8,2),(1,1),(3,1),(4,1),(7,1),(8,1),(2,1),(5,1),(6,1),(10,1),(11,1),(12,1),(13,1);

/*Table structure for table `t_checkin` */

DROP TABLE IF EXISTS `t_checkin`;

CREATE TABLE `t_checkin` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `roomTypeId` int(11) DEFAULT NULL COMMENT '所属房型',
  `roomId` bigint(20) DEFAULT NULL COMMENT '所属房间',
  `customerName` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '入住人姓名',
  `idCard` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '入住人身份证号',
  `phone` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '手机号',
  `arriveDate` date DEFAULT NULL COMMENT '入住日期',
  `leaveDate` date DEFAULT NULL COMMENT '离店日期',
  `payPrice` decimal(10,2) NOT NULL COMMENT '实付金额',
  `ordersId` bigint(20) DEFAULT NULL COMMENT '关联预订订单ID',
  `status` int(11) unsigned DEFAULT NULL COMMENT '状态',
  `createDate` datetime DEFAULT NULL COMMENT '创建时间',
  `createdBy` int(11) DEFAULT NULL COMMENT '创建人',
  `modifyDate` datetime DEFAULT NULL COMMENT '修改时间',
  `modifyBy` int(11) DEFAULT NULL COMMENT '修改人',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`,`payPrice`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `t_checkin` */

insert  into `t_checkin`(`id`,`roomTypeId`,`roomId`,`customerName`,`idCard`,`phone`,`arriveDate`,`leaveDate`,`payPrice`,`ordersId`,`status`,`createDate`,`createdBy`,`modifyDate`,`modifyBy`,`remark`) values (4,2,5,'TC','ssssssdsds','11111111111','2021-07-20','2021-07-22','400.00',4,4,NULL,NULL,NULL,NULL,'dddd'),(5,8,6,'TC','dsdd','11111111111','2021-07-20','2021-08-24','388885.00',6,4,NULL,NULL,NULL,NULL,'ddddd'),(6,2,3,'TC','sss','11111111111','2021-07-21','2021-07-22','200.00',5,4,NULL,NULL,NULL,NULL,'sss'),(7,2,2,'TC','wwwwwwwwwww','11111111111','2021-08-27','2021-08-28','200.00',8,4,NULL,NULL,NULL,NULL,''),(8,2,3,'TC','wwwwwwww','11111111111','2021-08-28','2021-09-19','4400.00',7,4,NULL,NULL,NULL,NULL,''),(9,2,2,'TC','ssss','11111111111','2021-10-13','2021-10-14','200.00',9,3,NULL,NULL,NULL,NULL,'');

/*Table structure for table `t_checkout` */

DROP TABLE IF EXISTS `t_checkout`;

CREATE TABLE `t_checkout` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `checkOutNumber` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '退房记录编号',
  `checkInId` bigint(20) DEFAULT NULL COMMENT '关联入住ID',
  `consumerPrice` decimal(10,2) DEFAULT NULL COMMENT '消费金额',
  `createDate` datetime DEFAULT NULL COMMENT '创建时间',
  `createdBy` int(11) DEFAULT NULL COMMENT '操作人',
  `remark` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `t_checkout` */

insert  into `t_checkout`(`id`,`checkOutNumber`,`checkInId`,`consumerPrice`,`createDate`,`createdBy`,`remark`) values (1,'1b789f45e05349b8908c84139dc3434b',4,NULL,'2021-07-09 22:27:36',NULL,NULL),(2,'991ef881597f4b9bb36fd52cf7101a24',6,NULL,'2021-07-09 23:12:15',NULL,NULL),(3,'8ac5511b189b4aa58813fcc14eb90e9e',4,NULL,'2021-08-27 14:48:10',NULL,NULL),(4,'da3a534d538946ffb1d7df458c8e2033',5,NULL,'2021-08-27 14:48:12',NULL,NULL),(5,'3c46a37a07ed4e39b974a49665c959f6',6,NULL,'2021-08-27 14:48:15',NULL,NULL),(6,'78e3a5390a2f445eb80df324fced50f4',4,NULL,'2021-08-27 14:48:17',NULL,NULL),(7,'2fcaadac2641491992d5f7cb0920317a',6,NULL,'2021-08-27 14:48:39',NULL,NULL),(8,'602db31cde364af4a37fc70caa3a7ea6',4,NULL,'2021-08-27 15:16:55',NULL,NULL),(9,'fe730e7fc3d44725897d6782dc51bd6b',7,NULL,'2021-08-27 15:22:14',NULL,NULL),(10,'c8439525aad6429eb3acd3ad125ccb67',8,NULL,'2021-08-27 15:22:16',NULL,NULL);

/*Table structure for table `t_floor` */

DROP TABLE IF EXISTS `t_floor`;

CREATE TABLE `t_floor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `t_floor` */

insert  into `t_floor`(`id`,`name`,`remark`) values (1,'1楼','酒店大厅'),(2,'2楼','标间区域'),(3,'3楼','3'),(4,'4楼',''),(5,'5楼',''),(6,'6楼',''),(7,'7楼','');

/*Table structure for table `t_orders` */

DROP TABLE IF EXISTS `t_orders`;

CREATE TABLE `t_orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '预订编号',
  `ordersNo` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '预订单号',
  `accountId` bigint(20) DEFAULT NULL COMMENT '预订人账号ID',
  `roomTypeId` int(11) DEFAULT NULL COMMENT '房型编号',
  `roomId` bigint(20) DEFAULT NULL COMMENT '房间ID',
  `reservationName` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '预订人姓名',
  `idCard` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '身份证号码',
  `phone` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '电话号码',
  `status` int(11) DEFAULT NULL COMMENT '状态1-待确认  2-已确认 3-已入住 4-已离店',
  `reserveDate` datetime DEFAULT NULL COMMENT '预定时间',
  `arriveDate` date DEFAULT NULL COMMENT '到店时间',
  `leaveDate` date DEFAULT NULL COMMENT '离店时间',
  `reservePrice` decimal(10,2) DEFAULT NULL COMMENT '预订价格',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

/*Data for the table `t_orders` */

insert  into `t_orders`(`id`,`ordersNo`,`accountId`,`roomTypeId`,`roomId`,`reservationName`,`idCard`,`phone`,`status`,`reserveDate`,`arriveDate`,`leaveDate`,`reservePrice`,`remark`) values (4,'29190f7b99884d69ab65c4c5bb00f5f2',1,2,5,'TC','ssssssdsds','11111111111',4,'2021-07-09 13:46:05','2021-07-20','2021-07-22','400.00','dddd'),(5,'572f775277d447b0b192cee2334750b6',1,2,3,'TC','sss','11111111111',4,'2021-07-09 17:26:02','2021-07-21','2021-07-22','200.00','sss'),(6,'a7b2c76cf9bb40a8bd5164d08fbbad4e',1,8,6,'TC','dsdd','11111111111',4,'2021-07-09 17:26:19','2021-07-20','2021-08-24','388885.00','ddddd'),(7,'573792c688944423936d9ea3e2a0f8dc',1,2,3,'TC','wwwwwwww','11111111111',4,'2021-08-27 14:47:02','2021-08-28','2021-09-19','4400.00',''),(8,'5ec1b8ac3ab84569afdb5f61f9cc301e',1,2,2,'TC','wwwwwwwwwww','11111111111',4,'2021-08-27 15:15:24','2021-08-27','2021-08-28','200.00',''),(9,'9dd59b8b5ea041d69160b155038400e9',1,2,2,'TC','ssss','11111111111',3,'2021-10-09 16:40:27','2021-10-13','2021-10-14','200.00',''),(10,'6323368ef0294b1eadbc3b6e2f38010e',1,2,4,'TC','55','13397178339',1,'2021-10-09 16:58:33','2021-10-20','2021-10-21','200.00','');

/*Table structure for table `t_room` */

DROP TABLE IF EXISTS `t_room`;

CREATE TABLE `t_room` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `photo` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '房间图片',
  `roomNum` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '房间编号',
  `roomTypeId` int(11) DEFAULT NULL COMMENT '房型',
  `floorId` int(11) DEFAULT NULL COMMENT '所属楼层',
  `status` int(11) DEFAULT NULL COMMENT '状态',
  `roomDesc` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT '房间描述',
  `roomRequirement` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '要求',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `t_room` */

insert  into `t_room`(`id`,`photo`,`roomNum`,`roomTypeId`,`floorId`,`status`,`roomDesc`,`roomRequirement`,`remark`) values (1,'images/defaultimg.jpg','100',2,1,1,'<img src=\"/hotel/show/20210709/ce7d4f208686456f97ed4f99206885dc.jpg\" alt=\"undefined\">',NULL,NULL),(2,'images/defaultimg.jpg','101',2,1,2,'',NULL,'1'),(3,'images/defaultimg.jpg','102',2,1,1,'',NULL,'1'),(4,'images/defaultimg.jpg','200',2,2,2,'已经被预定了','no','222'),(5,'20210708/a210da1543f340aa973d4d26c93b1c71.jpg','201',2,2,1,'<img src=\"http://localhost:8080/statics/layui/lib/layui-v2.6.3/images/face/0.gif\" alt=\"[微笑]\">','111','0'),(6,'images/defaultimg.jpg','301',8,3,1,'','','');

/*Table structure for table `t_room_type` */

DROP TABLE IF EXISTS `t_room_type`;

CREATE TABLE `t_room_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '房型编号',
  `typeName` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '房型名称',
  `photo` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '房型图片',
  `price` decimal(8,2) DEFAULT NULL COMMENT '参考价格',
  `liveNum` int(11) DEFAULT NULL COMMENT '可入住人数',
  `bedNum` int(11) DEFAULT NULL COMMENT '床位数',
  `roomNum` int(11) DEFAULT NULL COMMENT '房间数量',
  `reservedNum` int(11) DEFAULT NULL COMMENT '总共被预定的数量',
  `availableNum` int(11) DEFAULT NULL COMMENT '可预定数量',
  `livedNum` int(11) DEFAULT NULL COMMENT '已入住数量',
  `status` int(11) DEFAULT NULL COMMENT '房型状态',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `t_room_type` */

insert  into `t_room_type`(`id`,`typeName`,`photo`,`price`,`liveNum`,`bedNum`,`roomNum`,`reservedNum`,`availableNum`,`livedNum`,`status`,`remark`) values (2,'单人间','images/defaultimg.jpg','200.00',2,1,20,2,18,5,1,'无'),(3,'双人间','images/defaultimg.jpg','300.00',2,2,20,0,20,0,1,'x'),(4,'标准间','images/defaultimg.jpg','300.00',2,1,20,0,20,0,1,'2'),(5,'普通套间','images/defaultimg.jpg','400.00',1,1,20,0,20,0,1,''),(6,'商务间','20210708/e9002270db304ac5ad2b400f2628d2d8.jpg','5000.00',4,2,10,0,10,0,1,'111'),(7,'豪华间','20210708/0b0fbe5df4ac400ab9a79b3d90c2b86f.jpg','1000.00',1,1,1,0,1,0,1,'1'),(8,'总统套房','20210708/9bccffdd32304f01a18af00ff93bf842.jpg','11111.00',2,1,1,0,1,1,1,'a');

/*Table structure for table `t_user` */

DROP TABLE IF EXISTS `t_user`;

CREATE TABLE `t_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户编号',
  `loginName` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '登录账号',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '登录密码',
  `realName` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '真实姓名',
  `idCard` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '身份证号码',
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '电话号码',
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '邮箱',
  `status` int(11) DEFAULT NULL COMMENT '状态:1-可用 0-异常',
  `createDate` datetime DEFAULT NULL COMMENT '注册时间',
  `salt` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '盐值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `t_user` */

insert  into `t_user`(`id`,`loginName`,`password`,`realName`,`idCard`,`phone`,`email`,`status`,`createDate`,`salt`) values (1,'TC','8f86d0c9a4068438f23017c1be5133ca',NULL,NULL,'13131322255',NULL,NULL,NULL,'f5786c92ea4f4b7f986963f9abf5cbf2'),(2,'T','968a92a75f2731e679fbeea87f2f7ae4',NULL,NULL,'12345678911',NULL,NULL,NULL,'e5a38c6b09de46e4a291b038fb49fa3e'),(3,'TA','d427d5a3fe33983d369dc462a704238d',NULL,NULL,'12345678911',NULL,NULL,NULL,'20aa12b0f9104552be40c33e9dd93e21');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
