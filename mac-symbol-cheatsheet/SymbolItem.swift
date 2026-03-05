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

    // Apple-Symbolnotation
    let macShortcut: String

    // ausgeschriebene Tasten
    let keys: String
}
