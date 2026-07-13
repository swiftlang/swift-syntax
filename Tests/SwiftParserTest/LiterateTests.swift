//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2026 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax
import XCTest

class LiterateTests: ParserTestCase {
  func testLaTeX() {
    assertParse(
      #"""
      \documentstyle{article}
      \usepackage{listings}
      \usepackage{color}

      \lstnewenvironment{swift}{\lstset{language=Swift,basicstyle=\small}}{}

      \title{Literate Swift in \LaTeX}

      \begin{document}

      We can write Swift code in a \LaTeX document using the \texttt{swift}
      environment:

      \begin{swift}
        // CHECK: LATEX
        print("LATEX")
      \end{swift}

      We can calculate $7!$ using the following code:

      \begin{swift}
        // CHECK: 7! = 5040
        var result = 1
        for n in 2...7 {
          result *= n
        }
        print("7! = \(result)")
      \end{swift}

      \end{document}
      """#,
      mode: .laTeX
    )
  }

  func testIndentedRST() {
    assertParse(
      #"""
      Indented Code Blocks
      ====================

      In reStructuredText, code blocks are introduced with a double colon::

        // CHECK: SIMPLE
        print("SIMPLE")

      They run until the indentation level returns to the level of the paragraph that started them.

        So if we start a paragraph here::

          // CHECK: INDENTED
          // CHECK-NOT: AFTER-INDENTED
          print("INDENTED")

        print("AFTER-INDENTED")

      is part of the text.

      We also support them in bulleted lists:

      * One

      * Two::

          // CHECK: BULLET2
          print("BULLET2")

      * Three::

          // CHECK: BULLET3
          print("BULLET3")

      * Four

      * Five::

          // CHECK: BULLET5
          print("BULLET5")

      and in numbered lists:

      1. One

      2. Two::

           // CHECK: NUMBERED2
           print("NUMBERED2")

      3. Three::

           // CHECK: NUMBERED3
           print("NUMBERED3")

      4. Four

      5. Five::

           // CHECK: NUMBERED5
           print("NUMBERED5")

      17. Seventeen::

            // CHECK: NUMBERED17
            print("NUMBERED17")

      #. Automatic::

           // CHECK: NUMBEREDAUTO
           print("NUMBEREDAUTO")

      #. Auto2::

           // CHECK: NUMBEREDAUTO2
           print("NUMBEREDAUTO2")

      Indented code blocks can contain indentation::

        // CHECK: INDENTATION OK. SUM IS 55
        var sum = 0
        for n in 1...10 {
          sum += n
        }
        print("INDENTATION OK. SUM IS \(sum)")

      They can also contain blank lines::

        // CHECK: BLANK NO SPACES

        print("BLANK NO SPACES")

      with or without indentation::

        // CHECK: BLANK SPACES
        
        print("BLANK SPACES")
      """#,
      mode: .reStructuredText
    )
  }

  func testExplicitRST() {
    assertParse(
      #"""
      Explicit Code Blocks
      ====================

      reStructuredText also supports explicit code blocks, using ``code-block`` and
      ``sourcecode`` block markup.

      .. code-block::

         // CHECK: SIMPLE
         print("SIMPLE")

      .. sourcecode::

         // CHECK: SOURCECODE
         print("SOURCECODE")

      These can specify the language used; we only support ``swift``:

      .. code-block:: swift

         // CHECK: SWIFT
         print("SWIFT")

      .. code-block:: pascal

         // CHECK-NOT: PASCAL
         print("PASCAL")

      We also support a ``nocompile`` option for these, with or without the ``swift``
      language type:

      .. code-block::
         :nocompile:

         // CHECK-NOT: NOCOMPILE
         print("NOCOMPILE")

      .. code-block:: swift
         :nocompile:

         // CHECK-NOT: SWIFT-NOCOMPILE
         print("SWIFT-NOCOMPILE")

      As with indented code blocks, they can contain indentation

      .. code-block:: swift

         // CHECK: INDENTATION OK. SUM IS 55
         var sum = 0
         for n in 1...10 {
           sum += n
         }
         print("INDENTATION OK. SUM IS \(sum)")

      as well as blank lines

      .. code-block:: swift

         // CHECK: BLANK NO SPACES

         print("BLANK NO SPACES")

      with or without indentation

      .. code-block:: swift

         // CHECK: BLANK SPACES
         
         print("BLANK SPACES")
      """#,
      mode: .reStructuredText
    )
  }

  func testIndentedMarkdown() {
    assertParse(
      #"""
      Indented Code Block
      ===================

      This should build a program that prints "OK":

          // CHECK: SIMPLE
          print("SIMPLE")

      We also want to make sure that adding more blocks works:

          // CHECK: SECOND
          print("SECOND")

      And that using more than four space works:

           // CHECK: FIVE SPACES
           print("FIVE SPACES")

      Code blocks need a blank line before
          // CHECK-NOT: NEED BLANK
          print("NEED BLANK")

      Indented code blocks can contain indentation

          // CHECK: INDENTATION OK. SUM IS 55
          var sum = 0
          for n in 1...10 {
            sum += n
          }
          print("INDENTATION OK. SUM IS \(sum)")

      Indented code blocks can also contain blank lines

          // CHECK: BLANK NO SPACES

          print("BLANK NO SPACES")

      with or without indentation

          // CHECK: BLANK SPACES
          
          print("BLANK SPACES")
      """#,
      mode: .markdown
    )
  }

  func testFencedMarkdown() {
    assertParse(
      #"""
      Fenced Code Blocks
      ==================

      A simple fenced code block:

      ```
      // CHECK: SIMPLE
      print("SIMPLE")
      ```

      Fenced code blocks can use tildes instead of backticks:

      ~~~
      // CHECK: TILDE
      print("TILDE")
      ~~~

      This is not a valid code block:

      ``` print("NOT VALID") // CHECK-NOT: NOT_VALID ```

      This *is* a valid code block:

      ~~~ swift ```
      // CHECK: BACKTICKS IN INFO
      print("BACKTICKS IN INFO")
      ~~~

      Fenced code blocks do *not* need a blank line before:
      ```
      // CHECK: NO BLANK REQUIRED
      print("NO BLANK REQUIRED")
      ```

      We ignore fenced blocks for other languages:

      ```pascal
      // CHECK-NOT: IGNORED OTHER LANGUAGE
      print("IGNORED OTHER LANGUAGE")
      ```

      We process *swift* blocks

      ```swift
      // CHECK: SWIFT BLOCK
      print("SWIFT BLOCK")
      ```

      unless they use the `nocompile` keyword:

      ```swift nocompile
      // CHECK-NOT: SWIFT NOCOMPILE
      print("SWIFT NOCOMPILE")
      ```
      """#,
      mode: .markdown
    )
  }
}
