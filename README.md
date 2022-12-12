## Pihole_Influx

A couple of basic scripts for inserting pihole data into influxdb for graphing.

*pihole_influxdb2.py* - A python script for inserting records into influxdb (2.x-version).

If you need the version for InfluxDB 1.x, visit https://github.com/pluim003/pihole_influx

Configuration options:
``` bash
INFLUXDB_V2_URL = "127.0.0.1:8086" # IP or hostname to InfluxDB server with port
INFLUXDB_V2_TOKEN = "<token>" # INFLUXDB-token (can be optained by using the value for INFLUX_TOKEN in your influx-confi
INFLUXDB_V2_ORG = "my-org" # Organization to be used
INFLUXDB_BUCKET = "pihole"
DELAY = 600 # seconds
PIHOLE_HOSTS = "ns-01" # Pi-hole hostname(s) to report in InfluxDB for each measurement. Comma separated list.
PIHOLE_TOKENS = "token1" # Pi-hole token(s) to use to connect to the API. Comma separated list. Token can be captured from value WEBPASSWORD in setupVars.conf in /etc/pihole.
```
*docker-compose.yml* - An example Docker setup to run this script

Configuration options above can be specified within the environment section of the compose file.

*pihole-influx.service* - A SystemD Unit File for starting pihole_influx at boot (and logging)
On Centos7, put this file in /lib/systemd/system/.

Run:
``` bash
systemctl daemon-reload
systemctl enable pihole-influx
systemctl start pihole-influx
```

To run pihole_influxdb2.py from the command line without the startup script:
```bash
/usr/bin/python ./pihole_influxdb2.py
```

I only use the docker-variant.
You could instal this script in /opt/dockerhub_influx. If you put it somewhere else you'll have to update the systemD startup script.

### Note

I have only tested this script to export to InfluxDB v2.5.1. I'm running a container with Influxdb 2.5.1 and latest versions of Grafana and Telegraf. I expect it will work with all InfluxDB v2.x-releases but if you encounter issues with earlier releases feel free to file an issue.

### Troubleshooting
If you get the following error:
```
Traceback (most recent call last): File "./pihole_influxdb2.py", line 11, in <module> from influxdb import InfluxDBClient
```
You'll need to install the python-influxdb module for python.  On a raspberry pi, you can do this with:
```
sudo apt-get install python-influxdb
```

Or on CentOS / RHEL:
```
yum install python-influxdb
```
---

If you get this error:
```
Traceback (most recent call last): File "./pihole_influxdb2.py", line 8, in <module> import requests ImportError: No module named requests
```
You'll need to install the python-requests module.

### Credits

Credits go to https://github.com/chrisbergeron/ for supplying the pihole_influx-script. After some modifications earlier I decided to make it suitable to for InfluxDB 2.x.

