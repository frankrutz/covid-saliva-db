FROM python:3
WORKDIR /app
ADD requirements.txt .
ADD main.py .
COPY pcrtestdata.csv .
COPY parse_excel.py .


#Optional
#ENV https_proxy=http://[proxy]:[port]
#ENV http_proxy=http://[proxy]:[port]

# install FreeTDS and dependencies
RUN apt-get update \
 && apt-get install unixodbc-dev -y \
 && apt-get install freetds-dev -y \
 && apt-get install freetds-bin -y \
 && apt-get install tdsodbc -y \
 && apt-get install --reinstall build-essential -y

RUN apt-get install vim -y

# populate "ocbcinst.ini" as this is where ODBC driver config sits
RUN echo "[FreeTDS]\n\
Description = FreeTDS Driver\n\
Driver = /usr/lib/x86_64-linux-gnu/odbc/libtdsodbc.so\n\
Setup = /usr/lib/x86_64-linux-gnu/odbc/libtdsS.so" >> /etc/odbcinst.ini
#Pip command without proxy setting
RUN pip install -r requirements.txt
RUN pip install panda
RUN pip install pandas
#Use this one if you have proxy setting
#RUN pip --proxy http://[proxy:port] install -r requirements.txt
CMD ["python","-i","main.py"]
