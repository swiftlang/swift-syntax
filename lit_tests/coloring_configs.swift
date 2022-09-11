// RUN: %lit-test-helper -classify-syntax -source-file %s | %FileCheck %s

// CHECK: <kw>var</kw> <id>f</id> : <type>Int</type>
var f : Int

// CHECK: <#kw>#if</#kw> <#id>os</#id>(<#id>macOS</#id>)
#if os(macOS)
#endif

// CHECK: <#kw>#if</#kw> <#id>CONF</#id>
#if CONF
  // CHECK: <kw>var</kw> <id>x</id> : <type>Int</type>
  var x : Int
// CHECK: <#kw>#else</#kw>
#else
  // CHECK: <kw>var</kw> <id>x</id> : <type>Float</type>
  var x : Float
// CHECK: <#kw>#endif</#kw>
#endif

// CHECK: <#kw>#if</#kw> <#id>CONF</#id>
#if CONF
  // CHECK: <kw>var</kw> <id>x2</id> : <type>Int</type>
  var x2 : Int
// CHECK: <#kw>#endif</#kw>
#endif

// CHECK: <#kw>#if</#kw> !<#id>CONF</#id>
#if !CONF
  // CHECK: <kw>var</kw> <id>x3</id> : <type>Int</type>
  var x3 : Int
// CHECK: <#kw>#else</#kw>
#else
  // CHECK: <kw>var</kw> <id>x3</id> : <type>Float</type>
  var x3 : Float
// CHECK: <#kw>#endif</#kw>
#endif

// CHECK: <#kw>#if</#kw> !<#id>CONF</#id>
#if !CONF
  // CHECK: <kw>var</kw> <id>x4</id> : <type>Int</type>
  var x4 : Int
// CHECK: <#kw>#endif</#kw>
#endif

// CHECK: <#kw>#if</#kw> <#id>CONF</#id>
#if CONF
  // CHECK: <kw>var</kw> <id>y1</id> : <type>Int</type>
  var y1 : Int
// CHECK: <#kw>#elseif</#kw> <#id>BAZ</#id>
#elseif BAZ
  // CHECK: <kw>var</kw> <id>y1</id> : <type>String</type>
  var y1 : String
// CHECK: <#kw>#else</#kw>
#else
  // CHECK: <kw>var</kw> <id>y1</id> : <type>Float</type>
  var y1 : Float
// CHECK: <#kw>#endif</#kw>
#endif

// CHECK: <#kw>#if</#kw> !<#id>CONF</#id>
#if !CONF
  // CHECK: <kw>var</kw> <id>y2</id> : <type>Int</type>
  var y2 : Int
// CHECK: <#kw>#elseif</#kw> <#id>BAZ</#id>
#elseif BAZ
  // CHECK: <kw>var</kw> <id>y2</id> : <type>String</type>
  var y2 : String
// CHECK: <#kw>#else</#kw>
#else
  // CHECK: <kw>var</kw> <id>y2</id> : <type>Float</type>
  var y2 : Float
// CHECK: <#kw>#endif</#kw>
#endif

// CHECK: <#kw>#if</#kw> !<#id>CONF</#id>
#if !CONF
  // CHECK: <kw>var</kw> <id>y3</id> : <type>Int</type>
  var y3 : Int
// CHECK: <#kw>#elseif</#kw> <#id>CONF</#id>
#elseif CONF
  // CHECK: <kw>var</kw> <id>y3</id> : <type>String</type>
  var y3 : String
// CHECK: <#kw>#else</#kw>
#else
  // CHECK: <kw>var</kw> <id>y3</id> : <type>Float</type>
  var y3 : Float
// CHECK: <#kw>#endif</#kw>
#endif

// CHECK: <kw>var</kw> <id>l</id> : <type>Int</type>
var l : Int

