//
//  HomeProtocols.swift
//  PortofolioChart
//
//  Created by Roli Bernanda on 27/01/24.
//

import Foundation

protocol HomeInteractorProtocol {
    func getPortofolio()
}

protocol HomeRepositoryProtocol {
    func getPortofolio() -> [PortofolioData]
}

protocol HomeInteractorDelegate: AnyObject {
    func didFinish()
}
