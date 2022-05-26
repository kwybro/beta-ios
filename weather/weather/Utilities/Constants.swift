//
//  Constants.swift
//  weather
//
//  Created by Kyle Wybranowski on 5/26/22.
//

import Foundation

public enum Constants {
    public static let hometownWeather: String = "Hometown Weather"
    public static let current: String = "Current"
    public static let precipitation: String = "Precipitation"
    public static let humidity: String = "Humidity"
    public static let uvIndex: String = "UV Index"
    public static let windSpeed: String = "Wind Speed"
    public static let visibility: String = "Visibility"
    public static let pressure: String = "Pressure"
    public static let precipitationImageName: String = "drop.fill"
    public static let humidityImageName: String = "humidity"
    public static let uvIndexImageName: String = "sun.min"
    public static let windSpeedImageName: String = "wind"
    public static let visibilityImageName: String = "eye"
    public static let pressureImageName: String = "gauge"
    public static let sunImageName: String = "sun.max.fill"
    public static let rainImageName: String = "cloud.rain.fill"
    public static let cloudyImageName: String = "cloud.fill"

    public static func temperatureInDegrees(_ temp: Int) -> String { "\(temp)°"}
}
