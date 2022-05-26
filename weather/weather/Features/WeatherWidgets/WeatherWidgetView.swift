//
//  Widget.swift
//  weather
//
//  Created by Kyle Wybranowski on 5/26/22.
//

import SwiftUI

struct WeatherWidgetView: View {

    @State var data: WeatherWidget

    var body: some View {
        HStack {
            (Text(Image(systemName: data.type.imageName)) + Text(" ") + Text(data.type.title))
                .font(Font.subheadline)
                .foregroundColor(.black)
                .padding(.leading)
            Spacer()
            Text(data.value)
                .font(Font.headline)
                .foregroundColor(.black)
                .padding(.trailing)
        }
        .frame(width: 300, height: 75)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 3)
    }
}
