FROM mcr.microsoft.com/mssql/server:2022-latest


# Accept license agreement
ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=Vjezbe123!

USER root

COPY ./northwind-pubs /opt/sql/
COPY ./init-northwind.sql /opt/sql/init-northwind.sql
COPY ./entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]