// CHECK: <kw>class</kw> <id>C1</id> {
class C1 {
  // CHECK: <kw>var</kw> <id>f</id> : <type>Int</type>
  var f : Int

// CHECK: <#kw>#if</#kw> <#id>CONF</#id>
#if CONF
  // CHECK: <kw>var</kw> <id>x</id> : <type>Int</type>
  var x : Int
// CHECK: <#kw>#else</#kw>
#else
  // CHECK: <kw>var</kw> <id>x</id> : <type>Float</type>
  var x : Float
// CHECK: <#kw>#endif</#kw>
#endif

// CHECK: <#kw>#if</#kw> <#id>CONF</#id>
#if CONF
  // CHECK: <kw>var</kw> <id>x2</id> : <type>Int</type>
  var x2 : Int
// CHECK: <#kw>#endif</#kw>
#endif

// CHECK: <#kw>#if</#kw> !<#id>CONF</#id>
#if !CONF
  // CHECK: <kw>var</kw> <id>x3</id> : <type>Int</type>
  var x3 : Int
// CHECK: <#kw>#else</#kw>
#else
  // CHECK: <kw>var</kw> <id>x3</id> : <type>Float</type>
  var x3 : Float
// CHECK: <#kw>#endif</#kw>
#endif

// CHECK: <#kw>#if</#kw> !<#id>CONF</#id>
#if !CONF
  // CHECK: <kw>var</kw> <id>x4</id> : <type>Int</type>
  var x4 : Int
// CHECK: <#kw>#endif</#kw>
#endif

// CHECK: <#kw>#if</#kw> <#id>CONF</#id>
#if CONF
  // CHECK: <kw>var</kw> <id>y1</id> : <type>Int</type>
  var y1 : Int
// CHECK: <#kw>#elseif</#kw> <#id>BAZ</#id>
#elseif BAZ
  // CHECK: <kw>var</kw> <id>y1</id> : <type>String</type>
  var y1 : String
// CHECK: <#kw>#else</#kw>
#else
  // CHECK: <kw>var</kw> <id>y1</id> : <type>Float</type>
  var y1 : Float
// CHECK: <#kw>#endif</#kw>
#endif

// CHECK: <#kw>#if</#kw> !<#id>CONF</#id>
#if !CONF
  // CHECK: <kw>var</kw> <id>y2</id> : <type>Int</type>
  var y2 : Int
// CHECK: <#kw>#elseif</#kw> <#id>BAZ</#id>
#elseif BAZ
  // CHECK: <kw>var</kw> <id>y2</id> : <type>String</type>
  var y2 : String
// CHECK: <#kw>#else</#kw>
#else
  // CHECK: <kw>var</kw> <id>y2</id> : <type>Float</type>
  var y2 : Float
// CHECK: <#kw>#endif</#kw>
#endif

// CHECK: <#kw>#if</#kw> !<#id>CONF</#id>
#if !CONF
  // CHECK: <kw>var</kw> <id>y3</id> : <type>Int</type>
  var y3 : Int
// CHECK: <#kw>#elseif</#kw> <#id>CONF</#id>
#elseif CONF
  // CHECK: <kw>var</kw> <id>y3</id> : <type>String</type>
  var y3 : String
// CHECK: <#kw>#else</#kw>
#else
  // CHECK: <kw>var</kw> <id>y3</id> : <type>Float</type>
  var y3 : Float
// CHECK: <#kw>#endif</#kw>
#endif

  // CHECK: <kw>var</kw> <id>l</id> : <type>Int</type>
  var l : Int
}

