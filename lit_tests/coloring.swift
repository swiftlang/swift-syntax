// RUN: %lit-test-helper -classify-syntax -source-file %s | %FileCheck %s

enum List<T> {
  case Nil
  // rdar://21927124
  // CHECK: <kw>indirect</kw> <kw>case</kw> <id>Cons</id>(<type>T</type>, <type>List</type>)
  indirect case Cons(T, List)
}

// CHECK: <kw>struct</kw> <id>S</id> {
struct S {
  // CHECK: <kw>var</kw> <id>x</id> : <type>Int</type>
  var x : Int
  // CHECK: <kw>var</kw> <id>y</id> : <type>Int</type>.<type>Int</type>
  var y : Int.Int
  // CHECK: <kw>var</kw> <id>a</id>, <id>b</id> : <type>Int</type>
  var a, b : Int
}

enum EnumWithDerivedEquatableConformance : Int {
// CHECK-LABEL: <kw>enum</kw> <id>EnumWithDerivedEquatableConformance</id> : {{(<type>)}}Int{{(</type>)?}} {
  case CaseA
// CHECK-NEXT: <kw>case</kw> <id>CaseA</id>
  case CaseB, CaseC
// CHECK-NEXT: <kw>case</kw> <id>CaseB</id>, <id>CaseC</id>
  case CaseD = 30, CaseE
// CHECK-NEXT: <kw>case</kw> <id>CaseD</id> = <int>30</int>, <id>CaseE</id>
}
// CHECK-NEXT: }

// CHECK: <kw>class</kw> <id>MyCls</id> {
class MyCls {
    // CHECK: <kw>var</kw> <id>www</id> : <type>Int</type>
    var www : Int

    // CHECK: <kw>func</kw> <id>foo</id>(<id>x</id>: <type>Int</type>) {}
    func foo(x: Int) {}
    // CHECK: <kw>var</kw> <id>aaa</id> : <type>Int</type> {
    var aaa : Int {
      // CHECK: <kw>get</kw> {}
      get {}
      // CHECK: <kw>set</kw> {}
      set {}
    }
    // CHECK: <kw>var</kw> <id>bbb</id> : <type>Int</type> {
    var bbb : Int {
      // CHECK: <kw>set</kw> {
      set {
       // CHECK: <kw>var</kw> <id>tmp</id> : <type>Int</type>
        var tmp : Int
      }
      // CHECK: <kw>get</kw> {
      get {
       // CHECK: <kw>var</kw> <id>tmp</id> : <type>Int</type>
       var tmp : Int
      }
    }

    // CHECK: <kw>subscript</kw> (<id>i</id> : <type>Int</type>, <id>j</id> : <type>Int</type>) -> <type>Int</type> {
    subscript (i : Int, j : Int) -> Int {
      // CHECK: <kw>get</kw> {
      get {
        // CHECK: <kw>return</kw> <id>i</id> + <id>j</id>
        return i + j
      }
      // CHECK: <kw>set</kw>(<id>v</id>) {
      set(v) {
        // CHECK: <id>v</id> + <id>i</id> - <id>j</id>
        v + i - j
      }
    }

    // CHECK: <kw>func</kw> <id>multi</id>(<kw>_</kw> <id>name</id>: <type>Int</type>, <id>otherpart</id> <id>x</id>: <type>Int</type>) {}
    func multi(_ name: Int, otherpart x: Int) {}
}

