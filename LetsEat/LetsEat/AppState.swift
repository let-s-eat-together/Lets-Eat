//
//  AppState.swift
//  LetsEat
//
//  Created by 이현재 on 2023/09/11.
//

import SwiftUI

// return to root
class AppState: ObservableObject {
    @Published var rootViewId = UUID()
}
