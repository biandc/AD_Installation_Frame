#!/bin/bash


# 复制金库文件

copy_files_path=$(pwd)"/copy_files/copy_files_dir"


ad_root_path=$AD_ROOT_PATH

if [[ ! -n $AD_ROOT_PATH ]];then
    ad_root_path="/adm/cdn_isms_huawei"
fi

\cp -rf $copy_files_path/* $ad_root_path


# 向 etc/config.ini 文件中添加金库配置
#[vault_switch]
#IAM4A = 0
#resNum = cdn信息安全管理系统

#[syslog]
#syslog_list = [{"status": 0, "note": "vault syslog发送配置", "name": "金库日志模板配置", "syslog_ip": "127.0.0.1", "send_content": [{"hit": 1, "name": "金库审计日志", "cont_type":"syslog_vault_audit_log","key": "vault","format":"<142>StartTime={};Location={};userID={};resAccount={};Action={};resInfo={};ActionResult={};ResNum={};operationCode={};ResultCode={};requestTime={};requestID={};authMode={};authTime={};authResult={};JKReason={};JKActionResult={};"}, {"hit": 1, "name": "管控平台审计日志","cont_type":"syslog_control_audit_log", "key": "control","format":'<142>LogTime="{}";SubUser="{}";App="{}";Sip="{}";AppModule="{}";OpType="{}";OpText="{}"'}], "syslog_port": 514, "id": "1"}]


cat << EOF >> $ad_root_path/etc/config.ini

[vault_switch]
IAM4A = 0
resNum = cdn信息安全管理系统

[syslog]
syslog_list = [{"status": 0, "note": "vault syslog发送配置", "name": "金库日志模板配置", "syslog_ip": "127.0.0.1", "send_content": [{"hit": 1, "name": "金库审计日志", "cont_type":"syslog_vault_audit_log","key": "vault","format":"<142>StartTime={};Location={};userID={};resAccount={};Action={};resInfo={};ActionResult={};ResNum={};operationCode={};ResultCode={};requestTime={};requestID={};authMode={};authTime={};authResult={};JKReason={};JKActionResult={};"}, {"hit": 1, "name": "管控平台审计日志","cont_type":"syslog_control_audit_log", "key": "control","format":'<142>LogTime="{}";SubUser="{}";App="{}";Sip="{}";AppModule="{}";OpType="{}";OpText="{}"'}], "syslog_port": 514, "id": "1"}]

EOF

sed -i "/\[sys_info\]/a\tls_version = tls1.2" $ad_root_path/etc/config.ini
sed -i "/^version/d" $ad_root_path/etc/config.ini
sed -i "/\[sys_info\]/a\version = 7.3.1.1.12819" $ad_root_path/etc/config.ini
