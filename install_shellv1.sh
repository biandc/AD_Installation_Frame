#!/bin/bash
#
#
#
# @author:dc
#
# 安装框架
#
######################################################################################
# 临时文件
TMPFILE="echo.temp.txt"

# .sh文件列表
SHFILESLIST=$(find ./ -maxdepth 2 -name "*.sh")
# backup_install .sh 文件
SHFILESB=$(echo "$SHFILESLIST" | tr " " "\n" | grep "backup")
# check_env_install .sh 文件
SHFILESE=$(echo "$SHFILESLIST" | tr " " "\n" | grep "check_env")
# copy_files_install .sh 文件
SHFILESF=$(echo "$SHFILESLIST" | tr " " "\n" | grep "copy_files")
# run_script_install .sh 文件
SHFILESR=$(echo "$SHFILESLIST" | tr " " "\n" | grep "run_script")

# .sh文件个数
SHFILESNUM=$(echo "$SHFILESLIST" | tr " " "\n" | wc -l)

# 每执行完一个文件占用的百分比
PNUM=$(echo $((100/$SHFILESNUM)))

## 进度条变量
# 进度条#号每次增长 PNUM 个 #
BAR=$(for (( n=1; n<=$PNUM; n++ )) ; do printf ">" ; done)
# 进度条总百分比
TOTALPNUM=$PNUM
# 进度条#号
TOTALBAR=$BAR
#printf "[%-100s][%d%%][\e[43;46;1m%c\e[0m]\r" "$bar" "$i" "${arr[$index]}"
#printf "[%d%%][%-100s]\r\n" "$TOTALPNUM" "$TOTALBAR"

# @刷新终端输出
print_to_terminal(){
    sleep 1
    # clear
    # reset
    printf "\033c"
    cat ./$TMPFILE
    printf "\n\n\n[%d%%][%-100s]\r\n" "$TOTALPNUM" "$TOTALBAR"
}

# @echo_dc:输出函数
echo_dc(){
    echo $@ >> ./$TMPFILE
    print_to_terminal
}

# @更新进度条参数
update_total(){
    TOTALPNUM=$(($TOTALPNUM+$PNUM))
    TOTALBAR+=$BAR
}

# @core
core(){
    echo_dc "-- start $1 --"
    for filename in $2;
    do
        bash $filename > ./$filename.out 2>&1
        if [ $? -eq 0 ];then
            update_total
            echo_dc -e "\033[32mrun $filename success!!!\033[0m"
        else
            update_total
            echo_dc -e "\033[31mrun $filename error!!!\033[0m"
        fi
        
    done
    echo_dc "-- end $1 --"
}

# @backup
backup_install(){
    core "backup" "$SHFILESB"
}

# @check environment
check_env_install(){
    core "check environment" "$SHFILESE"
}

# @copy files
copy_files_install(){
    core "copy files" "$SHFILESF"
}

# @run script
run_script_install(){
    core "run script" "$SHFILESR"
}

# @start_main
start_main(){
    echo -e "\033[34mstart install_shell.sh .....\033[0m" > ./$TMPFILE
    print_to_terminal
}

# @end_main
end_main(){
    TOTALBAR+=${TOTALBAR::$((100-$(echo ${#TOTALBAR})))}
    TOTALPNUM=100
    echo_dc -e "\033[34mend install_shell.sh .....\033[0m"
}

# main
main(){
    start_main
    backup_install
    check_env_install
    copy_files_install
    run_script_install
    end_main
}

# run
main
