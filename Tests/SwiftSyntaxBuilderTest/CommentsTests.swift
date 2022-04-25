import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class CommentsTests: XCTestCase {

  func testLineComment() {
    // Given
    let source = SourceFile {
      ImportDecl(path: "Foundation")
      ImportDecl(path: "UIKit")
              .lineComment("Important line comment")
      ClassDecl(classOrActorKeyword: .class, identifier: "SomeViewController", membersBuilder: {
        VariableDecl(.let, name: "tableView", type: "UITableView")
      })
      .lineComment("SomeViewController is used for tableView.")
    }
    // When
    let syntax = source.buildSyntax(format: Format())
    var text = ""
    syntax.write(to: &text)
    
    // Then
    XCTAssertEqual(text, """
      
      import Foundation
      // Important line comment
      import UIKit
      // SomeViewController is used for tableView
      class SomeViewController{
          let tableView: UITableView
      }
      """)
  }
  
  func testDocLineComment() {
    // Given
    let source = SourceFile {
      ImportDecl(path: "SceneKit")
      ClassDecl(classOrActorKeyword: .class, identifier: "PlaneNode", membersBuilder: {
        VariableDecl(.var, name: "planeGeometry", type: "SCNGeometry")
      })
      .docLineComment("Plane node used to represent in a scene.")
    }
    // When
    let syntax = source.buildSyntax(format: Format())
    var text = ""
    syntax.write(to: &text)
    print(text)
    
    // Then
    XCTAssertEqual(text, """
      
      import SceneKit
      /// Plane node used to represent in a scene
      class PlaneNode{
          var planeGeometry: SCNGeometry
      }
      """)
  }
  
  func testBlockComment() {
    // Given
    let source = SourceFile {
      ImportDecl(path: "SceneKit")
      ClassDecl(classOrActorKeyword: .class, identifier: "PlaneNode", membersBuilder: {
        VariableDecl(.var, name: "planeGeometry", type: "SCNGeometry")
      })
      .blockComment("Plane node used to represent in a scene.")
    }
    // When
    let syntax = source.buildSyntax(format: Format())
    var text = ""
    syntax.write(to: &text)
    print(text)
    
    // Then
    XCTAssertEqual(text, """
      
      import SceneKit
      /* Plane node used to represent in a scene. */
      class PlaneNode{
          var planeGeometry: SCNGeometry
      }
      """)
  }
  
  func testDocBlockComment() {
    // Given
    let source = SourceFile {
      ImportDecl(path: "SceneKit")
      ClassDecl(classOrActorKeyword: .class, identifier: "PlaneNode", membersBuilder: {
        VariableDecl(.var, name: "planeGeometry", type: "SCNGeometry")
      })
      .docBlockComment("Plane node used to represent in a scene.")
    }
    // When
    let syntax = source.buildSyntax(format: Format())
    var text = ""
    syntax.write(to: &text)
    print(text)
    
    // Then
    XCTAssertEqual(text, """
      
      import SceneKit
      /** Plane node used to represent in a scene. */
      class PlaneNode{
          var planeGeometry: SCNGeometry
      }
      """)
  }
  
  func testMultipleLineComments() {
    // Given
    let source = SourceFile {
      ImportDecl(path: "SceneKit")
      ClassDecl(classOrActorKeyword: .class, identifier: "PlaneNode", membersBuilder: {
        VariableDecl(.var, name: "planeGeometry", type: "SCNGeometry")
      })
      .lineComment("""
    Plane node used to represent in a scene.
    Each scene is supposed to have only one plane.
    """
      )
    }
    // When
    let syntax = source.buildSyntax(format: Format())
    var text = ""
    syntax.write(to: &text)
    print(text)
    
    // Then
    XCTAssertEqual(text, """
      
      import SceneKit
      // Plane node used to represent in a scene.
      // Each scene is supposed to have only one plane.
      class PlaneNode{
          var planeGeometry: SCNGeometry
      }
      """)
  }
  
  func testFirstNodeComment() {
    // Given
    let source = SourceFile {
      ImportDecl(path: "SceneKit")
        .lineComment("Create 3D games and add 3D content to apps using high-level scene descriptions.")
    }
    // When
    let syntax = source.buildSyntax(format: Format())
    var text = ""
    syntax.write(to: &text)
    print(text)
    // Then
    XCTAssertEqual(text, """
      
      // Create 3D games and add 3D content to apps using high-level scene descriptions.
      import SceneKit
      """)
  }
  
  func testSourceFileComments() {
    // Given
    let source = SourceFile {
      ImportDecl(path: "SceneKit")
    }.lineComment("""
    This source file is part of the Swift.org open source project
    Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
    """)
    // When
    let syntax = source.buildSyntax(format: Format())
    var text = ""
    syntax.write(to: &text)
    // Then
    XCTAssertEqual(text, """
      // This source file is part of the Swift.org open source project
      // Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors

      import SceneKit
      """)
  }
  
  func testSourceFileCommentsWhenFirstNodeHasComment() {
    // Given
    let source = SourceFile {
      ImportDecl(path: "SceneKit")
        .lineComment("Create 3D games and add 3D content to apps using high-level scene descriptions.")
    }.lineComment("""
    This source file is part of the Swift.org open source project.
    """)
    // When
    let syntax = source.buildSyntax(format: Format())
    var text = ""
    syntax.write(to: &text)
    // Then
    XCTAssertEqual(text, """
      // This source file is part of the Swift.org open source project.
      
      // Create 3D games and add 3D content to apps using high-level scene descriptions.
      import SceneKit
      """)
  }
  
  func testNestedCommentsIndentation() {
    // Given
    let source = SourceFile {
      ImportDecl(path: "SceneKit")
      ClassDecl(classOrActorKeyword: .class, identifier: "PlaneNode", membersBuilder: {
        VariableDecl(.var, name: "planeGeometry", type: "SCNGeometry")
          .lineComment("Geometry of plane, could be modified.")
      })
    }
    // When
    let syntax = source.buildSyntax(format: Format())
    var text = ""
    syntax.write(to: &text)
    
    // Then
    XCTAssertEqual(text, """
      
      import SceneKit
      class PlaneNode{
          // Geometry of plane, could be modified.
          var planeGeometry: SCNGeometry
      }
      """)
  }
}
