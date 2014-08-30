@app.controller "CommentCtrl", ["$scope", "$timeout", "$routeParams", "Comment", \
                ($scope, $timeout, $routeParams, Comment) ->

  $scope.comments = []
  $scope.comment = {}
  $scope.alerts = []

  $scope.init = ()->
    $scope.getComments()

  $scope.getComments = ->
    Comment.all(params)
    .then (res) ->
      $scope.comments = res

    .catch (errResponse) ->
      console.log(errResponse)

  $scope.createComment = (commentable_type, commentable_id)
]
