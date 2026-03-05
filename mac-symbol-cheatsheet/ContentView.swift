import SwiftUI
import AppKit
import ServiceManagement

struct ContentView: View {

    // Search
    @State private var query: String = ""

    // Preferences
    @State private var showSettings = false
    @State private var launchAtLogin = (SMAppService.mainApp.status == .enabled)
    @State private var settingsError: String?
    
    // Favorites persistence
    @AppStorage("favoritesData") private var favoritesData: Data = Data()

    // Your data
    let symbols: [SymbolItem] = [

        SymbolItem(symbol: "@", macShortcut: "⌥L", keys: "Option + L",
                   searchTerms: ["at", "at sign", "atzeichen"]),

        SymbolItem(symbol: "€", macShortcut: "⌥E", keys: "Option + E",
                   searchTerms: ["euro", "eur", "currency"]),

        SymbolItem(symbol: "$", macShortcut: "⇧4", keys: "Shift + 4",
                   searchTerms: ["dollar", "usd"]),

        SymbolItem(symbol: "£", macShortcut: "⌥⇧4", keys: "Option + Shift + 4",
                   searchTerms: ["pound", "gbp"]),

        SymbolItem(symbol: "©", macShortcut: "⌥G", keys: "Option + G",
                   searchTerms: ["copyright", "c", "legal"]),

        SymbolItem(symbol: "®", macShortcut: "⌥R", keys: "Option + R",
                   searchTerms: ["registered", "registered trademark"]),

        SymbolItem(symbol: "™", macShortcut: "⌥⇧D", keys: "Option + Shift + D",
                   searchTerms: ["trademark", "tm"]),

        SymbolItem(symbol: "§", macShortcut: "⇧3", keys: "Shift + 3",
                   searchTerms: ["section", "paragraph", "paragraph sign", "paragraf", "paragraphzeichen"]),

        SymbolItem(symbol: "~", macShortcut: "⌥N ␠", keys: "Option + N, then Space",
                   searchTerms: ["tilde", "approx", "wave", "tild", "tildezeichen"]),

        SymbolItem(symbol: "(", macShortcut: "⇧8", keys: "Shift + 8",
                   searchTerms: ["parenthesis", "paren", "parenthesis open", "runde klammer auf"]),

        SymbolItem(symbol: ")", macShortcut: "⇧9", keys: "Shift + 9",
                   searchTerms: ["parenthesis", "paren", "parenthesis close", "runde klammer zu"]),

        SymbolItem(symbol: "[", macShortcut: "⌥5", keys: "Option + 5",
                   searchTerms: ["bracket", "square bracket", "square bracket open", "eckige klammer auf", "eckig auf"]),

        SymbolItem(symbol: "]", macShortcut: "⌥6", keys: "Option + 6",
                   searchTerms: ["bracket", "square bracket", "square bracket close", "eckige klammer zu", "eckig zu"]),

        SymbolItem(symbol: "{", macShortcut: "⌥8", keys: "Option + 8",
                   searchTerms: ["brace", "braces", "curly brace", "curly bracket", "brace open",
                                "geschweifte klammer auf", "geschweift auf", "geschweifte"]),

        SymbolItem(symbol: "}", macShortcut: "⌥9", keys: "Option + 9",
                   searchTerms: ["brace", "braces", "curly brace", "curly bracket", "brace close",
                                "geschweifte klammer zu", "geschweift zu", "geschweifte"]),

        SymbolItem(symbol: "/", macShortcut: "⇧7", keys: "Shift + 7",
                   searchTerms: ["slash", "forward slash", "division slash"]),

        SymbolItem(symbol: "\\", macShortcut: "⌥⇧7", keys: "Option + Shift + 7",
                   searchTerms: ["backslash", "escape", "windows path"]),

        SymbolItem(symbol: "|", macShortcut: "⌥7", keys: "Option + 7",
                   searchTerms: ["pipe", "vertical bar", "or", "oder", "pipeline"]),

        SymbolItem(symbol: "<", macShortcut: "<", keys: "< key",
                   searchTerms: ["less", "smaller than", "kleiner als", "less than"]),

        SymbolItem(symbol: ">", macShortcut: "⇧<", keys: "Shift + <",
                   searchTerms: ["greater", "bigger than", "größer als", "groesser als", "greater than"]),

        SymbolItem(symbol: "≤", macShortcut: "⌥<", keys: "Option + <",
                   searchTerms: ["less equal", "less or equal", "kleiner gleich", "kleiner=gleich", "leq"]),

        SymbolItem(symbol: "≥", macShortcut: "⌥⇧<", keys: "Option + Shift + <",
                   searchTerms: ["greater equal", "greater or equal", "größer gleich", "groesser gleich", "geq"]),

        SymbolItem(symbol: "≠", macShortcut: "⌥0", keys: "Option + 0",
                   searchTerms: ["not equal", "unequal", "ungleich", "neq"]),

        SymbolItem(symbol: "≈", macShortcut: "⌥X", keys: "Option + X",
                   searchTerms: ["approx", "approximately", "ungefähr", "ungefaehr", "almost equal"]),

        SymbolItem(symbol: "±", macShortcut: "⌥+", keys: "Option + +",
                   searchTerms: ["plus minus", "plusminus", "±", "plus/minus"]),

        SymbolItem(symbol: "π", macShortcut: "⌥P", keys: "Option + P",
                   searchTerms: ["pi", "math", "kreiszahl"]),

        SymbolItem(symbol: "∞", macShortcut: "⌥,", keys: "Option + ,",
                   searchTerms: ["infinity", "unendlich", "inf"]),

        SymbolItem(symbol: "√", macShortcut: "⌥V", keys: "Option + V",
                   searchTerms: ["root", "square root", "wurzel"]),

        SymbolItem(symbol: "•", macShortcut: "⌥8", keys: "Option + 8",
                   searchTerms: ["bullet", "dot", "punkt", "list"]),

        SymbolItem(symbol: "…", macShortcut: "⌥.", keys: "Option + .",
                   searchTerms: ["ellipsis", "three dots", "auslassungspunkte", "punkte"]),

        // Add question mark (super common)
        SymbolItem(symbol: "?", macShortcut: "⇧-", keys: "Shift + -",
                   searchTerms: ["question", "question mark", "questionmark", "fragezeichen", "frage zeichen"])
    ]

