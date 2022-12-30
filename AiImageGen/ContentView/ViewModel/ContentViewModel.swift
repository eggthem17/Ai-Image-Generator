//
//  ContentViewModel.swift
//  AiImageGen
//
//  Created by Martin.Q on 2022/12/30.
//

import UIKit
import OpenAIKit

class ContetnViewModel: ObservableObject {
	private var openai: OpenAI?
	
	func setup() {
		openai = OpenAI(Configuration(organization: "[organization]", apiKey: "[apiKey]"))
	}
	
	func generateImage(prompt: String) async -> UIImage? {
		guard let openai = openai else {
			return nil
		}
		
		do {
			let params = ImageParameters(prompt: prompt, resolution: .medium, responseFormat: .base64Json)
			let result = try await openai.createImage(parameters: params)
			let data = result.data[0].image
			let image = try openai.decodeBase64Image(data)
			
			return image
		} catch {
			print(String(describing: error))
			return nil
		}
	}
}