// CHECK: <kw>func</kw> <id>test1</id>() {
func test1() {
  // CHECK: <kw>var</kw> <id>f</id> : <type>Int</type>
  var f : Int<id>
</id>
// CHECK: <#kw>#if</#kw> <#id>CONF</#id>
#if CONF
  // CHECK: <kw>var</kw> <id>x</id> : <type>Int</type>
  var x : Int
// CHECK: <#kw>#else</#kw>
#else
  // CHECK: <kw>var</kw> <id>x</id> : <type>Float</type>
  var x : Float
// CHECK: <#kw>#endif</#kw>
#endif

// CHECK: <#kw>#if</#kw> <#id>CONF</#id>
#if CONF
  // CHECK: <kw>var</kw> <id>x2</id> : <type>Int</type>
  var x2 : Int
// CHECK: <#kw>#endif</#kw>
#endif

// CHECK: <#kw>#if</#kw> !<#id>CONF</#id>
#if !CONF
  // CHECK: <kw>var</kw> <id>x3</id> : <type>Int</type>
  var x3 : Int
// CHECK: <#kw>#else</#kw>
#else
  // CHECK: <kw>var</kw> <id>x3</id> : <type>Float</type>
  var x3 : Float
// CHECK: <#kw>#endif</#kw>
#endif

// CHECK: <#kw>#if</#kw> !<#id>CONF</#id>
#if !CONF
  // CHECK: <kw>var</kw> <id>x4</id> : <type>Int</type>
  var x4 : Int
// CHECK: <#kw>#endif</#kw>
#endif

// CHECK: <#kw>#if</#kw> <#id>CONF</#id>
#if CONF
  // CHECK: <kw>var</kw> <id>y1</id> : <type>Int</type>
  var y1 : Int
// CHECK: <#kw>#elseif</#kw> <#id>BAZ</#id>
#elseif BAZ
  // CHECK: <kw>var</kw> <id>y1</id> : <type>String</type>
  var y1 : String
// CHECK: <#kw>#else</#kw>
#else
  // CHECK: <kw>var</kw> <id>y1</id> : <type>Float</type>
  var y1 : Float
// CHECK: <#kw>#endif</#kw>
#endif

// CHECK: <#kw>#if</#kw> !<#id>CONF</#id>
#if !CONF
  // CHECK: <kw>var</kw> <id>y2</id> : <type>Int</type>
  var y2 : Int
// CHECK: <#kw>#elseif</#kw> <#id>BAZ</#id>
#elseif BAZ
  // CHECK: <kw>var</kw> <id>y2</id> : <type>String</type>
  var y2 : String
// CHECK: <#kw>#else</#kw>
#else
  // CHECK: <kw>var</kw> <id>y2</id> : <type>Float</type>
  var y2 : Float
// CHECK: <#kw>#endif</#kw>
#endif

// CHECK: <#kw>#if</#kw> !<#id>CONF</#id>
#if !CONF
  // CHECK: <kw>var</kw> <id>y3</id> : <type>Int</type>
  var y3 : Int
// CHECK: <#kw>#elseif</#kw> <#id>CONF</#id>
#elseif CONF
  // CHECK: <kw>var</kw> <id>y3</id> : <type>String</type>
  var y3 : String
// CHECK: <#kw>#else</#kw>
#else
  // CHECK: <kw>var</kw> <id>y3</id> : <type>Float</type>
  var y3 : Float
// CHECK: <#kw>#endif</#kw>
#endif

  // CHECK: <kw>var</kw> <id>l</id> : <type>Int</type>
  var l : Int
}

// CHECK: <kw>class</kw> <id>C2</id> {
class C2 {
  // CHECK: <#kw>#if</#kw> <#id>os</#id>(<#id>iOS</#id>)
  #if os(iOS)
  // CHECK: <kw>func</kw> <id>foo</id>() {}
  func foo() {}
  #endif
}

class NestedPoundIf {
// CHECK: <kw>class</kw> <id>NestedPoundIf</id> {
    func foo1() {
// CHECK: <kw>func</kw> <id>foo1</id>() {
        #if os(macOS)
// CHECK: <#kw>#if</#kw> <#id>os</#id>(<#id>macOS</#id>)
          var a = 1
// CHECK: <kw>var</kw> <id>a</id> = <int>1</int>
            #if USE_METAL
// CHECK: <#kw>#if</#kw> <#id>USE_METAL</#id>
              var b = 2
// CHECK: <kw>var</kw> <id>b</id> = <int>2</int>
              #if os(iOS)
// CHECK: <#kw>#if</#kw> <#id>os</#id>(<#id>iOS</#id>)
                var c = 3
// CHECK: <kw>var</kw> <id>c</id> = <int>3</int>
              #else
// CHECK: <#kw>#else</#kw>
                var c = 3
// CHECK: <kw>var</kw> <id>c</id> = <int>3</int>
              #endif
// CHECK: <#kw>#endif</#kw>
            #else
// CHECK: <#kw>#else</#kw>
              var b = 2
// CHECK: <kw>var</kw> <id>b</id> = <int>2</int>
            #endif
// CHECK: <#kw>#endif</#kw>
           #else
// CHECK: <#kw>#else</#kw>
            var a = 1
// CHECK: <kw>var</kw> <id>a</id> = <int>1</int>
        #endif
// CHECK: <#kw>#endif</#kw>
    }
    func foo2() {}
// CHECK: <kw>func</kw> <id>foo2</id>() {}
    func foo3() {}
// CHECK: <kw>func</kw> <id>foo3</id>() {}
}

// CHECK: <#kw>#error</#kw>(<str>"Error"</str>)
#error("Error")
// CHECK: <#kw>#warning</#kw>(<str>"Warning"</str>)
#warning("Warning")
// CHECK: <#kw>#sourceLocation</#kw>(<id>file</id>: <str>"x"</str>, <id>line</id>: <int>1</int>)
#sourceLocation(file: "x", line: 1)
// CHECK: <kw>#line</kw> <int>17</int> <str>"abc.swift"</str>
#line 17 "abc.swift"

