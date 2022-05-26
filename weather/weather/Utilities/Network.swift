//
//  Network.swift
//  weather
//
//  Created by Kyle Wybranowski on 5/26/22.
//

import Foundation
import SwiftUI

protocol Network {
    func executeRequest(_ request: URLRequest,
                        completion: @escaping (Result<Data, Error>) -> Void)
}

final class NetworkImp: Network {

    enum NetworkError: Error {
        case unknown
    }

    let urlSession: URLSession = .shared

    init() {}

    func executeRequest(_ request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        urlSession.dataTask(with: request) { data, response, error in
            if let data = data {
                completion(.success(data))
            } else if let error = error {
                completion(.failure(error))
            } else if let response = (response as? HTTPURLResponse), response.statusCode != 200 {
                completion(.failure(URLError(.badServerResponse)))
            } else {
                completion(.failure(NetworkError.unknown))
            }
        }.resume()
    }
}