// CHECK-LABEL: <kw>class</kw> <id>Attributes</id> {
class Attributes {
// CHECK: <attr-builtin>@IBOutlet</attr-builtin> <kw>var</kw> <id>v0</id>: <type>Int</type>
  @IBOutlet var v0: Int

// CHECK: <attr-builtin>@IBOutlet</attr-builtin> <attr-builtin>@IBOutlet</attr-builtin> <kw>var</kw> <id>v1</id>: <type>String</type>
  @IBOutlet @IBOutlet var v1: String

// CHECK: <attr-builtin>@objc</attr-builtin> <attr-builtin>@IBOutlet</attr-builtin> <kw>var</kw> <id>v2</id>: <type>String</type>
  @objc @IBOutlet var v2: String

// CHECK: <attr-builtin>@IBOutlet</attr-builtin> <attr-builtin>@objc</attr-builtin> <kw>var</kw> <id>v3</id>: <type>String</type>
  @IBOutlet @objc var v3: String

// CHECK: <attr-builtin>@available</attr-builtin>(*, <id>unavailable</id>) <kw>func</kw> <id>f1</id>() {}
  @available(*, unavailable) func f1() {}

// CHECK: <attr-builtin>@available</attr-builtin>(*, <id>unavailable</id>) <attr-builtin>@IBAction</attr-builtin> <kw>func</kw> <id>f2</id>() {}
  @available(*, unavailable) @IBAction func f2() {}

// CHECK: <attr-builtin>@IBAction</attr-builtin> <attr-builtin>@available</attr-builtin>(*, <id>unavailable</id>) <kw>func</kw> <id>f3</id>() {}
  @IBAction @available(*, unavailable) func f3() {}

// CHECK: <kw>mutating</kw> <kw>func</kw> <id>func_mutating_1</id>() {}
  mutating func func_mutating_1() {}

// CHECK: <kw>nonmutating</kw> <kw>func</kw> <id>func_mutating_2</id>() {}
  nonmutating func func_mutating_2() {}
}

func stringLikeLiterals() {
// CHECK: <kw>var</kw> <id>us1</id>: <type>UnicodeScalar</type> = <str>"a"</str>
  var us1: UnicodeScalar = "a"
// CHECK: <kw>var</kw> <id>us2</id>: <type>UnicodeScalar</type> = <str>"ы"</str>
  var us2: UnicodeScalar = "ы"

// CHECK: <kw>var</kw> <id>ch1</id>: <type>Character</type> = <str>"a"</str>
  var ch1: Character = "a"
// CHECK: <kw>var</kw> <id>ch2</id>: <type>Character</type> = <str>"あ"</str>
  var ch2: Character = "あ"

// CHECK: <kw>var</kw> <id>s1</id> = <str>"abc абвгд あいうえお"</str>
  var s1 = "abc абвгд あいうえお"
}

// CHECK: <kw>var</kw> <id>globComp</id> : <type>Int</type>
var globComp : Int {
  // CHECK: <kw>get</kw> {
  get {
    // CHECK: <kw>return</kw> <int>0</int>
    return 0
  }
}

// CHECK: <kw>func</kw> <id>foo</id>(<id>n</id>: <type>Float</type>) -> <type>Int</type> {
func foo(n: Float) -> Int {
    // CHECK: <kw>var</kw> <id>fnComp</id> : <type>Int</type>
    var fnComp : Int {
      // CHECK: <kw>get</kw> {
      get {
        // CHECK: <kw>var</kw> <id>a</id>: <type>Int</type>
        // CHECK: <kw>return</kw> <int>0</int>
        var a: Int
        return 0
      }
    }
    // CHECK: <kw>var</kw> <id>q</id> = <id>MyCls</id>()
    var q = MyCls()
    // CHECK: <kw>var</kw> <id>ee</id> = <str>"yoo"</str>;
    var ee = "yoo";
    // CHECK: <kw>return</kw> <int>100009</int>
    return 100009
}

// CHECK: <kw>protocol</kw> <id>Prot</id>
protocol Prot {
  // CHECK: <kw>typealias</kw> <id>Blarg</id>
  typealias Blarg
  // CHECK: <kw>func</kw> <id>protMeth</id>(<id>x</id>: <type>Int</type>)
  func protMeth(x: Int)
  // CHECK: <kw>var</kw> <id>protocolProperty1</id>: <type>Int</type> { <kw>get</kw> }
  var protocolProperty1: Int { get }
  // CHECK: <kw>var</kw> <id>protocolProperty2</id>: <type>Int</type> { <kw>get</kw> <kw>set</kw> }
  var protocolProperty2: Int { get set }
}

// CHECK: <kw>infix</kw> <kw>operator</kw> *-* : <id>FunnyPrecedence</id>{{$}}
infix operator *-* : FunnyPrecedence

// CHECK: <kw>precedencegroup</kw> <id>FunnyPrecedence</id>
// CHECK-NEXT: <kw>associativity</kw>: <id>left</id>{{$}}
// CHECK-NEXT: <kw>higherThan</kw>: <id>MultiplicationPrecedence</id>
precedencegroup FunnyPrecedence {
  associativity: left
  higherThan: MultiplicationPrecedence
}

