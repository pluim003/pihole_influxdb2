FROM python:3.11-alpine

RUN pip install --no-cache-dir influxdb
RUN pip install --no-cache-dir influxdb_client

WORKDIR /usr/src/app

COPY pihole_influxdb2.py ./

CMD [ "python", "/usr/src/app/pihole_influxdb2.py" ]
