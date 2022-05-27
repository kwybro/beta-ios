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
        case .failed: VStack(alignment: .center) { Text("Failed to load 😭.").foregroundColor(.black) }
        case .loading: VStack(alignment: .center) { ProgressView() }
        case .ready, .initial, .failedNoLocation:
            VStack {
                Text(viewModel.cityAndState)
                    .font(Font.title3)
                    .foregroundColor(.black)
                Text(viewModel.lastUpdatedDate)
                    .font(Font.caption2)
                    .padding(.bottom)
                    .foregroundColor(.black)
                Text(Constants.current)
                    .font(Font.caption)
                    .foregroundColor(.black)
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
