# covid-saliva-db

##




## Development Environment Installation on a Windows machine

Install Docker Desktop

https://www.docker.com/products/docker-desktop

Install mssql-server management studio

https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver15

Start DB-Container

docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=adskladf49XLJjieuwo' -p 1433:1433 --name 'mydb' -d microsoft/mssql-server-linux
