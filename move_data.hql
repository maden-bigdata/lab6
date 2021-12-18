-- Source: https://stackoverflow.com/questions/34050294/hive-create-table-partitions-from-file-name

use bigdata;

set hive.exec.dynamic.partition.mode=nonstrict;
SET hive.exec.compress.output=true;
set hive.exec.parallel=true;
SET mapred.output.compression.codec=org.apache.hadoop.io.compress.SnappyCodec;

insert overwrite table userlog
partition (userid, hvalue)
select *,
    cast(substr(split(split(INPUT__FILE__NAME, "/")[5], "[.]")[2], 2) as int) as userid,
    cast(substr(split(split(INPUT__FILE__NAME, "/")[5], "[.]")[1], 2) as int) as hvalue
from external_userlog;