// CHECK: <kw>func</kw> *-*(<id>l</id>: <type>Int</type>, <id>r</id>: <type>Int</type>) -> <type>Int</type> { <kw>return</kw> <id>l</id> }{{$}}
func *-*(l: Int, r: Int) -> Int { return l }

// CHECK: <kw>infix</kw> <kw>operator</kw> *-+* : <id>FunnyPrecedence</id>
infix operator *-+* : FunnyPrecedence

// CHECK: <kw>func</kw> *-+*(<id>l</id>: <type>Int</type>, <id>r</id>: <type>Int</type>) -> <type>Int</type> { <kw>return</kw> <id>l</id> }{{$}}
func *-+*(l: Int, r: Int) -> Int { return l }

// CHECK: <kw>infix</kw> <kw>operator</kw> *--*{{$}}
infix operator *--*

// CHECK: <kw>func</kw> *--*(<id>l</id>: <type>Int</type>, <id>r</id>: <type>Int</type>) -> <type>Int</type> { <kw>return</kw> <id>l</id> }{{$}}
func *--*(l: Int, r: Int) -> Int { return l }

// CHECK: <kw>protocol</kw> <id>Prot2</id> : <type>Prot</type> {}
protocol Prot2 : Prot {}

// CHECK: <kw>class</kw> <id>SubCls</id> : <type>MyCls</type>, <type>Prot</type> {}
class SubCls : MyCls, Prot {}

// CHECK: <kw>func</kw> <id>genFn</id><<id>T</id> : <type>Prot</type>>(<kw>_</kw>: <type>T</type>) -> <type>Int</type> <kw>where</kw> <type>T</type>.<type>Blarg</type> : <type>Prot2</type> {}{{$}}
func genFn<T : Prot>(_: T) -> Int where T.Blarg : Prot2 {}

func f(x: Int) -> Int {
  // CHECK: <str>"This is string </str>\<anchor>(</anchor><id>genFn</id>({(<id>a</id>:<type>Int</type> -> <type>Int</type>) <kw>in</kw> <id>a</id>})<anchor>)</anchor><str> interpolation"</str>
  "This is string \(genFn({(a:Int -> Int) in a})) interpolation"

  // CHECK: <str>"This is unterminated</str>
  "This is unterminated

  // CHECK: <str>"This is unterminated with ignored \(interpolation) in it</str>
  "This is unterminated with ignored \(interpolation) in it

  // CHECK: <str>"This is terminated with invalid \(interpolation" + "in it"</str>
  "This is terminated with invalid \(interpolation" + "in it"

  // CHECK: <str>"""
  // CHECK-NEXT: This is a multiline string.
  // CHECK-NEXT: """</str>
  """
  This is a multiline string.
"""

  // CHECK: <str>"""
  // CHECK-NEXT: This is a multiline</str>\<anchor>(</anchor> <str>"interpolated"</str> <anchor>)</anchor><str>string
  // CHECK-NEXT: </str>\<anchor>(</anchor>
  // CHECK-NEXT: <str>"""
  // CHECK-NEXT: inner
  // CHECK-NEXT: """</str>
  // CHECK-NEXT: <anchor>)</anchor><str>
  // CHECK-NEXT: """</str>
  """
      This is a multiline\( "interpolated" )string
   \(
   """
    inner
   """
   )
   """

  // CHECK: <str>"</str>\<anchor>(</anchor><int>1</int><anchor>)</anchor><str></str>\<anchor>(</anchor><int>1</int><anchor>)</anchor><str>"</str>
  "\(1)\(1)"
}

// CHECK: <kw>func</kw> <id>bar</id>(<id>x</id>: <type>Int</type>) -> (<type>Int</type>, <type>Float</type>) {
func bar(x: Int) -> (Int, Float) {
  // CHECK: <id>foo</id>(<id>Float</id>())
  foo(Float())
}

class GenC<T1,T2> {}

func test() {
  // CHECK: {{(<type>)?}}<id>GenC</id>{{(</type>)?}}<<type>Int</type>, <type>Float</type>>()
  var x = GenC<Int, Float>()
}

// CHECK: <kw>typealias</kw> <id>MyInt</id> = <type>Int</type>
typealias MyInt = Int

