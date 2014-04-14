locallyApp = angular.module("locallyApp", ['locallyAppCtrls', 'locallyAppRouter', 'ui.bootstrap'])

locallyAppCtrls = angular.module("locallyAppCtrls", [])

locallyAppCtrls.controller('userCtrl', ["$scope",
  ($scope) ->
    $scope.message = "hello world!"

  ])

locallyAppRouter = angular.module("locallyAppRouter", ["ngRoute"])

locallyAppRouter.config(['$routeProvider',
  ($routeProvider) ->
    $routeProvider.when("/"
    templateUrl: "/mains"
    controller: "userCtrl"
    )

  ])

