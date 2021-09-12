

# covid-saliva-db

Status: trying to understand whats needed

DB-System: Microsoft SQL Server

DB System location: Testsystems: Local Container DB. Production: USZ

The data is not explicitly connected with personal data like names or addresses.

Initial DB roles: Admin SA, Read dbreader, Write dbwriter

# open questions

What do we do with the "Master Mix Calculation" sheet?

# db schema

See file create_covidsalivadb.sql

https://github.com/frankrutz/covid-saliva-db/blob/main/create_covidsalivadb.sql

## development environment installation on a windows machine

Remark: Can also be run on a Mac or Linux box, if needed.

Install Docker Desktop

https://www.docker.com/products/docker-desktop

Install mssql-server management studio approx. 675 MByte

https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver15

Clone this repository

git clone https://github.com/frankrutz/covid-saliva-db




Start DB-Container

docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=adskladf49XLJjieuwo' -p 1433:1433 --name 'covid-db-server' -d mcr.microsoft.com/mssql/server:2017-CU8-ubuntu

You can now connect to  Servername  localhost,1433  (watch the comma, not a point) with Username SA and Password as above from mssql-server-mgmt-studio.


