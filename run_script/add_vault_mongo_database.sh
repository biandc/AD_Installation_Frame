#!/bin/bash



# 添加mongo金库数据库库
run_path=$(pwd)"/run_script/run_script_dir"

cd $run_path


mongorestore -u root -p aodunISMS_2015 --authenticationDatabase admin -d vault_4a $run_path/vault_4a_db/vault_4a/

cd -
