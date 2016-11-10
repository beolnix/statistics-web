## Project description
Web-interface for the RESTful webservice [marvin-statistics](https://github.com/beolnix/marvin-statistics)

## Requirements
* npm
* bower
* gulp

## Build from sources
To build from sources just run the following commands inside the checked out repository
```
$ npm install && bower install
$ gulp build
```
If everything is fine, the result will be in the **distr** directory

## Dependencies
* [backend](https://github.com/beolnix/marvin-statistics) must be up and running
* the content of the distr library must be served by something ... for example by **nginx**
 
## Development
For the development **gulp** constructed in the way that it proxies requests to the backend api to the live backend instance.
Just run `gulp serve` and you will see.  

 
