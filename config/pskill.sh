#!/bin/bash

search='rails'
ps aux | grep $search | awk '{print $0}'
echo '执行了 这次的'
result=`ps aux | grep $search | awk '{print $2}'`

echo '------------------------'
pids=$(echo $result | tr "\n" " ")
for i in $pids
do
 kill -9 $i
 echo '已杀死进程: ' $i
done
