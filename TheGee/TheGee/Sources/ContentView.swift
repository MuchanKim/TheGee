//
//  ContentView.swift
//  TheGee
//
//  Created by Moo on 4/14/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Image("Cave")
                .resizable()
            Image("Bee")
            
            Text("Hello, world!")
                .font(.custom("DNFBitBitOTF", size: 30))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
