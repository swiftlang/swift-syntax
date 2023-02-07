# flake8: noqa I201
from .Classification import classification_by_name
from .Token import SYNTAX_TOKEN_MAP
from .kinds import SYNTAX_BASE_KINDS, kind_to_type, lowercase_first_word


class Child(object):
    """
    A child of a node, that may be declared optional or a token with a
    restricted subset of acceptable kinds or texts.
    """
    def __init__(self, name, kind, name_for_diagnostics=None, description=None, is_optional=False,
                 token_choices=None, text_choices=None, node_choices=None,
                 collection_element_name=None,
                 classification=None, force_classification=False,
                 is_indented=False, requires_leading_newline=False,
                 requires_leading_space=None,
                 requires_trailing_space=None):
        """
        If a classification is passed, it specifies the color identifiers in
        that subtree should inherit for syntax coloring. Must be a member of
        SyntaxClassification in SyntaxClassifier.h.gyb
        If force_classification is also set to true, all child nodes (not only
        identifiers) inherit the syntax classification.
        """
        self.name = name
        self.name_for_diagnostics = name_for_diagnostics
        self.swift_name = lowercase_first_word(name)
        self.syntax_kind = kind
        self.description = description
        self.swift_syntax_kind = lowercase_first_word(self.syntax_kind)
        self.type_name = kind_to_type(self.syntax_kind)
        self.collection_element_name = collection_element_name
        self.classification = classification_by_name(classification)
        self.force_classification = force_classification
        self.is_indented = is_indented
        self.requires_leading_newline = requires_leading_newline
        self.requires_leading_space = requires_leading_space
        self.requires_trailing_space = requires_trailing_space

        # If the child ends with "token" in the kind, it's considered
        # a token node. Grab the existing reference to that token from the
        # global list.
        self.token_kind = \
            self.syntax_kind if self.syntax_kind.endswith("Token") else None
        self.token = SYNTAX_TOKEN_MAP.get(self.token_kind)

        self.is_optional = is_optional

        # A restricted set of token kinds that will be accepted for this
        # child.
        self.token_choices = []
        if self.token and not token_choices:
            self.token_choices.append((self.token, None))
        for choice in token_choices or []:
            pipe_index = choice.find('|')
            choice_text = None
            if pipe_index != -1:
                full_choice = choice
                choice = full_choice[:pipe_index]
                choice_text = full_choice[(pipe_index+1):]
            token = SYNTAX_TOKEN_MAP[choice]
            self.token_choices.append((token, choice_text))

        # A list of valid choices for a child
        self.node_choices = node_choices or []

        # Check the choices are either empty or multiple
        assert len(self.node_choices) != 1

        # Check node choices are well-formed
        existing_type_names = set()
        for choice in self.node_choices:
            assert not choice.is_optional, \
                "node choice %s cannot be optional" % choice.name
            assert not choice.node_choices, \
                "node choice %s cannot have further choices" % choice.name

            assert not choice.type_name in existing_type_names, \
                f"{name} cannot have multiple node choices of type {choice.type_name}"
            existing_type_names.add(choice.type_name)

    def is_token(self):
        """
        Returns true if this child has a token kind.
        """
        return self.token_kind is not None

    def has_base_type(self):
        """
        Returns `True` if this child's type is one of the base syntax kinds and
        it has no node choices.
        """
        return not self.node_choices and self.syntax_kind in SYNTAX_BASE_KINDS

    def has_optional_base_type(self):
      """
      Returns `True` if this child's type is one of the base syntax kinds and
      it's optional.
      """
      return self.has_base_type() and self.is_optional

    def main_token(self):
        """
        Returns the first choice from the token_choices if there are any,
        otherwise returns None.
        """
        if self.token_choices:
            return self.token_choices[0][0]
        return None

    def is_unexpected_nodes(self):
        return self.syntax_kind == 'UnexpectedNodes'

    def generate_default_initialization(self):
      """
      If the type has a default value, return an expression of the form
      ` = default_value` that can be used as the default value to for a
      function parameter. Otherwise, return an empty string.
      """

      # Note that this should be Optional<BaseType>.none for defaulted generic,
      # but that doesn't work in Swift 5.6. To keep source compatibility with
      # previous SwiftSyntax, we instead create a second initializer that uses
      # `Missing<Node>` and defaults that to `nil` instead (and `Missing` is
      # used so that they can't be implicitly converted from a literal).
      if self.is_optional or self.is_unexpected_nodes():
        return " = nil"

      if not self.is_token() or not self.token:
        return ""

      if self.token.is_keyword:
        return f" = .{self.token.swift_kind()}()"
      if self.token.text:
        return f" = .{self.token.swift_kind()}Token()"
      text_choice = None
      if self.token_choices and len(self.token_choices) == 1 and self.token_choices[0][1] is not None:
        text_choice = self.token_choices[0][1]
      if text_choice:
        if self.token.associated_value_class:
          if text_choice == "init":
            text_choice = "`init`"
          return f" = .{self.token.swift_kind()}(.{text_choice})"
        else:
          return f" = .{self.token.swift_kind()}(\"{text_choice}\")"

      return ""
