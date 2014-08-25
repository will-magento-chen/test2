@app.controller "ContactCtrl", ["$scope", "$timeout", "$routeParams", "Contact", \
                ($scope, $timeout, $routeParams, Contact) ->

  $scope.contacts = []
  $scope.contact = {}
  $scope.alerts = []

  $scope.init = ()->
    $scope.getContacts()

  $scope.getContacts = ->
    Contact.all(params)
    .then (res) ->
      $scope.contacts = res

    .catch (errResponse) ->
      console.log(errResponse)
]
