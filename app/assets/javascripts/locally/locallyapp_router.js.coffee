locallyAppRouter = angular.module("locallyAppRouter", ["ngRoute"])

locallyAppRouter.config(['$routeProvider',
  ($routeProvider) ->
    $routeProvider.when("/"
    templateUrl: "/mains"
    controller: "userCtrl"
    )
  ])