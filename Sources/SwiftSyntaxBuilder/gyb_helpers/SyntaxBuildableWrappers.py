from gyb_syntax_support import SYNTAX_TOKEN_MAP, create_node_map, SYNTAX_NODES
from gyb_syntax_support.kinds import SYNTAX_BASE_KINDS
from gyb_syntax_support.kinds import lowercase_first_word
from .BuilderInitializableTypes import BUILDER_INITIALIZABLE_TYPES
from .ExpressibleAsConformances import SYNTAX_BUILDABLE_EXPRESSIBLE_AS_CONFORMANCES
from .utils import flat_documentation

class SyntaxBuildableChild:
  """
  Wrapper around the `Child` type defined in `gyb_syntax_support` to provide functionality specific to SwiftSyntaxBuilder.
  """
  def __init__(self, child_node):
    self.child = child_node

  def name(self):
    """
    The lowercase name of the child. Can be used for variable names.
    """
    return self.child.swift_name


  def type(self):
    """
    The type of this child, represented by a `SyntaxBuildableType`, which can be used to create the corresponding `Buildable` and `ExpressibleAs` types.
    """
    return SyntaxBuildableType(self.child.syntax_kind, self.child.is_optional)

  def generate_expr_build_syntax_node(self, var_name, format_name):
    """
    Generate a Swift expression that creates a proper SwiftSyntax node of type `self.type().syntax()` from a variable named `var_name` of type `self.type().buildable()` that represents this child node.
    """
    if self.type().is_token():
       if self.child.requires_leading_newline:
         return var_name + '.withLeadingTrivia(.newline + ' + format_name + '._indentTrivia + (' + var_name + '.leadingTrivia ?? []))'
       else:
         return var_name
    else:
      format = format_name
      if self.child.is_indented:
        format += '._indented'

      expr = var_name
      if self.type().is_optional:
        expr = expr + '?'
      return expr + '.build' + self.type().base_name() + '(format: ' + format + ', leadingTrivia: nil)'

  def generate_assert_stmt_text_choices(self, var_name):
    """
    If this node is a token that can't contain arbitrary text, generate a Swift `assert` statement that verifies the variable with name var_name and of type `TokenSyntax` contains one of the supported text options.
    Otherwise return `None`.
    """
    if not self.type().is_token():
      return None

    if self.child.text_choices:
      text_choices = self.child.text_choices
    elif self.child.token_choices:
      text_choices = [SYNTAX_TOKEN_MAP.get(token_choice.name + 'Token').text for token_choice in self.child.token_choices]
    else:
      return None

    if None in text_choices:
      # If None is in the text choices, one of the token options can contain arbitrary text.
      # Don't generate an assert statement.
      return None

    assert_choices = []
    if self.type().is_optional:
      assert_choices.append('%s == nil' % var_name)
    unwrap = '!' if self.type().is_optional else ''
    for text_choice in text_choices:
      assert_choices.append('%s%s.text == "%s"' % (var_name, unwrap, text_choice))
    return 'assert(%s)' % ' || '.join(assert_choices)

  def documentation(self):
    """
    If the child node has documentation associated with it, return it as a single-line string. Otherwise return an empty string.
    """
    return flat_documentation(self.child.description)

class SyntaxBuildableNode:
  """
  Wrapper around the `Node` type defined in `gyb_syntax_support` to provide functionality specific to SwiftSyntaxBuilder.
  """
  def __init__(self, node):
    """
    Create a SyntaxBuildableNode, either from
     - a `Node` type defined in `gyb_syntax_support` or
     - a `SwiftBuildableType`, assuming that that type doesn't represent one of the base kinds
    """
    if isinstance(node, SyntaxBuildableType):
      assert node.base_name() not in SYNTAX_BASE_KINDS, "Syntax base kinds are not represented by Nodes"
      self.node = create_node_map()[node.base_name()]
    else:
      self.node = node

  def children(self):
    """
    Returns the children of this node as `SyntaxBuildableChild`ren.
    """
    return [SyntaxBuildableChild(child) for child in self.node.children]

  def documentation(self):
    """
    If documentation exists for this node, return it as a single-line string.
    Otherwise return an empty string.
    """
    if not self.node.description and self.node.is_syntax_collection():
      # Automatically generate documentation for syntax collections.
      return '`%s` represents a collection of `%s`s.' % (self.node.syntax_kind, self.collection_element_type().buildable())
    return flat_documentation(self.node.description)

  def type(self):
    return SyntaxBuildableType(self.node.syntax_kind)

  def base_type(self):
    """
    Returns the base type of this node, e.g. the `Expr` type for `IdentiferExpr`.
    """
    return SyntaxBuildableType(self.node.base_kind)

  def collection_element_type(self):
    """
    Assuming that this node is a syntax collection, return the type of its elements.
    """
    assert self.node.is_syntax_collection()
    return SyntaxBuildableType(self.node.collection_element)

  def elements_separated_by_newline(self):
    """
    Assuming that this node is a syntax colleciton, return whether the elements should be separated by newlines when the syntax tree is printed.
    """
    assert self.node.is_syntax_collection()
    return self.node.elements_separated_by_newline

  def single_non_defaulted_child(self):
    """
    Assuming that this node has a single child without a default value, return that child.
    """
    non_defaulted_params = [child for child in self.children() if not child.type().default_initialization()]
    assert len(non_defaulted_params) == 1
    return non_defaulted_params[0]

