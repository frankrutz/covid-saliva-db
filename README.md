

# covid-saliva-db

Status: trying to understand whats needed

DB-System: Microsoft SQL Server

DB System location: Testsystems: Local Container DB. Production: USZ

The data is not explicitly connected with personal data like names or addresses.

Initial DB roles: Admin SA, Read dbreader, Write dbwriter

# open questions

What do we do with the "Master Mix Calculation" sheet?

# db schema

TODO_FRANK move this to create_db.sql
```
create login dbreader WITH PASSWORD = 'hahahathiswillbeexchangeX..Pd29839283';
Create user dbreader for login dbreader

create login dbwriter WITH PASSWORD = 'hahahathiswillbeexchangeX..Pd2983234329283';
Create user dbwriter for login dbwriter

drop database if exists coronasalivadb
create database coronasalivadb




drop table if exists origin_excel;
create table origin_excel (
    --general info--------------------------------------------
    excelname varchar(12),
	excelimported timestamp,
    
    --upper left----------------------------------------------
    dokumentart varchar(255),
    erfasstDurch varchar(255),
    geltungsbereich varchar(255),
    erstelltDurch varchar(255),
    version date,
    gueltigAb date,
    ersetzt date,
    kurztitel varchar(255),
    runsheetstorage varchar(255)
);
grant select on origin_excel to dbreader
grant update on origin_excel to dbwriter


drop table if exists plate96
create table plate96 (
	fk_excelname varchar(12),   --foreign key into origin_excel
	platetable int,             --allowed values 1...4
	platecolumn int,            --allowed values 1..12
	row varchar(1),             --allowed values A,B,...,H
	code int
)
grant select on plate96 to dbreader
grant update on plate96 to dbwriter


drop table if exists plate384  --do we really need this or this this redundant info from plate96???? or we not need plate 96?
create table plate384 (
	fk_excelname varchar(12),   --foreign key into origin_excel
	platecolumn int,            --allowed values 1..24
	row varchar(1),             --allowed values A,B,...,P
	code int,

    --results
	code_control int,            --we parse it again from the excel, should be the same as in origin_exel, quality control ....
	plate_key varchar(10),
	viral_rna int,
	degradation_control int,
	inhibition_control int,
	result varchar(12),          --allowed values POSITIV, NEGATIV, ???
	qc varchar(12),              --allowed values VALID, ???
	interpretation varchar(12)   --allowed values NEGATIVE,???
)
grant select on plate384 to dbreader
grant update on plate384 to dbwriter


drop table if exists  qcr384_well_info
create table qcr384_well_info(
   fk_excelname varchar(12),   --foreign key into origin_excel
   file_name varchar(255),
   pk_qcr_file_name varchar(255),  --Primary Key derived from file_name above, without path.
   comment varchar(255),
   operator varchar(255),
   barcode varchar(255),
   instrument_type varchar(255),
   instrument_serial_number varchar(255),
   heated_cover_serial_number varchar(255),
   block_serial_number varchar(255),
   run_start_date_time datetime,
   run_end_date_time datetime,
   sample_volume float,
   cover_temperature float,
   passive_reference varchar(255),
   pcr_stage_step_number varchar(255),
   quantification_cycle_method varchar(12),
   analysis_date_time datetime,
   software_name_version varchar(255),
   plugin_name_and_version varchar(255),
   exported_on datetime
)
grant select on qcr384_well_info to dbreader
grant update on qcr384_well_info to dbwriter


drop table if exists qcr384_well_results   --supplier name: PcrOutput
CREATE TABLE [dbo].qcr384_well_results(
	   [fk_qcr_file_name] [varchar](255) NOT NULL,   --foreign key into qcr384_well_info
       [Well] [int] NULL,
       [Well_Position] [nvarchar](50) NULL,
       [Omit] [nvarchar](50) NULL,
       [Sample] [nvarchar](50) NULL,
       [Target] [nvarchar](50) NULL,
       [Task] [nvarchar](50) NULL,
       [Reporter] [nvarchar](50) NULL,
       [Quencher] [nvarchar](50) NULL,
       [Amp_Status] [nvarchar](50) NULL,
       [Amp_Score] [float] NULL,
       [Curve_Quality] [nvarchar](1) NULL,
       [Result_Quality_Issues] [nvarchar](1) NULL,
       [Cq] [nvarchar](50) NULL,
       [Cq_Confidence] [float] NULL,
       [Cq_Mean] [float] NULL,
       [Cq_SD] [float] NULL,
       [Auto_Threshold] [nvarchar](50) NULL,
       [Threshold] [float] NULL,
       [Auto_Baseline] [nvarchar](50) NULL,
       [Baseline_Start] [tinyint] NULL,
       [Baseline_End] [tinyint] NULL
) ON [PRIMARY]

grant select on qcr384_well_results to dbreader
grant update on qcr384_well_results to dbwriter

```



## development environment installation on a windows machine

Remark: Can also be run on a Mac or Linux box, if needed.

Install Docker Desktop

https://www.docker.com/products/docker-desktop

Install mssql-server management studio approx. 675 MByte

https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver15

Get some kind of bash with git running. On windows, git bash is a good choice.

https://www.educative.io/edpresso/how-to-install-git-bash-in-windows


Start DB-Container

docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=adskladf49XLJjieuwo' -p 1433:1433 --name 'covid-db-server' -d mcr.microsoft.com/mssql/server:2017-CU8-ubuntu

You can now connect to  Servername  localhost,1433  (watch the comma, not a point) with Username SA and Password as above from mssql-server-mgmt-studio.


