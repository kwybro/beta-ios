//
//  APIClient.swift
//  weather
//
//  Created by Kyle Wybranowski on 5/26/22.
//

import Foundation

internal protocol APIClient {
    func getWeather(
        latitude: Double,
        longitude: Double,
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
        latitude: Double,
        longitude: Double,
        completion: @escaping (Result<WeatherResponse, Swift.Error>) -> Void) {
            do {
                let latlong = "\(latitude),\(longitude)"
                let request = try makeRequest(path: "forecast.json",
                                              parameters: [.init(name: "q", value: latlong),
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
        // :(
        let apiKey = (Bundle.main.infoDictionary?["API_KEY"] as! String)
            .trimmingCharacters(in: .init(charactersIn: "\""))
            .trimmingCharacters(in: .init(charactersIn: "\\"))
        let key = URLQueryItem(name: "key", value: apiKey)
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = baseURL
        urlComponents.path = "/v1/\(path)"
        urlComponents.queryItems = [key] + parameters

        guard let url = urlComponents.url else {
            throw(Error.invalidURL)
        }

        let request = URLRequest(url: url)
        return request
    }
}
