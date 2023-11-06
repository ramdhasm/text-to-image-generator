//
//  ContentViewModel.swift
//  TextToImageGen
//
//  Created by Ramdhas on 2023-11-06.
//

import Foundation
import OpenAIKit
import SwiftUI

class ContentViewModel: ObservableObject {
    
    var openAI: OpenAI?
    @Published var generateImage: UIImage?
    func setup() {
        openAI = OpenAI(Configuration(organizationId: "private", apiKey: openAiKey))
    }
    
    func generateImage(prompt: String) async -> UIImage? {
        guard let openAI = openAI else {return nil}
        do {
            let params = ImageParameters(prompt: prompt, numberofImages: 1, resolution: .medium, responseFormat: .base64Json)
            let result = try await openAI.createImage(parameters: params)
            let data = result.data[0].image
            return try openAI.decodeBase64Image(data)
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

