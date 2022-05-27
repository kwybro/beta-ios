//
//  Helpers.swift
//  weather
//
//  Created by Kyle Wybranowski on 5/26/22.
//

import Foundation

public enum Helpers {
    public static func isTimeValid(_ epoch: Double) -> Bool {
        let timeInterval = TimeInterval(epoch)
        let date = Date(timeIntervalSince1970: timeInterval + TimeInterval.oneHour)
        let now = Date()

        return now <= date
    }

    public static func epochToHour(_ epoch: Double) -> String {
        let timeInterval = TimeInterval(epoch)
        let date = Date(timeIntervalSince1970: timeInterval)

        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "hh a"
            return formatter
        }()

        return dateFormatter.string(from: date)
    }

    public static func epochToDate(_ epoch: Double) -> String {
        let timeInterval = TimeInterval(epoch)
        let date = Date(timeIntervalSince1970: timeInterval)

        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            return formatter
        }()

        return dateFormatter.string(from: date)
    }
}

extension TimeInterval {
    static var oneHour: Double {
        3600
    }
}
