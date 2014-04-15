authService = angular.module("auth", [])

authService.service("AuthService", [
  ()->
    @userIsAuthenticated = false
    @currentUser = {}

    @setUserAuthenticated = (value, user) ->
      @userIsAuthenticated = value
      return @currentUser = user
    
    @getUserAuthenticated = () ->
      return @userIsAuthenticated

    @getCurrentUser = () ->
      return @currentUser
    return
  ])
