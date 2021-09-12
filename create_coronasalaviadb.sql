create login dbreader WITH PASSWORD = 'hahahathiswillbeexchangeX..Pd29839283';
Create user dbreader for login dbreader

create login dbwriter WITH PASSWORD = 'hahahathiswillbeexchangeX..Pd2983234329283';
Create user dbwriter for login dbwriter

drop database if exists covidsalivadb
create database covidsalivadb

use covidsalivadb


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


drop table if exists employees
--SET ANSI_NULLS ON
--SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].employees(
     [PERS_ID] [int] NULL,
     [ANRED] [nvarchar](50) NULL,
     [NACHN] [nvarchar](50) NULL,
     [VORNA] [nvarchar](50) NULL,
     [PERNR] [int] NULL,
     [OEKURZBEZ] [nvarchar](50) NULL,
     [EMAILAN] [nvarchar](50) NULL,
     [KOSTL] [int] NULL,
     [BERLANG] [nvarchar](50) NULL,
     [ORGEH] [int] NULL,
     [OELANGBEZ] [nvarchar](50) NULL,
     [PERSTEILBER] [nvarchar](50) NULL,
     [INTERNE_POSTADRESSE] [nvarchar](1) NULL,
     [LOBNR] [int] NULL
) ON [PRIMARY]

grant select on employees to dbreader
grant update on employees to dbwriter
