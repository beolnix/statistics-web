Restful micro web-service to collect statistics gathered by the bot and exposes endpoints for the webinterface to fetch aggregated statistics.

REST interface documentation: [swagger-ui](https://statistics.buildloft.com/swagger/swagger-ui.html)

Sources: [github](https://github.com/beolnix/marvin-statistics)

Build artifact: **docker image**

Dependencies:

 * **MongoDB**: There is an example of an [example](https://github.com/beolnix/marvin-statistics/blob/master/statistics-service/src/main/docker/docker-compose.yml) of the `docker-compose.yml` file which is used to setup containers composition

Technologis:

 * java 8
 * spring
 * mongo driver - the classic one