func test2(x: Int) {
  // CHECK: <str>"</str>\<anchor>(</anchor><id>x</id><anchor>)</anchor><str>"</str>
  "\(x)"
}

// CHECK: <kw>class</kw> <id>Observers</id> {
class Observers {
  // CHECK: <kw>var</kw> <id>p1</id> : <type>Int</type> {
  var p1 : Int {
    // CHECK: <kw>willSet</kw>(<id>newValue</id>) {}
    willSet(newValue) {}
    // CHECK: <kw>didSet</kw> {}
    didSet {}
  }
  // CHECK: <kw>var</kw> <id>p2</id> : <type>Int</type> {
  var p2 : Int {
    // CHECK: <kw>didSet</kw> {}
    didSet {}
    // CHECK: <kw>willSet</kw> {}
    willSet {}
  }
}

// CHECK: <kw>func</kw> <id>test3</id>(<id>o</id>: <type>AnyObject</type>) {
func test3(o: AnyObject) {
  // CHECK: <kw>_</kw> = <id>o</id> <kw>is</kw> <type>MyCls</type> ? <id>o</id> <kw>as</kw> <type>MyCls</type> : <id>o</id> <kw>as</kw>! <type>MyCls</type> <kw>as</kw> <type>MyCls</type> + <int>1</int>
  _ = o is MyCls ? o as MyCls : o as! MyCls as MyCls + 1
}

// CHECK: <kw>class</kw> <id>MySubClass</id> : <type>MyCls</type> {
class MySubClass : MyCls {
    // CHECK: <kw>override</kw> <kw>func</kw> <id>foo</id>(<id>x</id>: <type>Int</type>) {}
    override func foo(x: Int) {}

    // CHECK: <kw>convenience</kw> <kw>init</kw>(<id>a</id>: <type>Int</type>) {}
    convenience init(a: Int) {}
}

// CHECK: <kw>var</kw> <id>g1</id> = { (<id>x</id>: <type>Int</type>) -> <type>Int</type> <kw>in</kw> <kw>return</kw> <int>0</int> }
var g1 = { (x: Int) -> Int in return 0 }

// CHECK: <kw>infix</kw> <kw>operator</kw> ~~ {
infix operator ~~ {}
// CHECK: <kw>prefix</kw> <kw>operator</kw> *~~ {
prefix operator *~~ {}
// CHECK: <kw>postfix</kw> <kw>operator</kw> ~~* {
postfix operator ~~* {}

func test_defer() {
  defer {
    // CHECK: <kw>let</kw> <id>x</id> : <type>Int</type> = <int>0</int>
    let x : Int = 0
  }
}

func test6<T : Prot>(x: T) {}
// CHECK: <kw>func</kw> <id>test6</id><<id>T</id> : <type>Prot</type>>(<id>x</id>: <type>T</type>) {}{{$}}

// CHECK: <kw>func</kw> <placeholder><#test1#></placeholder> () {}
func <#test1#> () {}

func funcTakingFor(for internalName: Int) {}
// CHECK: <kw>func</kw> <id>funcTakingFor</id>(<id>for</id> <id>internalName</id>: <type>Int</type>) {}

func funcTakingIn(in internalName: Int) {}
// CHECK: <kw>func</kw> <id>funcTakingIn</id>(<id>in</id> <id>internalName</id>: <type>Int</type>) {}

_ = 123
// CHECK: <int>123</int>
_ = -123
// CHECK: -<int>123</int>
_ = -1
// CHECK: -<int>1</int>
_ = -0x123
// CHECK: -<int>0x123</int>
_ = -3.1e-5
// CHECK: <float>3.1e-5</float>

"--\"\(x) --"
// CHECK: <str>"--\"</str>\<anchor>(</anchor><id>x</id><anchor>)</anchor><str> --"</str>

