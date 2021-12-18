create database bigdata;
use bigdata;

CREATE TABLE userlog(Day int, TickTime double, Speed double) PARTITIONED BY (UserId int, HValue int) STORED AS PARQUET;

CREATE EXTERNAL TABLE external_userlog (Day int, TimeTick double, Speed double) ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' LOCATION '/user/bigdata';
