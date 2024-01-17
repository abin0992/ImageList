//
//  MoonpigApp.swift
//  Moonpig
//
//  Created by Abin Baby on 16.01.24.
//

import SwiftUI
import Swinject

@main
struct MoonpigApp: App {
    init() {
        DependencyManager.registerServices()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
