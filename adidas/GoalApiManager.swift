//
// Created by Denys Meloshyn on 27/09/2019.
// Copyright (c) 2019 Denys Meloshyn. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import HTTPNetworking

enum ApiError: Error {
    case notValidUrl
    case responseNotValid
}

class GoalsApiManager {
    enum Constants {
        static let path = "https://thebigachallenge.appspot.com/_ah/api/myApi/v1/goals"
    }

    let httpClient: HTTPProtocol

    init(httpClient: HTTPProtocol) {
        self.httpClient = httpClient
    }

    func loadGoals() -> Single<[GoalEntity]> {
        Single.create { event in
            guard let url = URL(string: Constants.path) else {
                event(.error(ApiError.notValidUrl))
                return Disposables.create()
            }

            var request = URLRequest(url: url)
            request.method = .GET

            let task = self.httpClient.load(request) { data, response, error in
                if let error = error {
                    event(.error(error))
                    return
                }

                guard let data = data else {
                    event(.error(ApiError.responseNotValid))
                    return
                }

                do {
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
