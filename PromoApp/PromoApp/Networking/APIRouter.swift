//
//  APIRouters.swift
//  PromoApp
//
//  Created by Roli Bernanda on 26/01/24.
//

import Foundation

class APIRouter {
    
    // GET Request
    struct GetPromos: Request {
        typealias ReturnType = Promos
        var path: String = "/promos"
        var method: HTTPMethod = .get
        var headers: [String : String] = [
            HTTPHeaderField.authorization.rawValue: "Bearer \(APIConstants.token)"
        ]
    }
}
