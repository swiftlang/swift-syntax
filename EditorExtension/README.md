# SwiftRefactor Source Editor Extension

This directory contains an Xcode project that can be used for rapidly iterating
on refactorings built with the SwiftRefactor library.

## Project Structure

The attached project contains two build schemes:

- A host application
- A [Source Editor Extension](https://developer.apple.com/documentation/xcodekit/creating_a_source_editor_extension)

The Source Editor Extension is the only target of interest - the host
application is vestigial and merely exists to provide a container application we
can host the editor extension in.

## Adding Refactoring Actions

This extension automatically discovers refactoring actions present in the
[SwiftRefactor](../Sources/SwiftRefactor) library in the SwiftSyntax package. To add a new refactoring
action, add the corresponding conformance to `RefactoringProvider` and ensure
that it is `public`. Rebuilding and relaunching the extension will pick up your
changes and make them available in Xcode.

## Testing Refactoring Actions in Xcode

Because of code signature requirements, there is some one-time bookkeeping 
to perform before Xcode will accept the plugin:

### Code Signing

- Open SwiftRefactorExtension.xcodeproj in Xcode 14+
- Select the SwiftRefactorExtension project in the project navigator
- Select the 'Host' Target
- Navigate to the 'Signing & Capabilities' tab
- Change the 'Team' field to your development team
- Change the 'Signing Certificate' field to an appropriate Development certificate
- Select the 'SwiftRefactorExtension' Target
- Navigate to the 'Signing & Capabilities' tab
- Change the 'Team' field to your development team
- Change the 'Signing Certificate' field to an appropriate Development certificate

### Running The Editor Extension

- Select the 'SwiftRefactorExtension' scheme
- Select 'My Mac' as the run destination
- Select Product > Run
- When prompted, select 'Xcode' as the app to run
- Click 'Run'

### Executing the Refactoring Action

By now, there should be two copies of Xcode running: The Xcode you used to open 
this project, and a new Xcode that has a gray dock icon. This gray Xcode is
called the "inferior". The inferior is where the plugin runs both for security
and debuggability. It is a full copy of Xcode, so you can open projects,
edit and run code, and use all of the IDE's normal functionalities.

To run the refactoring actions provided by SwiftRefactorExtension, open
a project or package and select a Swift file in the file navigator. Select
the `Editor` menu. At the very bottom of this menu, an entry called "Swift
Refactoring" should now be visible. Each refactoring action is listed as a
sub-menu, so mousing over it will reveal all of the actions that the editor
extension detected at start up.

Selecting a refactoring action will run it over the entire file. The plugin
executes the corresponding `RefactoringProvider` and, whenever it receives a
non-`nil` response, it performs a structured edit of the syntax of the code.

## Troubleshooting

Here are some common issues you might encounter when using this project

### The Code Doesn't Build

You may be using a version of Xcode that is too old and does not contain Swift
5.7 tools. Please ensure that you have the latest available tools from
the Apple developer portal or Mac App Store.

### I Don't See 'Swift Refactoring' in the Editor Menu

This is usually caused by a code signing issue. Please ensure that you are
signing *both* the Host application and the SwiftRefactorExtension products
with a valid development team and are using a Development signing certificate.
Xcode will refuse to load any improperly signed plugins.

### I Don't See My Refactoring in the 'Swift Refactoring' Menu

SwiftRefactoring relies on type metadata in the SwiftRefactor library to
automatically ingest refactoring actions. To ensure that this metadata is
available, make sure that any instances of `RefactoringProvider ` are declared
`public`. Then rebuild the extension and relaunch the inferior Xcode.

### I Still Don't See My Refactoring in the 'Swift Refactoring' Menu

There is a known limitation of the automatic refactoring action discovery
mechanism where it will not detect refactorings with `Context`s that are
not Void. This is because the plugin has no way of knowing how to build custom
`Context` instances. We hope to lift this restriction soon.

## Requirements

This project uses modern Swift features included with the Swift 5.7 release. As
such, Xcode 14 is required to build this project. Additionally, source editor
extensions are required to be code signed and associated with a development
team. This extension *will not* be run if it is ad-hoc signed.

