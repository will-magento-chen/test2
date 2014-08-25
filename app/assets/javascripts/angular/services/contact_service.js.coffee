@app.factory "Contact", ["Restangular", (Restangular) ->
  new class Contact
    constructor: ->

    get: (id)->
      Restangular.one("contacts", id).get()

    all: (params) ->
      Restangular.all("contacts").getList(params)

    create: (attrs) ->
      restangular = Restangular.all("contacts")
      #return a promise to the post to be handled by controller
      restangular.post(attrs)

    update: (resource) ->
      Restangular.one("contacts", resource.id).patch(resource)

    delete: (resource) ->
      Restangular.one('contacts', resource.id).remove()
]
