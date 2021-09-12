

# covid-saliva-db

Status: trying to understand whats needed

DB-System: Microsoft SQL Server

DB System location: Testsystems: Local Containe DB. Production: USZ

The data is not explicitly connected with personal data like names or addresses.

Initial DB roles: Admin, Read, Write.

# db schema


create login dbreader WITH PASSWORD = 'hahahathiswillbeexchanged29839283';
Create user dbreader for login dbreader
create user dbreader for login dbreader



## development environment installation on a windows machine

Remark: Can also be run on a Mac or Linux box, if needed.

Install Docker Desktop

https://www.docker.com/products/docker-desktop

Install mssql-server management studio approx. 675 MByte

https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver15

Get some kind of bash with git running. On windows, git bash is a good choice.

https://www.educative.io/edpresso/how-to-install-git-bash-in-windows


Start DB-Container

docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=adskladf49XLJjieuwo' -p 1433:1433 --name 'corona-saliva-db' -d mcr.microsoft.com/mssql/server:2017-CU8-ubuntu
