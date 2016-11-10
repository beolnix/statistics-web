## Project details
The project consist of several parts:

* Bot
* Bot plugin
* REST web-service
* Web interface to REST web-service

### Bot
Marvin is a bot with dynamic osgi based plugin system. Right now it supports IRC, Skype and Telegram protocols only but it was designed with support of other protocols in mind.

Sources: [github](https://github.com/beolnix/marvin)

Build artifact: **distr, ready to copy paste and run**
 
Technologies stack:

  * java 8
  * spring
  * osgi

### Bot plugin
It is an osgi plugin for the bot. It counts messages sent by users and pushes the gathered statistics to the RESTful web-service over https every 15s.

Sources: [github](https://github.com/beolnix/marvin-statistics-plugin)

Build artifact: **jar file**

Dependencies:

 * **Bot**: plugin should be placed to the plugins directory of the bot where it will be picked up on the fly
 * **RESTful web-service**: as it publishes statistics there
 * **Key & Secret**: these are used to pass app authentication & authorization on the web-service side

Technologies:

 * java 8
 * spring
 * feign - generates REST http client based on java interface
 * ribbon - client side load balancer


### RESTful web-service
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

### Web interface
Something written on coffescript which draws fancy charts you see when you open link to the statistics provided by the bot plugin.

Sources: [github](https://github.com/beolnix/statistics-web)

Dependencies:

 * **nginx** - or anything else what could serve static files
 
Technologies:

 * **npm** & **bower** & **gulp** 
 * **coffescript**
 * **angular**
 * **c3js** - char lib
 * ... dozen of other js frameworks, they are just works but I know almost nothing about them




