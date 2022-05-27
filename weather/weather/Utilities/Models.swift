//
//  Models.swift
//  weather
//
//  Created by Kyle Wybranowski on 5/26/22.
//

import Foundation

struct WeatherWidget: Identifiable, Hashable, Codable {
    var id: String {
        type.title
    }

    enum WidgetType: String, Codable {
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

struct WeatherUnit: Codable, Identifiable {
    var id: String {
        time
    }

    enum WeatherType: String, Codable {
        case sun, rain, cloudy, fog, snow, sleet, thunder

        var imageName: String {
            switch self {
            case .sun: return Constants.sunImageName
            case .rain: return Constants.rainImageName
            case .cloudy: return Constants.cloudyImageName
            case .fog: return Constants.fogImageName
            case .snow: return Constants.snowImageName
            case .sleet: return Constants.sleetImageName
            case .thunder: return Constants.thunderImageName
            }
        }

        init?(for conditionString: String) {
            let condition = conditionString.lowercased()
            if condition.contains("sun") {
                self = .sun
            } else if condition.contains("cloud") || condition.contains("overcast") {
                self = .cloudy
            } else if condition.contains("mist") || condition.contains("fog") {
                self = .fog
            } else if condition.contains("rain") || condition.contains("drizzle") {
                self = .rain
            } else if condition.contains("snow") || condition.contains("blizzard") || condition.contains("ice") {
                self = .snow
            } else if condition.contains("sleet") {
                self = .sleet
            } else if condition.contains("thunder") {
                self = .thunder
            } else {
                return nil
            }
        }
    }

    let type: WeatherType
    let temperature: Double
    let time: String
}

/*
 Credit: pawello2222 from
 https://stackoverflow.com/questions/63166706/how-to-store-nested-arrays-in-appstorage-for-swiftui
*/
extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}
