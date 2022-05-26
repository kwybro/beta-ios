//
//  Widget.swift
//  weather
//
//  Created by Kyle Wybranowski on 5/26/22.
//

import SwiftUI

struct WeatherWidget: View {

    @State var title: String
    @State var subtitle: String

    var body: some View {
        VStack {
            Text(title)
                .font(Font.footnote)
                .foregroundColor(.black)
            Text(subtitle)
                .font(Font.caption2)
                .foregroundColor(.black)
        }
        .frame(width: 150, height: 150)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 3)
    }
}
