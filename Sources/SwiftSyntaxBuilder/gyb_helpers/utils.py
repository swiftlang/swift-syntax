from gyb_syntax_support import dedented_lines

def conformance_clause(conforming_to_protocols):
  """
  If conforming_to_protocols is not empty, creates a conformance clause, e.g. ': Proto1, Proto2'.
  Otherwise returns an empty string.
  """
  if conforming_to_protocols:
    return ": " + ", ".join(conforming_to_protocols)
  else:
    return ""

def flat_documentation(indented_documentation):
  """
  Creates a single-line documentation string from indented documentation as written in 'gyb_syntax_support'
  """
  return "".join(dedented_lines(indented_documentation)).replace("\n", "").strip()

