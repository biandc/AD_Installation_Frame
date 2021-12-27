#!/bin/bash

# 备份系统程序包

ad_root_path=$AD_ROOT_PATH
backup_path=$(pwd)"/backup/backup_dir"

if [[ ! -n $AD_ROOT_PATH ]];then
    ad_root_path="/adm/cdn_isms_huawei"
fi

tar -zcvf $backup_path/cdn_isms_huawei.tar.gz $ad_root_path
