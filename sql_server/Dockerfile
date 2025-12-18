FROM mcr.microsoft.com/mssql/server:2022-latest


# Accept license agreement
ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=CHANGEpass1!

USER root

COPY ./setup_init_db.sql /opt/sql/setup_init_db.sql
COPY ./entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]