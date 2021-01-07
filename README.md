# ruuvi_pi

### Building

---
:warning: InfluxDB connection hardcoded in Dockerfile `RUN echo "influxUrl=http://192.168.1.20:8086" > ruuvi-collector.properties`
---

```sh
./build.sh
```

### Running
```sh
docker run --name ruuvi-collector --privileged --net=host --detach --restart always ruuvi-collector
```
