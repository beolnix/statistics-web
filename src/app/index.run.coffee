class Index extends Run
  constructor: ($log, $http) ->
    $log.debug 'runBlock end'
    $http.defaults.headers.common["X-KEY"] = "read_only_key"
    $http.defaults.headers.common["X-SECRET"] = "gadkfjljijkavhamxkdf84j21fh3"
