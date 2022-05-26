//
//  WeatherUnitView.swift
//  weather
//
//  Created by Kyle Wybranowski on 5/26/22.
//

import SwiftUI

struct WeatherUnitView: View {

    @State var unit: WeatherUnit

    var body: some View {
        VStack(alignment: .center) {
            Text(Constants.temperatureInDegrees(Int(unit.temperature)))
                .font(Font.footnote)
                .foregroundColor(.black)
            VStack {
                Spacer()
                Image(systemName: unit.type.imageName)
                    .font(Font.system(.title))
                    .frame(width: 30, height: 30, alignment: .center)
                Spacer()
            }
            Text(unit.time)
                .font(Font.caption2)
                .foregroundColor(.black)
        }
        .frame(width: 75, height: 75)
        .background(Color.white)
    }
}
