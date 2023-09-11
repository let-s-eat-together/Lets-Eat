//
//  LetsEatApp.swift
//  LetsEat
//
//  Created by 이현재 on 2023/08/28.
//

import SwiftUI

@main
struct LetsEatApp: App {
    @ObservedObject var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .id(appState.rootViewId)
                .environmentObject(appState)
//                .onOpenURL { url in
//                    guard let scheme = url.scheme, scheme = "navStack" else { return }
//                    guard let country = url.host else { return }
//                    if let foundCountry = Country.sample.first(where: {$0.name == countr}) {
//                        router.rest()
//                        router.path.append(foundcountry)
//                        if url.pathCompontes.count == 2 {
//                            let city = url.lastPathComponent
//                            if let foundCity = foundCountry.cities.first(where: {$0.name == city}) {
//                                router.path.append(foundcity)
//                            }
//
//                        }
//                    }
//                    print(url.scheme)
//                    print(url.host)
//                    print(url.lastPathComponent)
//                }
        }
    }
}
