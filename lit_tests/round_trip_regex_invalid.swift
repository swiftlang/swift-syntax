// RUN: %empty-directory(%t)
// RUN: %lit-test-helper -roundtrip -source-file %s -out %t/afterRoundtrip.swift
// RUN: diff -u %t/afterRoundtrip.swift %s

_ = /abc
_ = #/abc
_ = #/abc/
_ = ##/abc/#

_ #/x
/#
_ #/
x/#

_ //#
_ /x/#

_ = ""