class SyntaxBuildableType:
  """
  Wrapper around the syntax_kind strings in `gyb_syntax_support` to provide functionality specific to SwiftSyntaxBuilder.
  In particular, this includes the functionality to create the `*Buildable`, `ExpressibleAs*` and `*Syntax` Swift types from the syntax kind.
  """
  def __init__(self, syntax_kind, is_optional = False):
    self.is_optional = is_optional
    if syntax_kind.endswith('Token'):
      # There are different token kinds but all of them are represented by `Token` in the Swift source (see `kind_to_type` in `gyb_syntax_support`).
      self.syntax_kind = 'Token'
      self.token_kind = syntax_kind
    else:
      self.syntax_kind = syntax_kind
      self.token_kind = None

  def __eq__(self, other):
    return self.syntax_kind == other.syntax_kind and \
           self.is_optional == other.is_optional and \
           self.token_kind == other.token_kind
  
  def __hash__(self):
    return hash((self.syntax_kind, self.is_optional, self.token_kind))

  def _optional_question_mark(self):
    if self.is_optional:
      return '?'
    else:
      return ''

  def non_optional(self):
    """
    Returns this type with `is_optional` set to `False`.
    """
    if self.is_token():
      return SyntaxBuildableType(self.token_kind)
    else:
      return SyntaxBuildableType(self.syntax_kind)

  def is_token(self):
    return self.syntax_kind == 'Token'

  def token(self):
    return SYNTAX_TOKEN_MAP.get(self.token_kind)

  def default_initialization(self):
    """
    If the type has a default value (because it is optional or because it is a token with a fixed text), return an expression of the form ` = default_value` that can be used as the default value to for a function parameter.
    Otherwise, return an empty string.
    """
    if self.is_optional:
      return ' = nil'
    elif self.is_token():
      token = self.token()
      if token and token.text:
        return ' = TokenSyntax.`%s`' % lowercase_first_word(token.name)
      elif self.token_kind == 'EOFToken':
        return ' = TokenSyntax.eof'
      else:
        return ''
    else:
      return ''

  def is_syntax_collection(self):
    if self.syntax_kind == 'SyntaxCollection':
      return True
    if self.base_type():
      return self.base_type().is_syntax_collection()
    else:
      return False

  def base_name(self):
    """
    Returns the raw base name of this kind.
    Used for the `build*` methods defined in the buildable types.
    """
    return self.syntax_kind

  def buildable(self):
    """
    Return the name of the `Buildable` type that is the main entry point for building SwiftSyntax trees using `SwiftSyntaxBuilder`.
    These names look as follows:
     - For nodes: The node name, e.g. `IdentifierExpr` (these are implemented as structs)
     - For base kinds: `<BaseKind>Buildable`, e.g. `ExprBuildable` (these are implemented as protocols)
    If the type is optional, this terminates with a '?'.
    """
    if self.syntax_kind in SYNTAX_BASE_KINDS:
      return self.syntax_kind + 'Buildable' + self._optional_question_mark()
    else:
      return self.syntax_kind + self._optional_question_mark()

  def is_builder_initializable(self):
    """
    Returns whether parameters of this type should be initializable by
    a result builder. Used for certain syntax collections and block-like
    structures (e.g. CodeBlock, MemberDeclList).
    """
    return self.non_optional().buildable() in BUILDER_INITIALIZABLE_TYPES

  def builder_initializable_type(self):
    """
    Returns a type suitable for initializing this type though a builder
    (e.g. returns CodeBlockItemList for CodeBlock) and otherwise itself.
    """
    buildable = self.non_optional().buildable()
    return SyntaxBuildableType(BUILDER_INITIALIZABLE_TYPES.get(buildable, None) or buildable, is_optional=self.is_optional)

  def buildable_base_name(self):
    """
    Returns the type from `buildable()` without any question marks attached.
    This is used for the `create*` methods defined in the `ExpressibleAs*` protocols.
    """
    return self.non_optional().buildable()

  def expressible_as(self):
    """
    Return the `ExpressibleAs*` Swift type for this syntax kind.
    Tokens don't have an `ExpressibleAs*` type, so for those this method just returns `TokenSyntax`.
    If the type is optional, this terminates with a '?'.
    """
    if self.is_token():
      # Tokens don't have a dedicated ExpressibleAs type.
      return self.buildable()
    else:
      return 'ExpressibleAs' + self.buildable()

  def syntax(self):
    """
    Returns the corresponding `*Syntax` type defined in the `SwiftSyntax` module, which will eventually get built from `SwiftSyntaxBuilder`.
    If the type is optional, this terminates with a '?'.
    """
    if self.syntax_kind == 'Syntax':
      return 'Syntax' + self._optional_question_mark()
    else:
      return self.syntax_kind + 'Syntax' + self._optional_question_mark()

  def list_buildable(self):
    """
    Assuming that this is a base kind, return the corresponding `*ListBuildable` type.
    """
    assert self.syntax_kind in SYNTAX_BASE_KINDS, "ListBuildable types only exist for syntax base kinds"
    return self.syntax_kind + 'ListBuildable' + self._optional_question_mark()

  def result_builder(self):
    """
    Assuming that this is a collection type, the type of the result builder that can be used to build the collection.
    """
    return self.syntax_kind + 'Builder' + self._optional_question_mark()

  def element_in_collections(self):
    """
    Return the collection types in which this type occurs as an element.
    We automatically make the `ExpressibleAs*` protocols conform to the `ExpressibleAs*` protocol of the collection they occur in.
    """
    result = []
    for node in [SyntaxBuildableNode(node) for node in SYNTAX_NODES if node.is_syntax_collection()]:
      if node.collection_element_type() == self:
        result.append(node.type())
    return result

  def has_with_trailing_comma_trait(self):
    """
    Returns if this type has `WithTrailingComma` trait
    """
    for node in [SyntaxBuildableNode(node) for node in SYNTAX_NODES]:
      if node.type() == self:
        return node.node.traits and 'WithTrailingComma' in node.node.traits
    return False

  def convertible_to_types(self):
    """
    Types that take a single non-optional parameter of this types and to which this type is thus convertible.
    We automatically make the `ExpressibleAs*` of this type conform to the `ExpressibleAs*` protocol of the convertible types.
    """
    expressible_as = SYNTAX_BUILDABLE_EXPRESSIBLE_AS_CONFORMANCES.get(self.buildable(), [])
    return [SyntaxBuildableType(type) for type in expressible_as]

  def base_type(self):
    """
    If this type is not a base kind, return its base type (see `SyntaxBuildableNode.base_type()`), otherwise return `None`.
    """
    if self.syntax_kind not in SYNTAX_BASE_KINDS and not self.is_token():
      return SyntaxBuildableNode(self).base_type()
    else:
      return None

  def generated_expressible_as_conformances(self):
    """
    The types to which this `ExpressibleAs*` type conforms to via automatically generated conformances.
    """
    conformances = self.element_in_collections() + self.convertible_to_types()
    if self.base_type() and self.base_type().base_name() != 'SyntaxCollection':
      conformances.append(self.base_type())
    return conformances

  def transitive_expressible_as_conformances(self):
    """
    The types to which this `ExpressibleAs*` type conforms to via automatically generated conformances, including transitive conformances.
    """
    result = []
    for conformance in self.generated_expressible_as_conformances():
      result += [conformance] + conformance.transitive_expressible_as_conformances()
    return result

  def implied_expressible_as_conformances(self):
    """
    The types to which this `ExpressibleAs*` type implicitly conforms to via transitive conformances.
    These conformances don't need to be spelled out explicitly in the source code.
    """
    result = []
    for conformance in self.generated_expressible_as_conformances():
      result += conformance.transitive_expressible_as_conformances()
    return result

  def generate_expr_convert_param_type_to_storage_type(self, var_name):
    """
    Generate an expression that converts a variable named `var_name` which is of `expressible_as()` type to an object of type `buildable()`.
    """
    if self.syntax_kind == 'Token':
      return var_name

    expr = var_name
    if self.is_optional:
      expr += '?'
    expr += '.'
    expr += 'create%s()' % self.buildable_base_name()
    return expr
