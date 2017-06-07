# Wiremock - Docker

## Proxy & Record

```
docker build --tag wiremock-record  --build-arg runtime_options='--proxy-all=http://services.groupkt.com/ --record-mappings' .  
```

## Run with host mounted wiremock working directories

```
docker run -d -p 8081:8080 -v ~/wirem/__files:/wiremock/__files -v ~/wirem/mappings:/wiremock/mappings  wiremock-record
```

### Record a lookup for country France
```
curl "http://localhost:8081/country/get/iso2code/FR"
```

## Run without real service

```
docker build --tag wiremock-bare  --build-arg runtime_options=  .
```

## Run with host mounted wiremock working directories

```
docker run -d -p 8082:8080 -v ~/wirem/__files:/wiremock/__files -v ~/wirem/mappings:/wiremock/mappings  wiremock-bare
```
## Force reload from disk (required when you record something new)

```
curl -X:POST "http://localhost:8082/__admin/mappings/reset"
```

## Wiremock arguments

--proxy-all=some cool API URI --record-mappings  
--https-keystore  
--keystore-password  
--https-truststore  
--truststore-password  
--https-port  