@available(iOS 8.0, OSX 10.10, *)
// CHECK: <attr-builtin>@available</attr-builtin>(<kw>iOS</kw> <float>8.0</float>, <kw>OSX</kw> <float>10.10</float>, *)
func foo() {
// CHECK: <kw>if</kw> <kw>#available</kw> (<kw>OSX</kw> <float>10.10</float>, <kw>iOS</kw> <float>8.01</float>, *) {<kw>let</kw> <kw>_</kw> = <str>"iOS"</str>}
  if #available (OSX 10.10, iOS 8.01, *) {let _ = "iOS"}
}

// CHECK: <kw>func</kw> <id>test4</id>(<id>a</id>: <kw>inout</kw> <type>Int</type>) {{{$}}
func test4(a: inout Int) {
  // CHECK-OLD: <kw>if</kw> <kw>#available</kw> (<kw>OSX</kw> >= <float>10.10</float>, <kw>iOS</kw> >= <float>8.01</float>) {<kw>let</kw> OSX = <str>"iOS"</str>}}{{$}}
  // CHECK-NEW: <kw>if</kw> <kw>#available</kw> (OSX >= <float>10.10</float>, iOS >= <float>8.01</float>) {<kw>let</kw> OSX = <str>"iOS"</str>}}{{$}}
  if #available (OSX >= 10.10, iOS >= 8.01) {let OSX = "iOS"}}

// CHECK: <kw>func</kw> <id>test4b</id>(<id>a</id>: <kw>inout</kw> <type>Int</type>) {{{$}}
func test4b(a: inout Int) {
}

let filename = #file
// CHECK: <kw>let</kw> <id>filename</id> = <kw>#file</kw>
let line = #line
// CHECK: <kw>let</kw> <id>line</id> = <kw>#line</kw>
let column = #column
// CHECK: <kw>let</kw> <id>column</id> = <kw>#column</kw>
let function = #function
// CHECK: <kw>let</kw> <id>function</id> = <kw>#function</kw>

let image = #imageLiteral(resourceName: "cloud.png")
// CHECK-OLD: <kw>let</kw> <id>image</id> = <object-literal>#imageLiteral(resourceName: "cloud.png")</object-literal>
// CHECK-NEW: <kw>let</kw> <id>image</id> = <object-literal>#imageLiteral</object-literal>(resourceName: <str>"cloud.png"</str>)
let file = #fileLiteral(resourceName: "cloud.png")
// CHECK-OLD: <kw>let</kw> <id>file</id> = <object-literal>#fileLiteral(resourceName: "cloud.png")</object-literal>
// CHECK-NEW: <kw>let</kw> <id>file</id> = <object-literal>#fileLiteral</object-literal>(resourceName: <str>"cloud.png"</str>)
let black = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
// CHECK-OLD: <kw>let</kw> <id>black</id> = <object-literal>#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)</object-literal>
// CHECK-NEW: <kw>let</kw> <id>black</id> = <object-literal>#colorLiteral</object-literal>(red: <int>0</int>, green: <int>0</int>, blue: <int>0</int>, alpha: <int>1</int>)

let rgb = [#colorLiteral(red: 1, green: 0, blue: 0, alpha: 1),
           #colorLiteral(red: 0, green: 1, blue: 0, alpha: 1),
           #colorLiteral(red: 0, green: 0, blue: 1, alpha: 1)]
// CHECK-OLD: <kw>let</kw> rgb = [<object-literal>#colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)</object-literal>,
// CHECK-OLD:                     <object-literal>#colorLiteral(red: 0, green: 1, blue: 0, alpha: 1)</object-literal>,
// CHECK-OLD:                     <object-literal>#colorLiteral(red: 0, green: 0, blue: 1, alpha: 1)</object-literal>]
// CHECK-NEW: <kw>let</kw> rgb = [<object-literal>#colorLiteral</object-literal>(red: <int>1</int>, green: <int>0</int>, blue: <int>0</int>, alpha: <int>1</int>),
// CHECK-NEW:                     <object-literal>#colorLiteral</object-literal>(red: <int>0</int>, green: <int>1</int>, blue: <int>0</int>, alpha: <int>1</int>),
// CHECK-NEW:                     <object-literal>#colorLiteral</object-literal>(red: <int>0</int>, green: <int>0</int>, blue: <int>1</int>, alpha: <int>1</int>)]
