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


locallyAppCtrls.controller('tripCtrl', ["$scope", "Api","AuthService", "$http", "limitToFilter"
  ($scope, Api, AuthService, $http, limitToFilter) ->

    $scope.currentTrip = {}

    $scope.newtrip = {}

    Api.Trips.get((data)->
      $scope.trips = data.trips
      )

    $scope.tripClick= (trip) ->
      $scope.activitiesShow = true
      $scope.yelpShow = true
      $scope.tripDetailsShow = true
      $scope.newActivity = false
      $scope.newTrip = false
      $scope.currentTrip = trip
      Api.Activities.get({"trip_id": trip.id}, (data)->
        $scope.activities = data.activities
        )
      Api.Yelp.query({"destination": trip.destination},(data)->
        $scope.yelpResult = data
        )

    $scope.yelp ={}
    $scope.yelpSearch = ()->
      $scope.yelpResult = {}
      Api.Yelp.query({"destination": $scope.currentTrip.destination, "restaurant": $scope.yelp.search},(data)->
        $scope.yelpResult = data

        )

    $scope.createTrip = ()->
      $scope.currentTrip = {}
      $scope.newTrip = true
      $scope.yelpShow = false
      $scope.activitiesShow = false
      $scope.tripDetailsShow = false
      $scope.newActivity = false

    $scope.createActivity = ()->
      $scope.newActivity = true
      $scope.yelpShow = false


    $scope.templates = [{url: "/templates/newTrip.html"}, {url: "/templates/newActivity.html"}]

    $scope.submitTrip = () ->
      console.log($scope.newtrip)

    $scope.cities = (cityName) ->
      $http.jsonp("http://gd.geobytes.com/AutoCompleteCity?callback=JSON_CALLBACK &filter=US&q=" + cityName).then (response) ->
        limitToFilter response.data, 15

  ])


