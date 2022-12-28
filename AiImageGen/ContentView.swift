//
//  ContentView.swift
//  AiImageGen
//
//  Created by Martin.Q on 2022/12/22.
//

import OpenAIKit
import SwiftUI

final class ViewModel: ObservableObject {
	private var openai: OpenAI?
	
	func setup() {
		openai = OpenAI(Configuration(organization: "organization", apiKey: "apiKey"))
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

struct ContentView: View {
	@ObservedObject var viewModel = ViewModel()
	@State var text = ""
	@State var image: UIImage?
	@State var alertState = false
	@State var fetchingState = false
	
    var body: some View {
		NavigationView {
			VStack {
				Spacer()
				
				if let image = image {
					Image(uiImage: image)
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 300, height: 300)
				} else {
					Text("Type prompt to generatre image!")
				}
				
				Spacer()
				
				TextField("Type prompt here...", text: $text)
					.padding()
				
				Button("Generate!") {
					if !text.trimmingCharacters(in: .whitespaces).isEmpty {
						Task {
							fetchingState.toggle()
							
							let result = await viewModel.generateImage(prompt: text)
							if result == nil {
								print("Failed to get image")
							}
							self.image = result
							
							fetchingState.toggle()
						}
					}
				}
				.disabled(fetchingState)
			}
			.navigationTitle("Image Generator")
			.onAppear{
				viewModel.setup()
			}
			.padding()
			.toolbar {
				ToolbarItem(placement: .navigationBarLeading) {
					NavigationLink {
						InfoView()
					} label: {
						Image(systemName: "info.circle")
					}


				}
				ToolbarItem(placement: .navigationBarTrailing) {
					Button {
						if let image = image {
							alertState.toggle()
						}
					} label: {
						Image(systemName: "square.and.arrow.up")
					}
					.disabled(fetchingState)
				}
			}
			.alert("Alert", isPresented: $alertState) {
				Button {
					UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
				} label: {
					Text("Save")
				}
				
				Button(role: .cancel) {
					
				} label: {
					Text("Cancel")
				}
			} message: {
				Text("Save this photo to your album.")
			}
		}
		.overlay(content: {
			if fetchingState {
				ZStack(alignment: .center) {
					Rectangle()
						.background(.black)
						.opacity(0.8)
						.frame(width: 100, height: 100)
						.cornerRadius(15)
					
					ProgressView()
						.tint(.black)
				}
			}
		})
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
