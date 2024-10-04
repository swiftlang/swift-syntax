# When to use protocols in SwiftSyntax

Learn when to use protocols value types like ``ExprSyntax`` over protocols like ``ExprSyntaxProtocol``. 


SwiftSyntax tries to minimize the use of existentials (aka. protocols spelled with `any` or protocols spelled without `some`) wherever possible. This is because when the stored value is more than 3 words (a word is the size of a pointer) large, these existentials store their data on the heap. The data stored inside `RawSyntax` is larger than 3 words and thus every time you pass a value around as a e.g. an `ExprSyntaxProtocol`, a new heap allocation will be made and that data needs to be reference-counted, which causes a very noticeable performance overhead. 

swift-syntax offers two alternatives:
- When passing a single node around, use `some ExprSyntaxProtocol`. This allows the concrete expression node (e.g. an ``IntegerLiteralExprSyntax``) to be passed directly without the need to wrap it in an existential and thus avoid the performance overhead.
- When multiple expression nodes need to be represented that might be of different types, eg. in an array of expressions, use the ``ExprSyntax`` type. ``ExprSyntax`` is a struct and can thus be allocated on the stack. The downside is that specific expression nodes need to explicitly be upcast to `ExprSyntax` (`ExprSyntax(integerLiteral)`) and downcast to more specific types using a custom `as` method (`expr.as(IntegerLiteralExprSyntax.self)`).
