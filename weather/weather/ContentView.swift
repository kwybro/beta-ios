//
//  ContentView.swift
//  weather
//
//  Created by Kyle Wybranowski on 5/26/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    var currentWeatherViewModel: CurrentWeatherViewModel


    var body: some View {
        NavigationView {
            List {
                VStack {
                    CurrentWeatherView(viewModel: currentWeatherViewModel)
                        .navigationTitle(Constants.hometownWeather)
                    Spacer()
                }
            }.refreshable {
                print("Hi")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
