//
//  PromoListViewModel.swift
//  PromoApp
//
//  Created by Roli Bernanda on 26/01/24.
//

import Foundation

class PromoListInteractor: PPromoListInteractor {
    private(set) var promos: [SinglePromo] = .init()
    let repository: PPromoListRepository
    
    weak var delegate: PPromoListInteractorDelegate?
    
    init(repository: PPromoListRepository) {
        self.repository = repository
    }
    
    func getPromos() {
        self.repository.getPromos { result in
            switch result {
            case .success(let promoResponse):
                self.promos = promoResponse.promos
                self.delegate?.didFinish()
            case .failure(let error):
                print("ERROR Fetching Promos List", error.localizedDescription)
                self.delegate?.didFail(error: error)
            }
        }
    }
}