    // MARK: - Derived data

    private var favorites: Set<String> {
        get { decodeFavorites(from: favoritesData) }
        set { favoritesData = encodeFavorites(newValue) }
    }

    private func isFavorite(_ item: SymbolItem) -> Bool {
        favorites.contains(item.key)
    }

    private func toggleFavorite(_ item: SymbolItem) {
        var set = decodeFavorites(from: favoritesData)

        if set.contains(item.key) {
            set.remove(item.key)
        } else {
            set.insert(item.key)
        }

        favoritesData = encodeFavorites(set)
    }

    private var filteredAndSorted: [SymbolItem] {
        let q = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

        let filtered = symbols.filter { item in
            if q.isEmpty { return true }

            // Search in symbol, shortcuts, keys, and hidden search terms
            if item.symbol.lowercased().contains(q) { return true }
            if item.macShortcut.lowercased().contains(q) { return true }
            if item.keys.lowercased().contains(q) { return true }

            return item.searchTerms.contains { $0.lowercased().contains(q) }
        }

        // Favorites first, then stable order
        return filtered.sorted { a, b in
            let af = isFavorite(a)
            let bf = isFavorite(b)
            if af != bf { return af && !bf }
            return a.symbol < b.symbol
        }
    }

    // MARK: - UI

    var body: some View {
        VStack(spacing: 10) {
            
            HStack {
                Button {
                    showSettings.toggle()
                } label: {
                    Image(systemName: "gearshape")
                }
                .buttonStyle(.borderless)
                .help("Settings")

                Spacer()

                Button("Quit") {
                    NSApp.terminate(nil)
                }
                .buttonStyle(.borderless)
            }
            
            if showSettings {
                VStack(alignment: .leading, spacing: 8) {
                    Toggle("Launch at login", isOn: $launchAtLogin)
                        .onChange(of: launchAtLogin) { _, newValue in
                            setLaunchAtLogin(newValue)
                        }

                    if let settingsError {
                        Text(settingsError)
                            .font(.caption)
                            .foregroundStyle(.red)
                    }
                }
                .padding(10)
                .background(.quaternary)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }

            // Search field
            TextField("Search (e.g. brace, fragezeichen, pipe, kleiner gleich)...", text: $query)
                .textFieldStyle(.roundedBorder)

            // Header row
            HStack(spacing: 10) {
                Text("Symbol").frame(width: 36, alignment: .center)
                Text("Mac").frame(width: 80, alignment: .leading)
                Text("Keys").frame(maxWidth: .infinity, alignment: .leading)
                Spacer(minLength: 0)
                Text("★").frame(width: 28, alignment: .center)
                Text("").frame(width: 60) // Copy button space
            }
            .font(.caption)
            .foregroundStyle(.secondary)
            .padding(.horizontal, 8)

            // Table-like list
            List(filteredAndSorted) { item in
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

                    Button {
                        toggleFavorite(item)
                    } label: {
                        Image(systemName: isFavorite(item) ? "star.fill" : "star")
                    }
                    .buttonStyle(.borderless)
                    .help(isFavorite(item) ? "Unfavorite" : "Favorite")
                    .frame(width: 28, alignment: .center)

                    Button("Copy") {
                        copyToClipboard(item.symbol)
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.vertical, 4)
            }
        }
        .frame(minWidth: 420, minHeight: 520)
        .padding(10)
    }

    // MARK: - Clipboard

    private func copyToClipboard(_ text: String) {
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(text, forType: .string)
    }

    // MARK: - Favorites encoding

    private func encodeFavorites(_ set: Set<String>) -> Data {
        (try? JSONEncoder().encode(Array(set))) ?? Data()
    }
    
    // MARK:- LaunchAtLogin
    
    private func setLaunchAtLogin(_ enabled: Bool) {
        do {
            if enabled {
                try SMAppService.mainApp.register()
            } else {
                try SMAppService.mainApp.unregister()
            }
            settingsError = nil
        } catch {
            // UI zurückrollen, falls es scheitert
            launchAtLogin = (SMAppService.mainApp.status == .enabled)
            settingsError = error.localizedDescription
        }
    }

    private func decodeFavorites(from data: Data) -> Set<String> {
        guard let arr = try? JSONDecoder().decode([String].self, from: data) else { return [] }
        return Set(arr)
    }
}
