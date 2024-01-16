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

    
}
