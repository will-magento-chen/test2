@app.controller "CommentCtrl", ["$scope", "$timeout", "$routeParams", "Comment", \
                ($scope, $timeout, $routeParams, Comment) ->

  $scope.comments = []
  $scope.comment = null
  $scope.alerts = []

  $scope.getComments = (commentable_type, commentable_id) ->
    params = 
      commentable_id: commentable_id
      commentable_type: commentable_type

    Comment.all(params)
    .then (res) ->
      $scope.comments = res

    .catch (errResponse) ->
      console.log(errResponse)

  $scope.createComment = (commentable_type, commentable_id) ->
    params = 
      commentable_id: commentable_id
      commentable_type: commentable_type
      comment: $scope.comment
      
    Comment.create(params)
    .then (res) ->
      $scope.comments.push res
    .catch (errResponse) ->
      console.log(errResponse)

  $scope.deleteComment = (comment) ->
    Comment.delete(comment)
    .then (res) ->
      index = $scope.comments.findIndex((e)-> e.id == comment.id)
      $scope.comments.splice index, 1
    .catch (errResponse) ->

]
