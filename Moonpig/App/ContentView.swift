//
//  ContentView.swift
//  Moonpig
//
//  Created by Abin Baby on 17.01.24.
//

import SwiftUI
import Swinject

struct ContentView: View {
    @StateObject private var appCoordinator = Container.appCoordinator

    var body: some View {
        NavigationStack(path: $appCoordinator.path) {
            appCoordinator.start()
        }
        .environmentObject(appCoordinator)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
