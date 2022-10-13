/// Describes a macro.
public protocol Macro {
  /// The name of the module in which this macro resides.
  var moduleName: String { get }

  /// The name of this macro.
  var name: String { get }
}
