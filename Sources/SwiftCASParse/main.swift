//
//  main.swift
//  
//
//  Created by Jan Svoboda on 6/12/24.
//

import SwiftParser
import Foundation

let file = URL(fileURLWithPath: "/Users/Jan/Desktop/in.swift")
let source = try String(contentsOf: file)

let clock = ContinuousClock()
let elapsed = clock.measure {
  let node = Parser.parse(source: source)
  let _ = Parser.countSwitchExpressionsPerFunction(node)
}

print("Input file parsed in \(elapsed)")
