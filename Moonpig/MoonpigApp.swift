//
//  MoonpigApp.swift
//  Moonpig
//
//  Created by Abin Baby on 16.01.24.
//

import SwiftUI

@main
struct MoonpigApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: HomeViewModel())
        }
    }
}
