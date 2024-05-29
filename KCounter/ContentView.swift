//
//  ContentView.swift
//  KCounter
//
//  Created by roger deutsch on 5/29/24.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @State private var connectivity = Connector()
    
    @State private var avatarItem: PhotosPickerItem?
        @State private var avatarImage: Image?
    
    var body: some View {
        ZStack{
            avatarImage?
            .resizable()
            .scaledToFill()
            .opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                Text("Game Counter")
                Text(connectivity.receivedText)
            }
            .font(.title)
            VStack {
                PhotosPicker("Select background", selection: $avatarItem, matching: .images)
                    .frame(maxHeight: .infinity, alignment: .bottom)
            }
            .onChange(of: avatarItem) {
                Task {
                    if let loaded = try? await avatarItem?.loadTransferable(type: Image.self) {
                        avatarImage = loaded
                        print(avatarImage)
                    } else {
                        print("Failed")
                    }
                }
            }
        }
    }
    
}

#Preview {
    ContentView()
}
