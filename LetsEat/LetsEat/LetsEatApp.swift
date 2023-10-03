//
//  LetsEatApp.swift
//  LetsEat

import SwiftUI

@main
struct LetsEatApp: App {
    @AppStorage("isDarkModeOn") private var isDarkModeOn = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(isDarkModeOn ? .dark : .light)
        }
    }
}
