CREATE TABLE run (
       id int IDENTITY(1, 1),
       string_date varchar(20),
       op_id varchar(32),
       route varchar(128),
       trip_miles float,
       unit varchar(4),
       trip_time tinyint,
       primary key date
);



CREATE TABLE run (
       string_date varchar(20),
       op_id varchar(32),
       route varchar(128),
       trip_miles float,
       unit varchar(4),
       trip_time smallint
);


