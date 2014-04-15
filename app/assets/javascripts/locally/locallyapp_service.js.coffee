locallyAppService = angular.module('locallyAppService', ['ngResource'])

locallyAppService.factory "Api", ($resource) ->
  LogIn: $resource("/sessions.json", {email: @email, password: @password}, {'create': {method: 'POST', isArray: false}})
  Trips: $resource("/trips.json", {id: @id}, {'update': {method: "UPDATE"}})