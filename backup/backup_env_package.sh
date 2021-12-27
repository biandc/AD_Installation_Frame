#!/bin/bash


# 备份系统环境包
backup_path=$(pwd)"/backup/backup_dir"

tar -zcvf $backup_path/adframe.tar.gz /usr/local/lib/python2.7/site-packages/adframe/