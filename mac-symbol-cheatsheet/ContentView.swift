//
//  ContentView.swift
//  mac-symbol-cheatsheet
//
//  Created by Stefan Weißgerber on 05.03.26.
//

import SwiftUI
import AppKit

struct ContentView: View {

    let symbols: [SymbolItem] = [

        // --- Programming basics (brackets, pipes, slashes) ---
        SymbolItem(symbol: "[", macShortcut: "⌥5", keys: "Option (Alt) + 5"),
        SymbolItem(symbol: "]", macShortcut: "⌥6", keys: "Option (Alt) + 6"),
        SymbolItem(symbol: "{", macShortcut: "⌥8", keys: "Option (Alt) + 8"),
        SymbolItem(symbol: "}", macShortcut: "⌥9", keys: "Option (Alt) + 9"),
        SymbolItem(symbol: "|", macShortcut: "⌥7", keys: "Option (Alt) + 7"),
        SymbolItem(symbol: "\\", macShortcut: "⌥⇧7", keys: "Option (Alt) + Shift + 7"),
        SymbolItem(symbol: "~", macShortcut: "⌥N ␠", keys: "Option (Alt) + N, then Space"),
        SymbolItem(symbol: "@", macShortcut: "⌥L", keys: "Option (Alt) + L"),
        SymbolItem(symbol: "€", macShortcut: "⌥E", keys: "Option (Alt) + E"),

        // --- Comparison / logic (very common in code & math) ---
        SymbolItem(symbol: "≠", macShortcut: "⌥0", keys: "Option (Alt) + 0"),
        SymbolItem(symbol: "≤", macShortcut: "⌥<", keys: "Option (Alt) + <"),
        SymbolItem(symbol: "≥", macShortcut: "⌥⇧<", keys: "Option (Alt) + Shift + <"),
        SymbolItem(symbol: "<", macShortcut: "⇧<", keys: "Shift + <"),
        SymbolItem(symbol: ">", macShortcut: "<", keys: "< key (on DE layout)"),

        // --- Math / CS symbols ---
        SymbolItem(symbol: "±", macShortcut: "⌥+", keys: "Option (Alt) + +"),
        SymbolItem(symbol: "≈", macShortcut: "⌥X", keys: "Option (Alt) + X"),
        SymbolItem(symbol: "∞", macShortcut: "⌥,", keys: "Option (Alt) + ,"),
        SymbolItem(symbol: "π", macShortcut: "⌥P", keys: "Option (Alt) + P"),
        SymbolItem(symbol: "√", macShortcut: "⌥V", keys: "Option (Alt) + V"),
        SymbolItem(symbol: "ø", macShortcut: "⌥O", keys: "Option (Alt) + O"),

        // --- Useful punctuation / typography (often used in docs, READMEs, comments) ---
        SymbolItem(symbol: "•", macShortcut: "⌥8", keys: "Option (Alt) + 8"),
        SymbolItem(symbol: "…", macShortcut: "⌥.", keys: "Option (Alt) + ."),
        SymbolItem(symbol: "–", macShortcut: "⌥-", keys: "Option (Alt) + -"),
        SymbolItem(symbol: "—", macShortcut: "⌥⇧-", keys: "Option (Alt) + Shift + -"),
        SymbolItem(symbol: "“", macShortcut: "⌥[", keys: "Option (Alt) + ["),
        SymbolItem(symbol: "”", macShortcut: "⌥⇧[", keys: "Option (Alt) + Shift + ["),
        SymbolItem(symbol: "‘", macShortcut: "⌥]", keys: "Option (Alt) + ]"),
        SymbolItem(symbol: "’", macShortcut: "⌥⇧]", keys: "Option (Alt) + Shift + ]"),

        // --- Legal / common symbols ---
        SymbolItem(symbol: "©", macShortcut: "⌥G", keys: "Option (Alt) + G"),
        SymbolItem(symbol: "®", macShortcut: "⌥R", keys: "Option (Alt) + R"),
        SymbolItem(symbol: "™", macShortcut: "⌥⇧D", keys: "Option (Alt) + Shift + D"),

        // --- Currency / finance-ish ---
        SymbolItem(symbol: "$", macShortcut: "⇧4", keys: "Shift + 4"),
        SymbolItem(symbol: "£", macShortcut: "⌥⇧4", keys: "Option (Alt) + Shift + 4"),
        SymbolItem(symbol: "§", macShortcut: "⇧3", keys: "Shift + 3"),
        SymbolItem(symbol: "%", macShortcut: "⇧5", keys: "Shift + 5"),
    ]

    var body: some View {
        VStack(spacing: 8) {

            // Header row
            HStack(spacing: 10) {
                Text("Symbol")
                    .frame(width: 36, alignment: .center)

                Text("Mac")
                    .frame(width: 80, alignment: .leading)

                Text("Keys")
                    .frame(maxWidth: .infinity, alignment: .leading)

                Spacer(minLength: 0)

                Text("") // Platz für Copy-Button
                    .frame(width: 60)
            }
            .font(.caption)
            .foregroundStyle(.secondary)
            .padding(.horizontal, 8)

            // Table-like list
            List(symbols) { item in
                HStack(spacing: 10) {

                    Text(item.symbol)
                        .font(.system(size: 22))
                        .frame(width: 36, alignment: .center)

                    Text(item.macShortcut)
                        .font(.system(.body, design: .monospaced))
                        .frame(width: 80, alignment: .leading)

                    Text(item.keys)
                        .foregroundStyle(.secondary)

                    Spacer()

                    Button("Copy") {
                        copyToClipboard(item.symbol)
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.vertical, 4)
            }
        }
        .frame(minWidth: 420, minHeight: 520)
        .padding(8)
    }
        private func copyToClipboard(_ text: String) {
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(text, forType: .string)
    }
}
    


