//
//  Weather.swift
//  weather
//
//  Created by Kyle Wybranowski on 5/26/22.
//

import SwiftUI

@main
struct Weather: App {
    let persistenceController = PersistenceController.shared

    var weatherViewModel: WeatherViewModel {
        WeatherViewModel()
    }

    var body: some Scene {
        WindowGroup {
            ContentView(weatherViewModel: weatherViewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
