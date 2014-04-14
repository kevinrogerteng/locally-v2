locallyAppCtrls = angular.module("locallyAppCtrls", [])

locallyAppCtrls.controller('userCtrl', ["$scope", "Api", "$location", "AuthService"
  ($scope, Api, $location, AuthService) ->
    $scope.credentials = {}
    $scope.newCredentials ={}
    $scope.attemptLogin = ()->
      console.log($scope.credentials)
      # Api.LogIn.create({'email':$scope.credentials.email, 'password':$scope.credentials.password}, (data)->
      #   if (data.success)
      #     console.log(data.success)
        #   $scope.error = data.error
        #   AuthService.userIsAuthenticated = false
        # else
        #   AuthService.setUserAuthenticated(true, data)
        #   $location.path("/")
        # )

    $scope.createUser = () ->
      console.log($scope.newCredentials)

  ])