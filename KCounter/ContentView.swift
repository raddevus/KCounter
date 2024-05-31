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
                ZStack{
                    Text(connectivity.receivedText)
                        .foregroundColor(.white)
                    Text(connectivity.receivedText)
                        .offset(x:-3,y:-3)
                }
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
                        saveImageToDisk(image: avatarImage?.getUIImage(newSize: CGSize(width: 1500,height: 1800)), filename: "kcounterBackground")
                        
                    } else {
                        print("Failed")
                        
                    }
                }
            }
        }.onAppear{
            loadImage()
            
        }
    }
    
    func loadImage() {
            
            let fileURL = getDocumentsDirectory().appendingPathComponent("kcounterBackground")
            
            if FileManager.default.fileExists(atPath: fileURL.path) {
                // Load image from disk
                if let imageData = try? Data(contentsOf: fileURL),
                   let loadedImage = UIImage(data: imageData) {
                    avatarImage = Image(uiImage: loadedImage)
                    print("Loaded image from disk: \(fileURL)")
                    return
                }
            }
            
        }
    
    func saveImageToDisk(image: UIImage?, filename:String) {
        print("YikeS!")
            guard let image = image,
                  let imageData = image.jpegData(compressionQuality: 0.9) else {
                return
            }
            
            let fileURL = getDocumentsDirectory().appendingPathComponent(filename)
            print(fileURL)
            
            do {
                try imageData.write(to: fileURL)
                print("Image saved to disk: \(fileURL)")
            } catch {
                print("Failed to save image to disk: \(error)")
            }
        }
    func getDocumentsDirectory() -> URL {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths[0]
        }
    
    
    
}

extension Image {
    @MainActor
    func getUIImage(newSize: CGSize) -> UIImage? {
        let image = resizable()
            .scaledToFill()
            .frame(width: newSize.width, height: newSize.height)
            .clipped()
        return ImageRenderer(content: image).uiImage
    }
}

#Preview {
    ContentView()
}
