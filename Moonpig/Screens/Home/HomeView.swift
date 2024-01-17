//
//  ContentView.swift
//  Moonpig
//
//  Created by Abin Baby on 16.01.24.
//

import SDWebImageSwiftUI
import SwiftUI

struct HomeView: View {

    @ObservedObject var viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    private let columns: [GridItem] = Array(
        repeating: .init(.flexible()),
        count: 3
    )

    var body: some View {
        ZStack {
            switch viewModel.state {
            case .loading:
                // Use better loading view if needed
                Text("Loading...")
            case .data(let products):
                dataContentView(products: products)
            case .error:
                // TODO: add custom error types and pass error message according to error
                ErrorPopupView(
                    title: "Error Occurred",
                    subtitle: "Something went wrong. Please try again.",
                    retryAction: {
                        viewModel.didTapRetry.send(())
                    }
                )
            default:
                VStack {}
            }
        }
        .navigationTitle("Moonpig")
        .navigationBarBackButtonHidden(true)
    }
}

private extension HomeView {
    func dataContentView(products: [ProductViewModel]) -> some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(products) { product in
                    WebImage(
                        url: URL(
                            string: product.imageURL
                        )
                    )
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .scaledToFit()
                    .cornerRadius(10)
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    HomeView(
        viewModel: HomeViewModel(
            fetchHomeProductListUseCase: PreviewHomeProductListUseCase()
        )
    )
}
