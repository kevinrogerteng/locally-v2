locallyAppCtrls = angular.module("locallyAppCtrls", [])

locallyAppCtrls.controller('userCtrl', ["$scope", "Api", "$location", "AuthService"
  ($scope, Api, $location, AuthService) ->

    $scope.credentials = {}

    $scope.newCredentials ={}

    $scope.attemptLogin = ()->
      Api.LogIn.create({'email':$scope.credentials.email, 'password':$scope.credentials.password}, (data)->
        if (data.error)
          console.log(data.error)
          $scope.error = data.error
          AuthService.userIsAuthenticated = false
        else
          $scope.success = data.success
          AuthService.setUserAuthenticated(true, data.success)
          $location.path('/trips')
        )

    $scope.createUser = () ->
      console.log($scope.newCredentials)

  ])


locallyAppCtrls.controller('tripCtrl', ["$scope", "Api","AuthService"
  ($scope, Api, AuthService) ->

    $scope.currentTrip = {}

    Api.Yelp.query((data)->
        $scope.yelpResult = data
        )

    Api.Trips.get((data)->
      $scope.trips = data.trips
      )

    $scope.tripClick= (trip) ->
      $scope.currentTrip = trip
      $scope.activitiesShow = true
      $scope.tripDetailsShow = true
      Api.Activities.get({"trip_id": trip.id}, (data)->
        $scope.activities = data.activities
        )

    $scope.yelp ={}
    $scope.yelpSearch = ()->
      console.log($scope.yelp.search)

    $scope.createTrip = ()->
      $scope.currentTrip = {}
      $scope.activitiesShow = false
      $scope.tripDetailsShow = false



  ])


