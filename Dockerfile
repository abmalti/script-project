## Local Data Base

# docker build -t postgres-local:v1 .
# docker run -p 5432:5432 --name postgres-local postgres-local:v1

FROM postgres

COPY sql/* /docker-entrypoint-initdb.d/

ENV POSTGRES_DB=load 
ENV POSTGRES_USER=peak 
ENV POSTGRES_PASSWORD=mysql-pass
ENV PGDATA=/tmp

EXPOSE 5432
