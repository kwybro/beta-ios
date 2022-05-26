//
//  APIClient.swift
//  weather
//
//  Created by Kyle Wybranowski on 5/26/22.
//

import Foundation

internal protocol APIClient {
    func getWeather(
        zipcode: Int,
        completion: @escaping (Result<WeatherResponse, Swift.Error>) -> Void
    )
}


final class APIClientImp: APIClient {
    enum Error: Swift.Error {
        case invalidURL
        case missingSelf
        case apiError(String)
    }

    private let network: Network

    init(network: Network) {
        self.network = network
    }

    func getWeather(
        zipcode: Int,
        completion: @escaping (Result<WeatherResponse, Swift.Error>) -> Void) {
            do {
                let request = try makeRequest(path: "forecast.json",
                                              parameters: [.init(name: "q", value: "05404"),
                                                           .init(name: "days", value: "1")],
                                              method: .get)
                network.executeRequest(request) { result in
                    switch result {
                    case let .success(data):
                        if let response = try? JSONDecoder().decode(
                            WeatherResponse.self,
                            from: data
                        ) {
                            completion(.success(response))
                            return
                        } else {
                            completion(.failure(Error.apiError("Could not decode response")))
                            return
                        }
                        // [KW] More error handling
                    case let .failure(error):
                        completion(.failure(error))
                        return
                    }
                }
        } catch {
            completion(.failure(error))
        }
    }

    private func makeRequest(path: String,
                             parameters: [URLQueryItem],
                             method: HTTPMethod) throws -> URLRequest {
        let baseURL = Constants.baseWeatherURL
        let apiKey = URLQueryItem(name: "key", value: "0aa8647988eb44fcbec173942222605")
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = baseURL
        urlComponents.path = "/v1/\(path)"
        urlComponents.queryItems = parameters + [apiKey]

        guard let url = urlComponents.url else {
            throw(Error.invalidURL)
        }

        let request = URLRequest(url: url)
        return request
    }
}