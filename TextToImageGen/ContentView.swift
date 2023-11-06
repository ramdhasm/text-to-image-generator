//
//  ContentView.swift
//  TextToImageGen
//
//  Created by Ramdhas on 2023-11-06.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var contenVM = ContentViewModel()
    @State var userPrompt = ""
    @State var image: UIImage?
    
    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
            } else
            {
                Text("No Image yet")
            }
            Spacer()
            TextField("random image", text: $userPrompt, prompt: Text("Enter your prompt"))
                .padding()
            Button("Generate image!"){
                Task {
                    image = await contenVM.generateImage(prompt: userPrompt)
                }
            }
            .padding()
            
            .onAppear{
                contenVM.setup()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
