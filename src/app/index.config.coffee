class AppConfig extends Config
  constructor: ($logProvider, toastrConfig, markdownConverterProvider) ->
    # Enable log
    $logProvider.debugEnabled true
    # Set options third-party lib
    toastrConfig.allowHtml = true
    toastrConfig.timeOut = 3000
    toastrConfig.positionClass = 'toast-top-right'
    toastrConfig.preventDuplicates = true
    toastrConfig.progressBar = true

#    $showdownProvider.loadExtension('twitter')
#
#    markdownConverterProvider.config({
#      extensions: ['twitter']
#    })


