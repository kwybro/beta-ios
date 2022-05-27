//
//  WeatherResponses.swift
//  weather
//
//  Created by Kyle Wybranowski on 5/26/22.
//

import Foundation

struct WeatherResponse: Codable {
    let location: Location?
    let current: Current?
    let forecast: Forecast?
}

extension WeatherResponse {
    struct Location: Codable {
        private enum CodingKeys: String, CodingKey {
            case name
            case region
            case country
            case lat
            case long
            case timezone = "tz_id"
            case localTime = "localtime_epoch"
        }

        let name: String?
        let region: String?
        let country: String?
        let lat: Double?
        let long: Double?
        let timezone: String?
        let localTime: Double?
    }

    struct Current: Codable {
        private enum CodingKeys: String, CodingKey {
            case humidity
            case uvIndex = "uv"
            case visibility = "vis_miles"
            case precipitation = "precip_in"
            case pressure = "pressure_in"
            case windSpeed = "wind_mph"
        }

        let humidity: Double?
        let uvIndex: Double?
        let visibility: Double?
        let precipitation: Double?
        let pressure: Double?
        let windSpeed: Double?
    }

    struct Forecast: Codable {
        private enum CodingKeys: String, CodingKey {
            case forecastDays = "forecastday"
        }

        let forecastDays: [ForecastDay]?
    }
}

extension WeatherResponse.Forecast {
    struct ForecastDay: Codable {
        private enum CodingKeys: String, CodingKey {
            case date = "date_epoch"
            case hours = "hour"
        }

        let date: Double?
        let hours: [ForecastHour]?
    }
}

extension WeatherResponse.Forecast.ForecastDay {
    struct ForecastHour: Codable {
        private enum CodingKeys: String, CodingKey {
            case time = "time_epoch"
            case temperature = "temp_f"
            case condition
        }

        let time: Double?
        let temperature: Double?
        let condition: Condition?

        struct Condition: Codable {
            let text: String?
        }
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}
