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

locallyAppCtrls.controller("navBarCtrl", ["$scope", "AuthService", "$location", "$http",
  ($scope, AuthService, $location, $http) ->
    $scope.signOut = () ->
      $http({
        method: "DELETE"
        url: "/sessions/" + $scope.currentUser.id + ".json"
        }).success((data)->
          AuthService.setUserAuthenticated(false, {})
          console.log(data.success)
          $location.path("/")
          )
  ])


locallyAppCtrls.controller('tripCtrl', ["$scope", "Api", "AuthService", "$http", "limitToFilter", "$http", "$interval", "$location", "$routeParams",
  ($scope, Api, AuthService, $http, limitToFilter, $interval, $location, $routeParams) ->

    $scope.currentTrip = {}

    $scope.currentActivity = {}

    $scope.newtrip = {}

    $scope.newActivity = {}

    $scope.currentUser = AuthService.getCurrentUser()

    $scope.showAllTrips = true

    $scope.close = () ->
      $scope.newActivityForm = false
      $scope.showAllTrips = true
      $scope.activitiesShow = false

    Api.Trips.get((data)->
      $scope.trips = data.trips
      )

    $scope.tripClick= (trip) ->
      $scope.activities = {}
      $scope.yelpResult = {}
      $scope.activityShow = false
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
      $scope.showAllTrips = false
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


    $scope.templates = [{url: "/templates/showTrips.html"}, {url: "/templates/newTripForm.html"}, {url: "/templates/showActivitiesstuff.html"},{url: "/templates/newActivityForms.html"}, {url: "/templates/yelpShow.html"}, {url: "/templates/userSign.html"}]
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

    $scope.activityClick = (activity) ->
      $scope.yelpShow = false
      $scope.activityShow = true
      $scope.singleActivity = activity
      $scope.currentActivity = activity

      if activity.completed is true
        $scope.done = true
      else
        $scope.done = false

    $scope.yelpRefresh = () ->
      $scope.yelpResult = {}
      $scope.loading = true
      Api.Yelp.query({"destination": $scope.currentTrip.destination},(data)->
        $scope.loading = false
        $scope.yelpResult = data
        )

    $scope.activityComplete = (activity) ->
      if $scope.done is false
        $scope.done = true
      else
        $scope.done = false

      indexOfActivity = $scope.activities.indexOf activity
      $scope.activities[indexOfActivity].completed = $scope.done

      $http({
        method: "PATCH"
        url:"/trips/" + $scope.currentTrip.id + "/activities/" + activity.id + ".json"
        data: {"activity": activity}
        }).success((data)->
          console.log(data.success)
          )
      


  ])


