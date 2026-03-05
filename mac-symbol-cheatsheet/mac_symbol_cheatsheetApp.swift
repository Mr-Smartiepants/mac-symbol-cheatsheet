//
//  mac_symbol_cheatsheetApp.swift
//  mac-symbol-cheatsheet
//
//  Created by Stefan Weißgerber on 05.03.26.
//

import SwiftUI

@main
struct ShortcutsWidgetApp: App {
    var body: some Scene {
        MenuBarExtra("Sonderzeichen", image: "MenuBarIcon") {
            ContentView()
                .frame(minWidth: 420, idealWidth: 420, maxWidth: 420,
                       minHeight: 520, idealHeight: 520, maxHeight: 520)
                .padding(12)
        }
        .menuBarExtraStyle(.window)
    }
}
