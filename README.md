

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
create database covidsalivadb


create login dbreader WITH PASSWORD = 'hahahathiswillbeexchangeX..Pd29839283';
Create user dbreader for login dbreader


create login dbwriter WITH PASSWORD = 'hahahathiswillbeexchangeX..Pd2983234329283';
Create user dbwriter for login dbwriter


drop table origin_excel;
create table origin_excel (
    --general info--------------------------------------------
    excelname varchar(12),
    excelstored timestamp,
    
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


drop table plate96
create table plate96 (
	fk_excelname varchar(12),   --foreign key into origin_excel
	platetable int,             --allowed values 1...4
	platecolumn int,            --allowed values 1..12
	row varchar(1),             --allowed values A,B,...,H
	code int
)
grant select on plate96 to dbreader
grant update on plate96 to dbwriter


drop table plate384  --do we really need this or this this redundant info from plate96???? or we not need plate 96?
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


drop table qcr384_results
--there seem to be some boolean attributes down below like ommit, auto_threshold. 
--because we don't have a datta manual, we treat these like text variables.
create table qcr384_results(
	fk_excelname varchar(12),   --foreign key into origin_excel
	well int,
	well_position varchar(4),    --A1 ... P24
	plat_ecolumn int,            --allowed values 1..24 derived from well_position
	row varchar(1),             --allowed values A,B,...,P derived from well_position
	ommit varchar(24),
	sample varchar(24),
	target  varchar(24),
	task  varchar(24),
	reporter  varchar(24),
	quencher  varchar(24),
	cq float,
	cq_mean float,
	amp_status  varchar(24),
	amp_score float ,
	curve_quality  varchar(24),
	result_quality_issues  varchar(24),
	cq_confidence float,
	cq_sd  varchar(24),
	auto_trheshold  varchar(24),
	threshold float,
	auto_baseline  varchar(24),
	baseline_start int,
	baseline_end int
)
grant select on qcr384_results to dbreader
grant update on qcr384_results to dbwriter


select * from plate384
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


