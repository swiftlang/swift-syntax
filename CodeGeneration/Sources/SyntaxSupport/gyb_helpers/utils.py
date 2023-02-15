from gyb_syntax_support import dedented_lines

def make_swift_node(node):
  """
  Given a Python `Node` from `gyb_syntax_support`, return the source code for matching node definition in Swift.
  """
  spaces = 9
  parameters = ['name: "%s"' % node.syntax_kind]
  if node.name_for_diagnostics:
    parameters += [f'nameForDiagnostics: "{node.name_for_diagnostics}"']
  else:
    parameters += ['nameForDiagnostics: nil']

  if node.description:
    parameters += ['description: "%s"' % flat_documentation(node.description)]

  parameters += ['kind: "%s"' % node.kind]

  if node.traits:
    mapped_traits = map(lambda x: (' ' * spaces) + '"%s"' % x, node.traits)
    parameters += ['traits: [\n%s\n' % ',\n'.join(mapped_traits) + (' ' * (spaces - 2)) + ']']

  if node.parser_function:
    parameters += ['parserFunction: "%s"' % node.parser_function]

  if node.non_unexpected_children:
    children = []
    for child in node.non_unexpected_children:
      children += [make_swift_child(child, spaces)]
    parameters += ['children: [\n%s\n' % ',\n'.join(children) + (' ' * (spaces - 2)) + ']']

  if node.collection_element != '':
    parameters += ['element: "%s"' % node.collection_element]

  if node.element_name:
    parameters += ['elementName: "%s"' % node.element_name]

  if node.collection_element_choices :
    mapped_collection_element_choices = map(lambda x: '"%s"' % x, node.collection_element_choices)
    parameters += ['elementChoices: [%s]' % ', '.join(mapped_collection_element_choices)]

  if node.omit_when_empty:
    parameters += ['omitWhenEmpty: true']

  if node.elements_separated_by_newline:
    parameters += ['elementsSeparatedByNewline: true']

  return 'Node(%s)' % ',\n       '.join(parameters)


def make_swift_child(child, spaces):
  """
  Given a Python `Child` from `gyb_syntax_support`, return the source code for matching child definition in Swift.
  """
  parameter_spaces = 8
  parameters = ['name: "%s"' % child.name]

  if child.token_choices:
    mapped_choices = [f'.token(tokenKind: "{choice.name}Token")' for (choice, text) in child.token_choices if text is None]
    mapped_choices += [f'.keyword(text: "{text}")' for (choice, text) in child.token_choices if text is not None]
    joined_choices = ', '.join(mapped_choices)
    token_arguments = [f'choices: [{joined_choices}]']
    if child.requires_leading_space is not None:
      token_arguments += ['requiresLeadingSpace: ' + ('true' if child.requires_leading_space else 'false')]
    if child.requires_trailing_space is not None:
      token_arguments += ['requiresTrailingSpace: ' + ('true' if child.requires_trailing_space else 'false')]
    arguments = ', '.join(token_arguments)
    kind = f'.token({arguments})'
  elif child.collection_element_name:
    kind = f'.collection(kind: "{child.syntax_kind}", collectionElementName: "{child.collection_element_name}")'
  elif child.node_choices:
    mapped_node_choices = [make_swift_child(x, 17) for x in child.node_choices]
    kind = f'.nodeChoices(choices: [\n%s\n' % (',\n').join(mapped_node_choices) + (' ' * (spaces + parameter_spaces - 2)) + '])'
  else:
    kind = f'.node(kind: "{child.syntax_kind}")'

  parameters += ['kind: %s' % kind]

  if child.name_for_diagnostics:
    parameters += [f'nameForDiagnostics: "{child.name_for_diagnostics}"']

  if child.description:
    parameters += ['description: "%s"' % flat_documentation(child.description)]

  if child.is_optional:
    parameters += ['isOptional: true']

  if child.classification:
    parameters += ['classification: "%s"' % child.classification.name]

  if child.force_classification:
    parameters += ['forceClassification: true']

  if child.is_indented:
    parameters += ['isIndented: true']

  if child.requires_leading_newline:
    parameters += ['requiresLeadingNewline: true']

  parameter_spacing = ' ' * (spaces + 6)
  return (' ' * spaces) + 'Child(%s)' % (',\n%s' % parameter_spacing).join(parameters)


def flat_documentation(indented_documentation):
  """
  Creates a single-line documentation string from indented documentation as written in 'gyb_syntax_support'
  """
  return " ".join(dedented_lines(indented_documentation)).replace("\n", "").replace('"','\\"').strip()

