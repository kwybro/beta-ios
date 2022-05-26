//
//  WeatherWidgetsListView.swift
//  weather
//
//  Created by Kyle Wybranowski on 5/26/22.
//

import SwiftUI

struct WeatherWidgetsListView<ViewModel: WeatherViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel

    let columns: [GridItem] = [GridItem(.adaptive(minimum: 300))]

    var body: some View {
        switch viewModel.viewState {
        case .failed: VStack(alignment: .center) { Text("Pull to refresh") }
        case .loading: VStack() {}
        default:
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(viewModel.currentWeatherWidgets, id: \.self) { data in
                    WeatherWidgetView(data: data)
                }
            }
            .padding([.top, .bottom])
        }

    }
}
