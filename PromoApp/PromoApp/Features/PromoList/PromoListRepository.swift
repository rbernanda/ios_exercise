//
//  PromoListRepository.swift
//  PromoApp
//
//  Created by Roli Bernanda on 26/01/24.
//

import Foundation
import Combine

class PromoListRepository: PPromoListRepository {
    private var cancelable: Set<AnyCancellable> = []
    
    func getPromos(completion: @escaping (Result<Promos, Error>) -> Void) {
        APIClient.dispatch(APIRouter.GetPromos())
            .sink(receiveCompletion: { res in
                switch res {
                case .finished:
                    break
                case .failure(let error):
                    completion(.failure(error))
                }
            }, receiveValue: { promoResponse in
                completion(.success(promoResponse))
            })
            .store(in: &cancelable)
    }
}
