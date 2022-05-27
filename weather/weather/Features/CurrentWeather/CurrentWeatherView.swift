//
//  CurrentWeatherView.swift
//  weather
//
//  Created by Kyle Wybranowski on 5/26/22.
//

import SwiftUI

struct CurrentWeatherView<ViewModel: WeatherViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        switch viewModel.viewState {
        case .failed: VStack(alignment: .center) { Text("Failed to load 😭.") }
        case .loading: VStack(alignment: .center) { ProgressView() }
        default:
            VStack {
                Text(viewModel.cityAndState)
                    .font(Font.title3)
                    .padding(.bottom)
                Text(Constants.current)
                    .font(Font.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 5) {
                        ForEach(viewModel.currentWeatherUnits) {
                            WeatherUnitView(unit: $0)
                        }
                    }
                }
            }
            .padding([.top, .bottom])
        }

    }
}