func keywordAsLabel1(in: Int) {}
// CHECK: <kw>func</kw> <id>keywordAsLabel1</id>(<id>in</id>: <type>Int</type>) {}
func keywordAsLabel2(for: Int) {}
// CHECK: <kw>func</kw> <id>keywordAsLabel2</id>(<id>for</id>: <type>Int</type>) {}
func keywordAsLabel3(if: Int, for: Int) {}
// CHECK: <kw>func</kw> <id>keywordAsLabel3</id>(<id>if</id>: <type>Int</type>, <id>for</id>: <type>Int</type>) {}
func keywordAsLabel4(_: Int) {}
// CHECK: <kw>func</kw> <id>keywordAsLabel4</id>(<kw>_</kw>: <type>Int</type>) {}
func keywordAsLabel5(_: Int, for: Int) {}
// CHECK: <kw>func</kw> <id>keywordAsLabel5</id>(<kw>_</kw>: <type>Int</type>, <id>for</id>: <type>Int</type>) {}
func keywordAsLabel6(if func: Int) {}
// CHECK: <kw>func</kw> <id>keywordAsLabel6</id>(<id>if</id> <id>func</id>: <type>Int</type>) {}

func foo1() {
// CHECK: <kw>func</kw> <id>foo1</id>() {
  keywordAsLabel1(in: 1)
// CHECK: <id>keywordAsLabel1</id>(<id>in</id>: <int>1</int>)
  keywordAsLabel2(for: 1)
// CHECK: <id>keywordAsLabel2</id>(<id>for</id>: <int>1</int>)
  keywordAsLabel3(if: 1, for: 2)
// CHECK: <id>keywordAsLabel3</id>(<id>if</id>: <int>1</int>, <id>for</id>: <int>2</int>)
  keywordAsLabel5(1, for: 2)
// CHECK: <id>keywordAsLabel5</id>(<int>1</int>, <id>for</id>: <int>2</int>)

  _ = (if: 0, for: 2)
// CHECK: <kw>_</kw> = (<id>if</id>: <int>0</int>, <id>for</id>: <int>2</int>)
  _ = (_: 0, _: 2)
// CHECK: <kw>_</kw> = (<kw>_</kw>: <int>0</int>, <kw>_</kw>: <int>2</int>)
}

func foo2(O1 : Int?, O2: Int?, O3: Int?) {
  guard let _ = O1, var _ = O2, let _ = O3 else { }
// CHECK:  <kw>guard</kw> <kw>let</kw> <kw>_</kw> = <id>O1</id>, <kw>var</kw> <kw>_</kw> = <id>O2</id>, <kw>let</kw> <kw>_</kw> = <id>O3</id> <kw>else</kw> { }
  if let _ = O1, var _ = O2, let _ = O3 {}
// CHECK: <kw>if</kw> <kw>let</kw> <kw>_</kw> = <id>O1</id>, <kw>var</kw> <kw>_</kw> = <id>O2</id>, <kw>let</kw> <kw>_</kw> = <id>O3</id> {}
}

func keywordInCaseAndLocalArgLabel(_ for: Int, for in: Int, class _: Int) {
// CHECK:  <kw>func</kw> <id>keywordInCaseAndLocalArgLabel</id>(<kw>_</kw> <id>for</id>: <type>Int</type>, <id>for</id> <id>in</id>: <type>Int</type>, <id>class</id> <kw>_</kw>: <type>Int</type>) {
  switch(`for`, `in`) {
  case (let x, let y):
// CHECK: <kw>case</kw> (<kw>let</kw> <id>x</id>, <kw>let</kw> <id>y</id>):
    print(x, y)
  }
}

// CHECK: <kw>class</kw> <id>Ownership</id> {
class Ownership {
  // CHECK: <kw>weak</kw> <kw>var</kw> <id>w</id>
  weak var w
  // CHECK: <kw>unowned</kw> <kw>var</kw> <id>u</id>
  unowned var u
  // CHECK: <kw>unowned</kw>(<id>unsafe</id>) <kw>var</kw> <id>uu</id>
  unowned(unsafe) var uu
}
// FIXME: CHECK: <kw>let</kw> closure = { [weak x=bindtox, unowned y=bindtoy, unowned(unsafe) z=bindtoz] <kw>in</kw> }
let closure = { [weak x=bindtox, unowned y=bindtoy, unowned(unsafe) z=bindtoz] in }

protocol FakeClassRestrictedProtocol : `class` {}
// CHECK: <kw>protocol</kw> <id>FakeClassRestrictedProtocol</id> : <type>`class`</type> {}

// CHECK: <kw>func</kw> <id>foo</id>() -> <kw>some</kw> <type>P</type> {}
func foo() -> some P {}

// CHECK: <kw>func</kw> <id>foo</id>() -> <kw>some</kw> <type>P</type> & <type>Q</type> {}
func foo() -> some P & Q {}
