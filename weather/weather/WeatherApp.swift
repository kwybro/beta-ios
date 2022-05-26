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

    private var network: Network {
        NetworkImp()
    }

    var apiClient: APIClient {
        APIClientImp(network: network)
    }

    var weatherViewModel: WeatherViewModel {
        WeatherViewModel(apiClient: apiClient)
    }

    var body: some Scene {
        WindowGroup {
            ContentView(weatherViewModel: weatherViewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
