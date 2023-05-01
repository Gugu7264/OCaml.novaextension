; Modules
;--------

[(module_name) (module_type_name)] @constructor

; Types
;------

(
  (type_constructor) @type.builtin
  (#match? @type.builtin "^(int|char|bytes|string|float|bool|unit|exn|array|list|option|int32|int64|nativeint|format6|lazy_t)$")
)

[(class_name) (class_type_name) (type_constructor)] @identifier.type

[(constructor_name) (tag)] @tag

; Functions
;----------

(let_binding
  pattern: (value_name) @identifier.function
  (parameter))

(let_binding
  pattern: (value_name) @identifier.function
  body: [(fun_expression) (function_expression)])

(value_specification (value_name) @identifier.function)

(external (value_name) @identifier.function)

(method_name) @identifier.function.method

; Application
;------------

(
  (value_name) @identifier.function.builtin
  (#match? @identifier.function.builtin "^(raise(_notrace)?|failwith|invalid_arg)$")
)

(infix_expression
  left: (value_path (value_name) @identifier.function)
  (infix_operator) @operator
  (#eq? @operator "@@"))

(infix_expression
  (infix_operator) @operator
  right: (value_path (value_name) @identifier.function)
  (#eq? @operator "|>"))

(application_expression
  function: (value_path (value_name) @identifier.function))

; Variables
;----------

[(value_name) (type_variable)] @variable

(value_pattern) @identifier.argument

; Properties
;-----------

[(label_name) (field_name) (instance_variable_name)] @property

; Constants
;----------

(boolean) @value.boolean

[(number) (signed_number)] @value.number

[(string) (character)] @string

(quoted_string "{" @string "}" @string) @string

(escape_sequence) @string.escape

(conversion_specification) @string.escape

; Operators
;----------

(match_expression (match_operator) @keyword)

(value_definition [(let_operator) (and_operator)] @keyword)

[
  (prefix_operator)
  (sign_operator)
  (infix_operator)
  (hash_operator)
  (indexing_operator)
  (let_operator)
  (and_operator)
  (match_operator)
] @operator

(infix_operator ["&" "+" "-" "=" ">" "|" "%"] @operator)
(signed_number ["+" "-"] @operator)

["*" "#" "::" "<-"] @operator

; Keywords
;---------

[
  "and" "as" "assert" "begin" "class" "constraint" "do" "done" "downto" "else"
  "end" "exception" "external" "for" "fun" "function" "functor" "if" "in"
  "include" "inherit" "initializer" "lazy" "let" "match" "method" "module"
  "mutable" "new" "nonrec" "object" "of" "open" "private" "rec" "sig" "struct"
  "then" "to" "try" "type" "val" "virtual" "when" "while" "with"
] @keyword

; Punctuation
;------------

(attribute ["[@" "]"] @punctuation.special)
(item_attribute ["[@@" "]"] @punctuation.special)
(floating_attribute ["[@@@" "]"] @punctuation.special)
(extension ["[%" "]"] @punctuation.special)
(item_extension ["[%%" "]"] @punctuation.special)
(quoted_extension ["{%" "}"] @punctuation.special)
(quoted_item_extension ["{%%" "}"] @punctuation.special)

"%" @punctuation.special

["(" ")" "[" "]" "{" "}" "[|" "|]" "[<" "[>"] @punctuation.bracket

(object_type ["<" ">"] @punctuation.bracket)

[
  "," "." ";" ":" "|" "~" "?" "!" "&" ";;" ":>"  ".."
] @punctuation.delimiter

[
  "=" "+" "-" ">" "+=" ":=" "->"
] @operator

; Attributes
;-----------

(attribute_id) @attribute

; Comments
;---------

[(comment) (line_number_directive) (directive) (shebang)] @comment
