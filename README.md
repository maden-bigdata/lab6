# Практика 6

В файле $HADOOP_HOME/etc/hadoop/mapred-site.xml добавить:

    <property>
        <name>mapreduce.jobhistory.address</name>
        <value>localhost:10020</value>
    </property>

Запустить:

    $HADOOP_HOME/sbin/start-all.sh

    $HIVE_HOME/bin/hive --service metastore &
    $HIVE_HOME/bin/hive --service hiveserver2 &

Создать директорию в dfs и положить в нее файлы:

    hdfs dfs -mkdir /user/bigdata
    hdfs dfs -put /home/maden/bigdata/rawdata/v5/* /user/bigdata

Проверить, что файлы добавились:

    hdfs dfs -ls /user/bigdata

Запустить скрипт создания таблиц:

    $HIVE_HOME/bin/beeline -n maden -u jdbc:hive2://localhost:10000 -f create_tables.hql

Проверить, что данные доступны во внешней таблице (ограниченное количество записей):

    $HIVE_HOME/bin/beeline -n maden -u jdbc:hive2://localhost:10000
```
use bigdata;

select *,
cast(substr(split(split(INPUT__FILE__NAME, "/")[5], "[.]")[2], 2) as int) as userid,
cast(substr(split(split(INPUT__FILE__NAME, "/")[5], "[.]")[1], 2) as int) as hvalue
from external_userlog
limit 5;
```

Выйти (Ctrl+C)

Запустить перенос данных:

    $HIVE_HOME/bin/beeline -n maden -u jdbc:hive2://localhost:10000 -f move_data.hql

