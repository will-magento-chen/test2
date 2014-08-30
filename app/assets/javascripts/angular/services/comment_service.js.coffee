@app.factory "Comment", ["Restangular", (Restangular) ->
  new class Comment
    constructor: ->

    get: (id)->
      Restangular.one("comments", id).get()

    all: (params) ->
      Restangular.all("comments").getList(params)

    create: (attrs) ->
      restangular = Restangular.all("comments")
      #return a promise to the post to be handled by controller
      restangular.post(attrs)
]
