FROM postgres
COPY sql/* /docker-entrypoint-initdb.d/

ENV POSTGRES_DB=mpo 
ENV POSTGRES_USER=peak 
ENV POSTGRES_PASSWORD=peak007
EXPOSE 5432
