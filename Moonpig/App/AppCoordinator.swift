//
//  AppCoordinator.swift
//  Moonpig
//
//  Created by Abin Baby on 16.01.24.
//

//import Combine
//import SwiftUI
//import Swinject
//
//final class AppCoordinator: ObservableObject {
//
//    private let resolver: Resolver
//    var path: NavigationPath
//    private var cancellables = Set<AnyCancellable>()
//
//    init(
//        resolver: Resolver,
//        path: NavigationPath
//    ) {
//        self.resolver = resolver
//        self.path = path
//    }
//
//    @ViewBuilder
//    func start() -> some View {
//        homeView()
//    }
//
//    private func push<T: Hashable>(_ coordinator: T) {
//        path.append(coordinator)
//    }
//
//}
//
//private extension AppCoordinator {
//
//    func searchView() -> some View {
//        guard let viewModel = resolver.resolve(SearchUserViewModel.self) else {
//            return AnyView(EmptyView())
//        }
//        return AnyView(SearchUserView(viewModel: viewModel))
//    }
//}

