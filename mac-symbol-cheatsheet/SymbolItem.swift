//
//  SymbolItem.swift
//  mac-symbol-cheatsheet
//
//  Created by Stefan Weißgerber on 05.03.26.
//

import Foundation

struct SymbolItem: Identifiable {
    let id = UUID()
    let symbol: String
    let name: String
    let shortcut: String
    // optional später:
    // let category: String
    // let tags: [String]
}
