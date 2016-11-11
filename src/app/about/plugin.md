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
