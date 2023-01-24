from .Utils import error
from .kinds import lowercase_first_word  # noqa: I201


class Trivia(object):
    def __init__(self, name, comment, characters=[],
                 swift_characters=[], is_new_line=False, is_comment=False):
        self.name = name
        self.comment = comment
        self.characters = tuple(characters)
        self.lower_name = lowercase_first_word(name)
        if name == "Backslash":
            self.plural_name = "backslashes"
        else:
            self.plural_name = f"{lowercase_first_word(name)}s"
        self.is_new_line = is_new_line
        self.is_comment = is_comment

        # Swift sometimes doesn't support escaped characters like \f or \v;
        # we should allow specifying alternatives explicitly.
        if swift_characters:
            self.swift_characters = tuple(swift_characters)
        else:
            self.swift_characters = characters
        assert len(self.swift_characters) == len(self.characters)

    def characters_len(self):
        return len(self.characters)

    def is_collection(self):
        return self.characters_len() > 0


TRIVIAS = [
    Trivia('Space', 'A space \' \' character.', characters=[' ']),
    Trivia('Tab', 'A tab \'\\t\' character.', characters=['\\t']),
    # Swift don't support vertical tab '\v' so we use the raw unicode
    Trivia('VerticalTab', 'A vertical tab \'\\v\' character.',
           characters=['\\u{b}'], swift_characters=['\\u{2B7F}']),
    # Swift don't support form feed '\f' so we use the raw unicode
    Trivia('Formfeed', 'A form-feed \'f\' character.', characters=['\\u{c}'],
           swift_characters=['\\u{240C}']),
    Trivia('Newline', 'A newline \'\\n\' character.', characters=['\\n'],
           is_new_line=True),
    Trivia('CarriageReturn', 'A newline \'\\r\' character.',
           characters=['\\r'], is_new_line=True),
    Trivia('CarriageReturnLineFeed',
           'A newline consists of contiguous \'\\r\' and \'\\n\' characters.',
           characters=['\\r', '\\n'], is_new_line=True),
    Trivia('LineComment', 'A developer line comment, starting with \'//\'',
           is_comment=True),
    Trivia('BlockComment',
           'A developer block comment, starting with \'/*\' and ending with'
           ' \'*/\'.',
           is_comment=True),
    Trivia('DocLineComment',
           'A documentation line comment, starting with \'///\'.',
           is_comment=True),
    Trivia('DocBlockComment',
           'A documentation block comment, starting with \'/**\' and ending '
           'with \'*/\'.',
           is_comment=True),
    Trivia('Backslash', 'A backslash that is at the end of a line in a multi-line string literal to escape the newline.', characters=['\\\\']),
    Trivia('Pound', 'A \'#\' that is at the end of a line in a multi-line string literal to escape the newline.', characters=['#']),
    Trivia('UnexpectedText', 'Any skipped unexpected text.'),
    Trivia('Shebang', 'A script command, starting with \'#!\'.'),
]
