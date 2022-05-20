// RUN: %empty-directory(%t)
// RUN: %lit-test-helper -roundtrip -source-file %s -out %t/afterRoundtrip.swift
// RUN: diff -u %t/afterRoundtrip.swift %s


_ = /abc/
_ = #/abc/#
_ = ##/abc/##

func foo<T>(_ x: T...) {}
foo(/abc/, #/abc/#, ##/abc/##)

let arr = [/abc/, #/abc/#, ##/abc/##]

_ = /\w+/.self
_ = #/\w+/#.self
_ = ##/\w+/##.self

_ = /#\/\#\\/
_ = #/#/\/\#\\/#
_ = ##/#|\|\#\\/##

_ = #/
multiline
/#

_ = #/
double
multiline
/#

