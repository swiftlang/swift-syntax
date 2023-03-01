import hashlib
import textwrap
from . import Classification  # noqa: I201
from . import Token
from .AttributeNodes import ATTRIBUTE_NODES  # noqa: I201
from .AvailabilityNodes import AVAILABILITY_NODES  # noqa: I201
from .CommonNodes import COMMON_NODES  # noqa: I201
from .DeclNodes import DECL_NODES  # noqa: I201
from .ExprNodes import EXPR_NODES  # noqa: I201
from .GenericNodes import GENERIC_NODES  # noqa: I201
from .PatternNodes import PATTERN_NODES  # noqa: I201
from .StmtNodes import STMT_NODES  # noqa: I201
from .Trivia import TRIVIAS  # noqa: I201
from .TypeNodes import TYPE_NODES  # noqa: I201
from .kinds import SYNTAX_BASE_KINDS  # noqa: I201


# Re-export global constants
SYNTAX_NODES = COMMON_NODES + EXPR_NODES + DECL_NODES + ATTRIBUTE_NODES + \
    STMT_NODES + GENERIC_NODES + TYPE_NODES + PATTERN_NODES + \
    AVAILABILITY_NODES
NON_BASE_SYNTAX_NODES = [node for node in SYNTAX_NODES if not node.is_base()]
SYNTAX_TOKENS = Token.SYNTAX_TOKENS
SYNTAX_TOKEN_MAP = Token.SYNTAX_TOKEN_MAP
SYNTAX_CLASSIFICATIONS = Classification.SYNTAX_CLASSIFICATIONS


def make_missing_child(child):
    """
    Generates a C++ call to make the raw syntax for a given Child object.
    """
    if child.is_token():
        token = child.main_token()
        tok_kind = token.kind if token else "unknown"
        tok_text = token.text if token else ""
        return \
            'RawSyntax::missing(tok::%s, "%s", Arena)' % \
            (tok_kind, tok_text)
    else:
        missing_kind = "Unknown" if child.syntax_kind == "Syntax" \
                       else child.syntax_kind
        if child.node_choices:
            return make_missing_child(child.node_choices[0])
        return 'RawSyntax::missing(SyntaxKind::%s, Arena)' % missing_kind


def make_missing_swift_child(child):
    """
    Generates a Swift call to make the raw syntax for a given Child object.
    """
    if child.is_token():
        token = child.main_token()
        tok_kind = token.swift_kind() if token else "unknown"
        if token and token.associated_value_class:
            if len(child.token_choices) >= 1 and child.token_choices[0][1] is not None:
                text_choice = child.token_choices[0][1]
            else:
                assert False, f"Can only create missing child if text is known (while creating {child.name} of type {child.syntax_kind})"
            
            if text_choice == "init":
                text_choice = "`init`"
            tok_kind += f'(.{text_choice})'
        elif not token or not token.text:
            tok_kind += '("")'
        return f'RawSyntax.makeMissingToken(kind: TokenKind.{tok_kind}, ' + \
            'arena: arena)'
    else:
        if child.syntax_kind == "Syntax":
            missing_kind = "missing"
        elif child.syntax_kind in SYNTAX_BASE_KINDS:
            missing_kind = f"missing{child.syntax_kind}"
        else:
            missing_kind = child.swift_syntax_kind
        return f'RawSyntax.makeEmptyLayout(kind: SyntaxKind.{missing_kind}, ' + \
            'arena: arena)'


def create_node_map():
    """
    Creates a lookup table to find nodes by their kind.
    """
    return {node.syntax_kind: node for node in SYNTAX_NODES}


def is_visitable(node):
    return not node.is_base()


def dedented_lines(description):
    """
    Each line of the provided string with leading whitespace stripped.
    """
    if not description:
        return []
    return textwrap.dedent(description).split('\n')


def calculate_node_hash():
    digest = hashlib.sha1()

    def _digest_syntax_node(node):
        # Hash into the syntax name
        digest.update(node.name.encode("utf-8"))
        for child in node.children:
            # Hash into the expected child syntax
            digest.update(child.syntax_kind.encode("utf-8"))
            # Hash into the child name
            digest.update(child.name.encode("utf-8"))
            # Hash into whether the child is optional
            digest.update(str(child.is_optional).encode("utf-8"))

    def _digest_syntax_token(token):
        # Hash into the token name
        digest.update(token.name.encode("utf-8"))

    def _digest_trivia(trivia):
        digest.update(trivia.name.encode("utf-8"))
        digest.update(str(trivia.characters).encode("utf-8"))

    for node in SYNTAX_NODES:
        _digest_syntax_node(node)
    for token in SYNTAX_TOKENS:
        _digest_syntax_token(token)
    for trivia in TRIVIAS:
        _digest_trivia(trivia)

    return digest.hexdigest()
