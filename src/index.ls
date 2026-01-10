module.exports =
  pkg:
    host: name: \@grantdash/composer
    dependencies: [
    * name: "proxise"
    * name: "ldview"
    * name: "@plotdb/form"
    * name: \@grantdash/composer
    * name: \@grantdash/composer, path: \index.min.css, type: \css
    ]
    i18n:
      # TODO i18n for `required` should be provided from @plotdb/form.
      "en":
        "required": "required"
        "Sample Title": "Sample Title"
        "Sample Description": "Sample description for additional information"
      "zh-TW":
        "required": "必填"
        "Sample Title": "範例標題"
        "Sample Description": "用來增加額外說明的範例描述文字"
  interface: -> @widget
  init: ({root, data = {}, ctx, pubsub, i18n, t, host}) ->
    {form,composer} = ctx
    if data.i18n => i18n.addResourceBundles data.i18n
    data.{}config
    pubsub.on \init, (opt = {}) ~>
      hitf = opt.mod.hitf = composer {i18n, host, get: ~> data}
      @client = ->
        render: ->
        sample: ~>
          title: hitf.wrap "#{i18n.language}": t("Sample Title")
          desc: hitf.wrap "#{i18n.language}": t("Sample Description")
          is-required: true, config: {}
      # apply to child, since local css classes work under root
      # e.g., .cps.cps-composing .cps-remove doesn't work if .cps is on root
      root.childNodes.0.classList
        ..toggle \cps, !!host
        ..toggle \cps-composing, (host and hitf.readonly and !hitf.readonly!)
      @widget = new form.widget({root} <<< opt)
      @widget.on \mode, (m) ->
        if !root => return
        <[view edit config]>.map (n) -> root.classList.toggle "m-#n", m == n
      # widget should not be shown if disabled to prevent unaccidentally editing.
      @widget.on <[meta]>, (m) ~>
        root.classList.toggle \disabled, !!@widget._meta.disabled
        data <<< m
      if root => root.classList.toggle \m-edit, ((opt.mode or \edit) == \edit)
      @widget.init!then ~>
        @widget.deserialize(data or {}, {init: true})
        root.classList.toggle \disabled, !!@widget._meta.disabled
        @widget
      pubsub.fire \inited, {widget: @widget, hitf: hitf}
