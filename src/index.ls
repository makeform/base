module.exports =
  pkg:
    dependencies: [
    * name: "proxise"
    * name: "ldview"
    * name: "@plotdb/form"
    ]
    i18n:
      # TODO i18n for `required` should be provided from @plotdb/form.
      "en": "required": "required"
      "zh-TW": "required": "必填"
  interface: -> @widget
  init: ({root, data, ctx, pubsub, i18n}) ->
    {form} = ctx
    if data.i18n => i18n.addResourceBundles data.i18n
    data.{}config
    pubsub.on \init, (opt = {}) ~>
      @widget = new form.widget({root} <<< opt)
      @widget.on \mode, (m) ->
        if !root => return
        <[view edit config]>.map (n) -> root.classList.toggle "m-#n", m == n
      # widget should not be shown if disabled to prevent unaccidentally editing.
      @widget.on <[meta init]>, ~> root.classList.toggle \disabled, !!@widget._meta.disabled
      if root => root.classList.toggle \m-edit, ((opt.mode or \edit) == \edit)
      @widget.init!then ~>
        @widget.deserialize(data or {}, {init: true})
        root.classList.toggle \disabled, !!@widget._meta.disabled
        @widget
