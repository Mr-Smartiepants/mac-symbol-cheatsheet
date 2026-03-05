//
//  SymbolItem.swift
//  mac-symbol-cheatsheet
//
//  Created by Stefan Weißgerber on 05.03.26.
//

import Foundation

struct SymbolItem: Identifiable {

    // Stable key for favorites (do NOT use UUID for persistence)
    var id: String { key }

    let symbol: String
    let macShortcut: String
    let keys: String
    let searchTerms: [String]

    // A stable identifier for persistence
    var key: String {
        "\(symbol)|\(macShortcut)"
    }
}
