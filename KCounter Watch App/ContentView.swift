//
//  ContentView.swift
//  KCounter Watch App
//
//  Created by roger deutsch on 5/29/24.
//

import SwiftUI

struct ContentView: View {
    @State private var connector = Connector()
    @State private var counter = 0
    
    var body: some View {
        VStack {
            Button("Add 1", action: sendMessage)
            Text("\(counter)")
                .font(.title)
            // Text(connector.receivedText)
            
            Button("Reset", action: resetCounter)
        }
    }

    func sendMessage() {
        counter += 1
        let data = ["counter":"\(counter)","text": "Hello from the watch"]
        connector.sendMessage(data)
    }
    
    func resetCounter(){
        counter = 0
        let data =  ["counter":"\(counter)"]
        connector.sendMessage( data)
    }
}
// KCounter%20Watch%20App.app
#Preview {
    ContentView()
}
