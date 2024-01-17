//
//  DependencyManager.swift
//  Moonpig
//
//  Created by Abin Baby on 17.01.24.
//

import Foundation
import Swinject
import SwiftUI

// MARK: - DependencyManager

final class DependencyManager {
    static func registerServices() {
        Container.shared.register(AppCoordinator.self) { resolver, path in
            AppCoordinator(
                resolver: resolver,
                path: path
            )
        }

        Container.shared.register(HomeViewModel.self) { resolver in
            let fetchHomeProductListUseCase = resolver.resolve(HomeProductListFetchable.self)!

            return HomeViewModel(
                fetchHomeProductListUseCase: fetchHomeProductListUseCase
            )
        }

        Container.shared.register(ProductFetchable.self) { _ in
            ProductService(httpClient: HTTPClient())
        }

        Container.shared.register(HomeProductListFetchable.self) { resolver in
            FetchHomeProductListUseCase(
                productService: resolver.resolve(ProductFetchable.self)!
            )
        }
    }
}

extension Container {
    // MARK: - Properties

    static let shared = Container()

    static var homeViewModel: HomeViewModel {
        shared.resolve(HomeViewModel.self)!
    }

    static var appCoordinator: AppCoordinator {
        shared.resolve(
            AppCoordinator.self,
            argument: NavigationPath()
        )!
    }
}
