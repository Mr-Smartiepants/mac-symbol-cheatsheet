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
        SymbolItem(symbol: "€", name: "Euro", shortcut: "⌥⇧2"),
        SymbolItem(symbol: "→", name: "Right Arrow", shortcut: "⌥→"),
        SymbolItem(symbol: "≤", name: "Less or Equal", shortcut: "⌥,"),
        SymbolItem(symbol: "≥", name: "Greater or Equal", shortcut: "⌥."),
        SymbolItem(symbol: "•", name: "Bullet", shortcut: "⌥8"),
        SymbolItem(symbol: "©", name: "Copyright", shortcut: "⌥G"),
        SymbolItem(symbol: "™", name: "Trademark", shortcut: "⌥2")
    ]

    var body: some View {
        List(symbols) { item in
            HStack(spacing: 10) {
                Text(item.symbol)
                    .font(.system(size: 22))
                    .frame(width: 36, alignment: .center)

                VStack(alignment: .leading, spacing: 2) {
                    Text(item.name).font(.headline)
                    Text(item.shortcut)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Button("Copy") {
                    copyToClipboard(item.symbol)
                }
                .buttonStyle(.bordered)
            }
            .padding(.vertical, 4)
        }
        .frame(minWidth: 420, minHeight: 520)
    }

    private func copyToClipboard(_ text: String) {
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(text, forType: .string)
    }
}
