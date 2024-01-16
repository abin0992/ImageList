//
//  CardLoader.swift
//  Moonpig
//
//  Created by Abin Baby on 16.01.24.
//

import Foundation

class CardLoader: ObservableObject {
    @Published var products = [Product]()
    
    init() {
        load()
    }
    
    func load() {
        guard let url = URL(string: "https://moonpig.github.io/tech-test-frontend/search.json") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([Product].self, from: data) {
                    DispatchQueue.main.async {
                        self.products = decodedResponse
                    }
                }
            }
        }.resume()
    }
}
