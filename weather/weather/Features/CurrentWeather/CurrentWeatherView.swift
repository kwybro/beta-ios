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
        case .loading: ProgressView()
        default:
            VStack {
                Text(Constants.current)
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
