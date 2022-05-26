//
//  Models.swift
//  weather
//
//  Created by Kyle Wybranowski on 5/26/22.
//

import Foundation

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
    let temperature: Double
    let time: String
}
