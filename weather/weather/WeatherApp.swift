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

    var currentWeatherViewModel: CurrentWeatherViewModel {
        CurrentWeatherViewModel()
    }

    var body: some Scene {
        WindowGroup {
            ContentView(currentWeatherViewModel: currentWeatherViewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
