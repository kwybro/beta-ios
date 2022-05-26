//
//  CurrentWeatherViewModel.swift
//  weather
//
//  Created by Kyle Wybranowski on 5/26/22.
//

import Combine
import SwiftUI

protocol WeatherViewModelProtocol: ObservableObject {
    var viewState: WeatherViewState { get }
    var currentWeatherUnits: [WeatherUnit] { get }
    var currentWeatherWidgets: [WeatherWidget] { get }

    func getWeather()
}

enum WeatherViewState {
    case ready
    case loading
    case failed
    case initial
}

final class WeatherViewModel: WeatherViewModelProtocol {
    private let apiClient: APIClient

    private var cancellables: Set<AnyCancellable> = []

    @Published private(set) var viewState: WeatherViewState = .initial
    @Published var currentWeatherUnits: [WeatherUnit] = []
    @Published var currentWeatherWidgets: [WeatherWidget] = []

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func getWeather() {
        guard viewState != .loading else { return }
        viewState = .loading
        invokeGetCurrentWeather()
            .sink { value in
                if case let .failure(error) = value {
                    self.viewState = .failed
                    print(error)
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.viewState = .ready
                self.buildWeatherViewData(from: response)
            }
            .store(in: &cancellables)
    }

    private func invokeGetCurrentWeather() -> AnyPublisher<WeatherResponse, Error> {
        Future() { [weak self] promise in
            guard let self = self else { return }
            self.apiClient.getWeather(zipcode: 05404) { promise($0) }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }

    private func buildWeatherViewData(from response: WeatherResponse) {
        guard let precipitation = response.current?.precipitation,
              let humidity = response.current?.humidity,
              let uvIndex = response.current?.uvIndex,
              let windSpeed = response.current?.windSpeed,
              let visibility = response.current?.visibility,
              let pressure = response.current?.pressure else {
                  print("Missing Data")
                  viewState = .failed
                  return
              }
        currentWeatherWidgets = [
            WeatherWidget(type: .precipitation, value: Constants.precipitationUnits(precipitation)),
            WeatherWidget(type: .humidity, value: Constants.humidityUnits(humidity)),
            WeatherWidget(type: .uvIndex, value: "\(uvIndex)"),
            WeatherWidget(type: .windSpeed, value: Constants.windSpeedUnits(windSpeed)),
            WeatherWidget(type: .visibility, value: Constants.visibilityUnits(visibility)),
            WeatherWidget(type: .pressure, value: Constants.pressureUnits(pressure))
        ]

        guard let today = response.forecast?.forecastDays?.first,
              let hours = today.hours else { return }
        let weatherUnits: [WeatherUnit] = hours.map { hour in
            guard let epochTime = hour.time,
                  Helpers.isTimeValid(epochTime),
                  let temperature = hour.temperature,
                  let condition = hour.condition?.text,
                  let weatherType = WeatherUnit.WeatherType(for: condition) else { return nil }
            let time = Helpers.epochToHour(epochTime)
            return WeatherUnit(type: weatherType,
                               temperature: temperature,
                               time: time)
        }.compactMap { $0 }

        currentWeatherUnits = weatherUnits
    }
}
