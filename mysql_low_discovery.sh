#!/bin/bash
#Fucation:mysql low-level discovery
#Script_name mysql_low_discovery.sh
discovery() {
            port=($(sudo netstat -tpln | awk -F "[ :]+" '/[m]ysql/ && /0.0.0.0/ {print $5}'))
            printf '{\n'
            printf '\t"data":[\n'
               for key in ${!port[@]}
                   do
                       if [[ "${#port[@]}" -gt 1 && "${key}" -ne "$((${#port[@]}-1))" ]];then
              socket=`ps aux|grep ${port[${key}]}|grep -v grep|awk -F '=' '{print $10}'|cut -d ' ' -f 1`
                          printf '\t {\n'
                          printf "\t\t\t\"{#MYSQLPORT}\":\"${port[${key}]}\"},\n"
                     else [[ "${key}" -eq "((${#port[@]}-1))" ]]
              socket=`ps aux|grep ${port[${key}]}|grep -v grep|awk -F '=' '{print $10}'|cut -d ' ' -f 1`
                          printf '\t {\n'
                          printf "\t\t\t\"{#MYSQLPORT}\":\"${port[${key}]}\"}\n"
                       fi
               done
                          printf '\t ]\n'
                          printf '}\n'
}
discovery

