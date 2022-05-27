//
//  CurrentWeatherViewModel.swift
//  weather
//
//  Created by Kyle Wybranowski on 5/26/22.
//

import CoreLocation
import Combine
import SwiftUI

protocol WeatherViewModelProtocol: ObservableObject {
    var viewState: WeatherViewState { get }
    var currentWeatherUnits: [WeatherUnit] { get }
    var currentWeatherWidgets: [WeatherWidget] { get }
    var locationStatus: CLAuthorizationStatus { get }
    var cityAndState: String { get }
    var lastUpdatedDate: String { get }

    func getWeather()
}

enum WeatherViewState {
    case ready
    case loading
    case failed
    case initial
    case failedNoLocation
}

final class WeatherViewModel: NSObject, WeatherViewModelProtocol {
    private let apiClient: APIClient
    private var cancellables: Set<AnyCancellable> = []
    private var locationManager: CLLocationManager = .init()
    private var geocoder: CLGeocoder = .init()

    @AppStorage("cityAndState") var cityAndState: String = ""
    @AppStorage("lastUpdatedDate") var lastUpdatedDate: String = ""
    @Published var locationStatus: CLAuthorizationStatus = .notDetermined
    @Published private(set) var viewState: WeatherViewState = .initial
    @AppStorage("currentWeatherUnits") var currentWeatherUnits: [WeatherUnit] = []
    @AppStorage("currentWeatherWidgets") var currentWeatherWidgets: [WeatherWidget] = []

    private var latitude: Double = 0.0
    private var longitude: Double = 0.0

    init(apiClient: APIClient) {
        self.apiClient = apiClient
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
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
            self.apiClient.getWeather(latitude: self.latitude,
                                      longitude: self.longitude) { promise($0) }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }

    private func buildWeatherViewData(from response: WeatherResponse) {
        guard let localTime = response.location?.localTime,
              let precipitation = response.current?.precipitation,
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

        lastUpdatedDate = Helpers.epochToDate(localTime)
    }
}

extension WeatherViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus = status
        if status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location else {
                  viewState = .failedNoLocation
                  return
        }
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
        getWeather()

        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) -> Void in
            if error == nil {
                guard let self = self,
                      let placemarks = placemarks,
                      let firstPlacemark = placemarks.first,
                      let city = firstPlacemark.locality,
                      let state = firstPlacemark.administrativeArea else {
                          return
                      }
                self.cityAndState = "\(city), \(state)"
            }
        }
    }
}
