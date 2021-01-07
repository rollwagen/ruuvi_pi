# ruuvi

### Docker: InfluxDB
```sh
docker run --name=influxdb -d -p 8086:8086 influxdb
docker exec -it influxdb influx
```

```
create database ruuvi
show databases

use database ruuvi
show measurements
select * from ruuvi_measurements
```

### Docker: Grafana
```
docker run --name=grafana -d -p 3000:3000 grafana/grafana
```
*Panels:*

Humidity:
```
SELECT mean("humidity") FROM "autogen"."ruuvi_measurements" WHERE $timeFilter GROUP BY time($__interval), "mac" fill(null)
```
Temperature:
```
SELECT mean("temperature") FROM "autogen"."ruuvi_measurements" WHERE $timeFilter GROUP BY time($__interval), "mac" fill(null)
```


### Ruuvi-Collector:Building


:warning: InfluxDB connection hardcoded in Dockerfile, see 
`RUN echo "influxUrl=http://192.168.1.20:8086" > ruuvi-collector.properties`

```sh
./build.sh
```

### Ruuvi-Collector:Running
```sh
docker run --name ruuvi-collector --privileged --net=host --detach --restart always ruuvi-collector
```

### Links / References

[Collecting RuuviTag measurements and displaying them with Grafana](https://f.ruuvi.com/t/collecting-ruuvitag-measurements-and-displaying-them-with-grafana/267)

[Setting up Raspberry Pi as a Ruuvi Gateway](https://blog.ruuvi.com/rpi-gateway-6e4a5b676510)

[Heise.de: Geschichtsschreiber - InfluxDB](https://www.heise.de/select/ct/2019/5/1551091687444779)

