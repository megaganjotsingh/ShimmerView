//
//  ContentView.swift
//  ShimmerView
//
//  Created by Admin on 13/10/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .shimmer(ShimmerConfig(tint: .gray.opacity(0.5), hightlight: .black))
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
