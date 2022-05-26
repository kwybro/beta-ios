//
//  Helpers.swift
//  weather
//
//  Created by Kyle Wybranowski on 5/26/22.
//

import Foundation

public enum Helpers {
    public static func epochToHour(_ epoch: Double) -> String {
        let timeInterval = TimeInterval(epoch)
        let date = Date(timeIntervalSince1970: timeInterval)


        let itemFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "hh a"
            return formatter
        }()

        return itemFormatter.string(from: date)
    }
}


