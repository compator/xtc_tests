# Potential issues with the database schema
see all info in server/src/main/x/db.x

## How to build
```shell
gradle clean && gradle build
```
## How to test
- Upload the modules into the Platform
- Create the application e.g. schema
- Use curl or Postman and send a POST request to <app-URL>/api/add with a string in the body

Example with curl
```shell
curl -v -k -X POST -d somesting https://schema.localhost.xqiz.it/api/add
```
