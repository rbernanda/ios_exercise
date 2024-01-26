//
//  PromoListProtocols.swift
//  PromoApp
//
//  Created by Roli Bernanda on 26/01/24.
//

import Foundation

protocol PPromoListInteractor {
    func getPromos()
}

protocol PPromoListRepository {
    func getPromos(completion: @escaping (Result<Promos, Error>) -> Void)
}

// MARK: Interactor -> Presenter
protocol PPromoListInteractorDelegate: AnyObject {
    func didFinish()
    func didFail(error: Error)
}
