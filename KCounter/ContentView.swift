//
//  ContentView.swift
//  KCounter
//
//  Created by roger deutsch on 5/29/24.
//

import SwiftUI

struct ContentView: View {
    @State private var connectivity = Connector()
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Game Counter")
            Text(connectivity.receivedText)
        }
        .font(.title)
    }
}

#Preview {
    ContentView()
}
