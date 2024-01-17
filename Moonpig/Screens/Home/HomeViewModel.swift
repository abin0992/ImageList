//
//  HomeViewModel.swift
//  Moonpig
//
//  Created by Abin Baby on 16.01.24.
//

import Combine
import Foundation

class HomeViewModel: ObservableObject {

    @Published var state = StateModel<[ProductViewModel]>.State.loading

    private lazy var fetchProductListResult = makeInitialProductFetchResult().share()

    private let fetchHomeProductListUseCase: HomeProductListFetchable

    init(
        fetchHomeProductListUseCase: HomeProductListFetchable
    ) {
        self.fetchHomeProductListUseCase = fetchHomeProductListUseCase
        bindState()
    }
}

private extension HomeViewModel {

    func bindState() {

        fetchProductListResult
            .receive(on: DispatchQueue.main)
            .map { result -> StateModel<[ProductViewModel]>.State in
                switch result {
                case .error:
                    return .error(ClientError.generic)
                case .success(let products):
                    return .data(products)
                }
            }
            .assign(to: &$state)
    }

    func makeInitialProductFetchResult() -> AnyPublisher<DomainResult<[ProductViewModel]>, Never> {
        fetchHomeProductListUseCase.execute()
    }
}
