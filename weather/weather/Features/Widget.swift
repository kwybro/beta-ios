//
//  Widget.swift
//  weather
//
//  Created by Kyle Wybranowski on 5/26/22.
//

import SwiftUI

struct Widget: View {

    @State var title: String
    @State var subtitle: String

    var body: some View {
        HStack(spacing: 20) {
            HStack {
                VStack {
                    Text(title)
                    .font(Font.headline)
                    .foregroundColor(.black)
                    Text(subtitle)
                    .font(Font.title3)
                    .foregroundColor(.black)
                }
            }
            .frame(width: 150, height: 150)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 5)
        }
    }
}

struct Widget_Previews: PreviewProvider {
    static var previews: some View {
        Widget(title: "Rainy", subtitle: "6:00PM")
    }
}
