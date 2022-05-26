//
//  CurrentWeatherViewModel.swift
//  weather
//
//  Created by Kyle Wybranowski on 5/26/22.
//

import Combine
import SwiftUI

protocol CurrentWeatherViewModelProtocol: ObservableObject {
    var viewState: CurrentWeatherViewState { get }
    var loadedWeatherUnits: [WeatherUnit] { get }
}

enum CurrentWeatherViewState {
    case success
    case loading
    case failed
    case initial
}


protocol CurrentWeatherDependency {
    // [KW] Uncomment when ready for APIClient
//    var apiClient: APIClient { get }
}

struct WeatherUnit: Identifiable {
    var id: String {
        time
    }

    enum WeatherType: String {
        case sun, rain, cloudy

        var imageName: String {
            switch self {
            case .sun: return "sun.max.fill"
            case .rain: return "cloud.rain.fill"
            case .cloudy: return "cloud.fill"
            }
        }
    }

    let type: WeatherType
    let temperature: Int
    let time: String
}

final class CurrentWeatherViewModel: CurrentWeatherViewModelProtocol {
    // [KW] Uncomment when ready for APIClient
//    private let dependency: CurrentWeatherDependency

    @Published private(set) var viewState: CurrentWeatherViewState = .initial
    // [KW] Source from APIClient
    @Published var loadedWeatherUnits: [WeatherUnit] = [
        WeatherUnit(type: .rain,
                    temperature: 58,
                    time: "NOW"),
        WeatherUnit(type: .rain,
                    temperature: 58,
                    time: "2PM"),
        WeatherUnit(type: .rain,
                    temperature: 59,
                    time: "3PM"),
        WeatherUnit(type: .rain,
                    temperature: 60,
                    time: "4PM"),
        WeatherUnit(type: .rain,
                    temperature: 61,
                    time: "5PM"),
        WeatherUnit(type: .rain,
                    temperature: 60,
                    time: "6PM"),
        WeatherUnit(type: .cloudy,
                    temperature: 62,
                    time: "7PM"),
        WeatherUnit(type: .sun,
                    temperature: 66,
                    time: "8PM"),
        WeatherUnit(type: .sun,
                    temperature: 65,
                    time: "9PM"),
        WeatherUnit(type: .cloudy,
                    temperature: 64,
                    time: "10PM")
    ]

    init() {}

    // [KW] Uncomment when ready for APIClient
//    init(dependency: CurrentWeatherDependency) {
//        self.dependency = dependency
//    }
}
