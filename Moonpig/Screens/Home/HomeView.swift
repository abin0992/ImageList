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
        NavigationView {
            ZStack {
                switch viewModel.state {
                case .loading:
                    // add view
                    Text("Loading")
                case .data(let products):
                    dataContentView(products: products)
                case .error:
                    // add view
                    Text("Error")
                default:
                    VStack {}
                }
            }
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
    }
}

private extension HomeView {
    func dataContentView(products: [ProductViewModel]) -> some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(products) { product in
                        WebImage(
                            url: URL(
                                string: product.imageURL
                            )
                        )
                        .resizable()
                        .indicator(.activity) // Activity indicator while loading
                        .transition(.fade(duration: 0.5)) // Fade Transition with duration
                        .scaledToFit()
                        .cornerRadius(10)
                    }
                }
                .padding(.horizontal, 16)
            }
            .navigationTitle("Moonpig")
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
