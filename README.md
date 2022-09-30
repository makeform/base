# @makeform widgets

All @makeform blocks should provide a form.widget ( from `@plotdb/form` ) as its interface. There is no other requirement - or we can say that the widget spec defines the requirement.

However, to minimize duplicated works between blocks, you can build a form block by extending `@makeform/base`. In this case you should follow the requiredment of the `@makeform/base` block and implement accordingly.


## @makeform/base

Implement following parts when extending `@makeform/base`:

 - HTML
 - CSS
 - JS


### HTML

Implement `widget` plug ( for more about a `plug`, see `@plotdb/block` ) which will be used to plug into `@makeform/base`'s DOM.

Additionally, consider following `bootstrap`'s `form-group` + `label` structure when building a block-based widget. A possible construct of a widget:

    .form-group
      label.d-flex
        div
          div(ld="label")
          span.variant
        .flex-grow-1
        .m-edit(ld="limitation")
      .m-edit(ld-each="note")
      .m-view(ld="content")


There is no other requirement about HTML, however `@makeform/base` expects child blocks to implement their dynamics with `ldview` ( and thus the library is preloaded in `@makeform/base` ), so consider using `ldview` before implementing a form block.


#### Additional Concepts

 - `note`: list of additional notes for users. 
 - `limitation`: limitation of this field. should be short.
 - `variant`: variation of a certain field. e.g., `zh` and `en`.
 - `content`: content for viewing in view mode
 


### CSS Framework

`@makeform/base` is built upon CSS Framework of following:

 - bootstrap@4.6.1
 - @loadingio/bootstrap.ext
 - @loadingio/loading.css ( lite ) 
 - ldiconfont
 - ldbutton
 - ldcover

For other CSS libraries, please import them in separated blocks.


### CSS

Following CSS classes are preserved:

 - `m-edit`: widget is rendered in edit mode ( mutual exclusive with `m-view` )
 - `m-view`: widget is rendered in view mode ( mutual exclusive with `m-edit` )
 - `m-inline`: widget is rendered in inline mode
 - `has-variant`, `variant`
   - by default `variant` isn't displayed
   - use `has-variant` to show `variant` field.
 - `content`: by default, content is displayed as `pre-wrap`.


### JS

`@makeform/base`


## Other Design Consideration

 - we used to add `text-capitalize` in label but decide to remove it so user have total control of their label
