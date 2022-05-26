//
//  CurrentWeatherView.swift
//  weather
//
//  Created by Kyle Wybranowski on 5/26/22.
//

import SwiftUI

struct CurrentWeatherView: View {
    var body: some View {
        ScrollView(.vertical) {
            Widget(title: "Rainy", subtitle: "6:00PM")
            Widget(title: "Partially Cloudy", subtitle: "6:30PM")
            Widget(title: "Sunny", subtitle: "7:00PM")
            Spacer().frame(maxWidth: .infinity)
        }
    }
}

struct CurrentWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView()
    }
}
