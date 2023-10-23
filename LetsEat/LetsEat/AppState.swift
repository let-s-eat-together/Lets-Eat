//
//  AppState.swift
//  LetsEat

import SwiftUI

// return to root
class AppState: ObservableObject {
    @Published var rootViewId = UUID()
}
