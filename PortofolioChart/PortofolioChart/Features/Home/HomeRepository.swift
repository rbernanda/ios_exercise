//
//  HomeRepository.swift
//  PortofolioChart
//
//  Created by Roli Bernanda on 27/01/24.
//

import Foundation

class HomeRepository: HomeRepositoryProtocol {
    private let client: DataStore
    
    init() {
        self.client = DataStore.shared
    }
    
    func getPortofolio() -> [PortofolioData] {
        return client.getPortofolio()
    }
}
