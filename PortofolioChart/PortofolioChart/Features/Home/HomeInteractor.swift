//
//  HomeInteractor.swift
//  PortofolioChart
//
//  Created by Roli Bernanda on 27/01/24.
//

import Foundation

class HomeInteractor: HomeInteractorProtocol {
    private let repository: HomeRepositoryProtocol
    private(set) var portofolio: [PortofolioData] = .init()
    
    weak var delegate: HomeInteractorDelegate?
    
    init(repository: HomeRepositoryProtocol) {
        self.repository = repository
    }
    
    func getPortofolio() {
        self.portofolio = self.repository.getPortofolio()
        self.delegate?.didFinish()
    }
}
