locallyApp = angular.module("locallyApp", [
  'locallyAppCtrls', 
  'locallyAppRouter', 
  'locallyAppService',
  'ui.bootstrap', 
  'auth'
  ])

locallyApp.config(["$httpProvider", ($httpProvider)->
     $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
])





