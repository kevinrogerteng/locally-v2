locallyAppCtrls = angular.module("locallyAppCtrls", [])

locallyAppCtrls.controller('userCtrl', ["$scope", "Api", "$location", "AuthService"
  ($scope, Api, $location, AuthService) ->

    $scope.credentials = {}

    $scope.newCredentials ={}

    $scope.closeSign = ()->
      $scope.signShow = false

    $scope.attemptLogin = ()->
      Api.LogIn.create({'email':$scope.credentials.email, 'password':$scope.credentials.password}, (data)->
        if (data.error)
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


locallyAppCtrls.controller('tripCtrl', ["$scope", "Api","AuthService", "$http", "limitToFilter", "$http", "$interval"
  ($scope, Api, AuthService, $http, limitToFilter, $interval) ->

    $scope.currentTrip = {}

    $scope.newtrip = {}

    $scope.newActivity ={}

    $scope.activitiesShow = true

    $scope.close = () ->
      $scope.newActivityForm = false
      $scope.yelpShow = true

    Api.Trips.get((data)->
      $scope.trips = data.trips
      )

    $scope.tripClick= (trip) ->
      $scope.activities = {}
      $scope.yelpResult = {}
      $scope.loading = true
      $scope.messageShow = false
      $scope.activitiesShow = true
      $scope.yelpShow = true
      $scope.tripDetailsShow = true
      $scope.newActivityForm = false
      $scope.newTrip = false
      $scope.currentTrip = trip
      indexOfTrip = $scope.trips.indexOf trip
      moveTrip = $scope.trips.splice(indexOfTrip, 1)[0]
      $scope.trips.unshift moveTrip

      Api.Activities.get({"trip_id": trip.id}, (data)->
        $scope.loading = false
        $scope.activities = data.activities
        )
      Api.Yelp.query({"destination": trip.destination},(data)->
        $scope.loading = false
        $scope.yelpResult = data
        )

    $scope.yelp ={}
    $scope.yelpSearch = ()->
      $scope.loading = true
      $scope.yelpResult = {}
      Api.Yelp.query({"destination": $scope.currentTrip.destination, "restaurant": $scope.yelp.search},(data)->
        $scope.loading = false
        $scope.yelpResult = data

        )

    $scope.createTrip = ()->
      $scope.currentTrip = {}
      $scope.newTrip = true
      $scope.yelpShow = false
      $scope.activitiesShow = false
      $scope.tripDetailsShow = false
      $scope.newActivityForm = false

    $scope.createActivity = ()->
      $scope.newActivityForm = true
      $scope.yelpShow = false

    $scope.addToActivity = (yelpActivity, currentTrip)->
      $scope.activities.unshift yelpActivity
      $http({
        method: "POST",
        url: "/trips/" + currentTrip.id + "/activities.json"
        data: {"activity":yelpActivity}
      }).success((data)->
          $scope.message = data
          $scope.messageShow = true
        )


    $scope.templates = [{url: "/templates/showTrips.html"}, {url: "/templates/newTripForm.html"}, {url: "/templates/showActivitiesstuff.html"},{url: "/templates/newActivityForms.html"}, {url: "/templates/yelpShow.html"}]
    $scope.loader = {url: "/images/load.gif"}

    $scope.submitTrip = () ->
      Api.Trips.save($scope.newtrip, (data)->
        if data.success
          $scope.trips.unshift data.new_trip
          $scope.messageShow = true
          $scope.newTrip = false
          $scope.message = data
          $scope.newtrip = {}
        )

    $scope.submitActivity = () ->
      $http({
        method: "POST"
        url: "/trips/" + $scope.currentTrip.id + "/activities.json"
        data: {"activity":$scope.newActivity}
      }).success((data)->
          $scope.activities.unshift data.new_activity
          $scope.newActivityForm = false
          $scope.yelpShow = true
          $scope.newActivity = {}
        )

    $scope.cities = (cityName) ->
      $http.jsonp("http://gd.geobytes.com/AutoCompleteCity?callback=JSON_CALLBACK &filter=US&q=" + cityName).then (response) ->
        limitToFilter response.data, 15

  ])


