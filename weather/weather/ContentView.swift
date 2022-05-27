//
//  ContentView.swift
//  weather
//
//  Created by Kyle Wybranowski on 5/26/22.
//

import CoreData
import SwiftUI

struct ContentView: View {

    var weatherViewModel: WeatherViewModel

    var body: some View {
        NavigationView {
            List {
                VStack {
                    CurrentWeatherView(viewModel: weatherViewModel)
                        .navigationTitle(Constants.hometownWeather)
                    WeatherWidgetsListView(viewModel: weatherViewModel)
                    Spacer()
                }
            }.refreshable {
                weatherViewModel.getWeather()
            }
        }
    }
}
