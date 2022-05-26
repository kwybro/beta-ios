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
}

enum WeatherViewState {
    case success
    case loading
    case failed
    case initial
}


protocol WeatherDependency {
    // [KW] Uncomment when ready for APIClient
//    var apiClient: APIClient { get }
}

struct WeatherWidget: Identifiable, Hashable {
    var id: String {
        type.title
    }

    enum WidgetType: String {
        case precipitation, humidity, uvIndex, windSpeed, visibility, pressure

        var imageName: String {
            switch self {
            case .precipitation: return Constants.pressureImageName
            case .humidity: return Constants.humidityImageName
            case .uvIndex: return Constants.uvIndexImageName
            case .windSpeed: return Constants.windSpeedImageName
            case .visibility: return Constants.visibilityImageName
            case .pressure: return Constants.pressureImageName
            }
        }

        var title: String {
            switch self {
            case .precipitation: return Constants.precipitation
            case .humidity: return Constants.humidity
            case .uvIndex: return Constants.uvIndex
            case .windSpeed: return Constants.windSpeed
            case .visibility: return Constants.visibility
            case .pressure: return Constants.pressure
            }
        }
    }

    let type: WidgetType
    let value: String
}

struct WeatherUnit: Identifiable {
    var id: String {
        time
    }

    enum WeatherType: String {
        case sun, rain, cloudy

        var imageName: String {
            switch self {
            case .sun: return Constants.sunImageName
            case .rain: return Constants.rainImageName
            case .cloudy: return Constants.cloudyImageName
            }
        }
    }

    let type: WeatherType
    let temperature: Int
    let time: String
}

final class WeatherViewModel: WeatherViewModelProtocol {
    // [KW] Uncomment when ready for APIClient
//    private let dependency: CurrentWeatherDependency

    @Published private(set) var viewState: WeatherViewState = .initial
    // [KW] Source from APIClient
    @Published var currentWeatherUnits: [WeatherUnit] = [
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

    // [KW] Source from APIClient
    @Published var currentWeatherWidgets: [WeatherWidget] = [
        WeatherWidget(type: .precipitation, value: "1 in."),
        WeatherWidget(type: .humidity, value: "60%"),
        WeatherWidget(type: .uvIndex, value: "6.0"),
        WeatherWidget(type: .windSpeed, value: "15 mph"),
        WeatherWidget(type: .visibility, value: "9 mi."),
        WeatherWidget(type: .pressure, value: "30.00 inHg")
    ]

    init() {}

    // [KW] Uncomment when ready for APIClient
//    init(dependency: CurrentWeatherDependency) {
//        self.dependency = dependency
//    }
}
