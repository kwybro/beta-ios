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

    public static func temperatureInDegrees(_ temp: Int) -> String { "\(temp)°"}
}
