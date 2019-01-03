CREATE TABLE user(
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    avatar VARCHAR(255) NOT NULL DEFAULT '' COMMENT '头像照片文件路径',
	name CHAR(8) NOT NULL DEFAULT '' COMMENT '姓名',
    sex TINYINT UNSIGNED NOT NULL default 1 COMMENT '性别:1-男,2-女',
    height TINYINT UNSIGNED NOT NULL COMMENT '身高:单位cm,最大255',
    birthday BIGINT UNSIGNED NOT NULL COMMENT '生日时间戳',
	edu TINYINT UNSIGNED NOT NULL COMMENT '学历:1-高中及以下,2-中专,3-大专,4-大学本科,5-硕士,6-博士',
	income INT UNSIGNED NOT NULL DEFAULT 3000 COMMENT '月收入',
	marital TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '婚姻状况:1-未婚,2-离婚,3-丧偶',
	addr VARCHAR(100) NOT NULL DEFAULT '' COMMENT '工作地区',
	phone CHAR(11) NOT NULL UNIQUE KEY COMMENT '手机号',
	pwd CHAR(32) NOT NULL COMMENT '密码:使用md5加密方式,密码+salt+reg_time',
	salt VARCHAR(255) NOT NULL COMMENT '加密盐值',
	reg_time BIGINT UNSIGNED NOT NULL COMMENT '注册时间戳',
	KEY (reg_time)
)ENGINE = innodb default charset utf8;

CREATE TABLE mail(
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    uid INT UNSIGNED NOT NULL COMMENT '用户id,user表id',
    from_uid INT UNSIGNED NOT NULL COMMENT '发送邮件的用户id,user表id',
    status TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '邮件状态:0-已删除,1-未读,2-已读',
    send_time BIGINT UNSIGNED NOT NULL COMMENT '发送时间',
    KEY (uid),
    KEY (from_uid)
)ENGINE = innodb default charset utf8 COMMENT '用户邮箱表';

CREATE TABLE seek(
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    uid INT UNSIGNED NOT NULL COMMENT '用户id,user表id',
    sex TINYINT UNSIGNED NOT NULL COMMENT '性取向:0-不限,1-男,2-女',
    min_age TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '最小年龄,0为不限',
    max_age TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大年龄,0为不限',
    min_height TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '最低身高,0为不限',
    max_height TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '最高身高,0为不限',
    min_income INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '最低收入,0为不限',
    max_income INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '最高收入,0为不限',
    edu TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '学历:0-不限,1-高中及以下,2-中专,3-大专,4-大学本科,5-硕士,6-博士',
    marital TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '婚姻状况:0-不限,1-未婚,2-离婚,3-丧偶',
    KEY (uid)
)ENGINE = innodb default charset utf8 COMMENT '择偶条件表';