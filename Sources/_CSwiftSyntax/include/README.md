This 'include' directory only exists to make swiftpm generate a module map and
avoid "'module.modulemap' not found" compiler errors.

Don't put headers here to import via the `_CSwiftSyntax` module. Swift does not
support private module imports, meaning when distributing the SwiftSyntax.module
we would also have to bundle these private headers as well.

We want to preserve the property that SwiftSyntax is a self-contained Swift module.
To that end, the functions defined in this target are loaded dynamically via dlsym loading.

