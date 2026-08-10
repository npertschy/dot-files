; extends

; db.select("...", ...) and db.execute("...", ...)
(call_expression
  function: (member_expression
    property: (property_identifier) @_method
    (#any-of? @_method "select" "execute"))
  arguments: (arguments
    (string
      (string_fragment) @injection.content
      (#set! injection.language "sql"))))

(call_expression
  function: (member_expression
    property: (property_identifier) @_method
    (#any-of? @_method "select" "execute"))
  arguments: (arguments
    (template_string
      (string_fragment) @injection.content
      (#set! injection.language "sql"))))
