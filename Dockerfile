FROM postgres

COPY sql/* /docker-entrypoint-initdb.d/

ENV POSTGRES_DB=load 
ENV POSTGRES_USER=peak 
ENV POSTGRES_PASSWORD=mysql-pass
ENV PGDATA=/tmp

EXPOSE 5432
