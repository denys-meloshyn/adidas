//
// Created by Denys Meloshyn on 27/09/2019.
// Copyright (c) 2019 Denys Meloshyn. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import HTTPNetworking

enum Const {
    enum InternalError: Error {
        case notValidUrl
        case responseNotValid
        case healthKit
    }
}

protocol GoalsApiManagerProtocol {
    func loadGoals() -> Single<[GoalEntity]>
}

class GoalsApiManager: GoalsApiManagerProtocol {
    enum Constants {
        static let path = "https://thebigachallenge.appspot.com/_ah/api/myApi/v1/goals"
    }

    private let httpClient: HTTPProtocol

    init(httpClient: HTTPProtocol) {
        self.httpClient = httpClient
    }

    func loadGoals() -> Single<[GoalEntity]> {
        Single.create { event in
            guard let url = URL(string: Constants.path) else {
                event(.error(Const.InternalError.notValidUrl))
                return Disposables.create()
            }

            var request = URLRequest(url: url)
            request.method = .GET

            let task = self.httpClient.loadJSON(request) { json, response, error in
                if let error = error {
                    event(.error(error))
                    return
                }

                guard let items = (json as? [String: Any])?["items"] as? [[String: Any]] else {
                    event(.error(Const.InternalError.responseNotValid))
                    return
                }

                do {
                    let data = try JSONSerialization.data(withJSONObject: items, options: .prettyPrinted)
                    let decoded = try JSONDecoder().decode([GoalEntity].self, from: data)
                    event(.success(decoded))
                } catch {
                    event(.error(error))
                }
            }

            return Disposables.create {
                task.cancel()
            }
        }
    }
}
