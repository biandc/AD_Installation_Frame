#!/bin/bash



# 更新环境包

env_path=$(pwd)"/check_env/check_env_dir"


install_jpype(){
    # yum -y install java-1.8.0-openjdk
    # 解决 c++6
    # pip install JPype1==0.7.1
    cd $env_path/rpm && yum -y install ./*.rpm
    # \cp -rf $env_path/jpype /usr/local/lib/python2.7/site-packages/
    # \cp -rf $env_path/JPype1-0.7.1-py2.7.egg-info /usr/local/lib/python2.7/site-packages/
    cd -
}

python -c "import jpype" > /dev/null 2>&1 || install_jpype


\cp -rf $env_path/site-packages/* /usr/local/lib/python2.7/site-packages