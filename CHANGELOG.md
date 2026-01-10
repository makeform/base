# Change Logs

## v2.0.0

 - support @grantdash/composer host


## v1.0.5

 - fix bug: fallback `data` to `{}` to prevent exceptions


## v1.0.4

 - fix bug: when `widget.deserialize` is called with `init` flag on, `meta` event won't be triggered, leading to possible incorrect visibility status based on disabled.
   - this bug fix depends on `init` event of `@plotdb/form` in following release (`>=0.0.55`)


## v1.0.3

 - use `overflow-wrap` to break super long text instead of `word-break: break-all` which breaks all texts


## v1.0.2

 - hide disabled widget


## v1.0.1

 - upgrade dependencies to fix vulnerabilities
 - bug fix: typo `retrun` which should be `return`


## v1.0.0

 - init release


