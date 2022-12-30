//
//  ContentView_Deprecated.swift
//  AiImageGen
//
//  Created by Martin.Q on 2022/12/30.
//

import OpenAIKit
import SwiftUI
import SwiftUIVisualEffects

struct ContentView_Deprecated: View {
	@ObservedObject var viewModel = ContetnViewModel()
	
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
						.cornerRadius(10)
						.overlay (
							RoundedRectangle(cornerRadius: 10)
								.stroke(Color.primary, lineWidth: 2)
						)
				} else {
					Text("Type prompt to generatre image!")
				}
				
				Spacer()
				
				TextField("Type prompt here...", text: $text)
					.padding()
					.overlay(
						RoundedRectangle(cornerRadius: 15)
							.stroke(Color.primary, lineWidth: 2)
					)
				
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
						InfoView_Deprecated()
					} label: {
						Image(systemName: "info.circle")
					}
				}

				ToolbarItem(placement: .navigationBarTrailing) {
					Button {
						alertState.toggle()
					} label: {
						Image(systemName: "square.and.arrow.up")
					}
					.disabled(image == nil)
				}
			}
			.alert(isPresented: $alertState) {
				Alert(title: Text("Alert"),
					  message: Text("Save this photo to your album."),
					  primaryButton: .default(Text("Save"),
											  action: { UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil) }
											 ),
					  secondaryButton: .cancel(Text("Cancel"))
				)
			}
		}
		.overlay( fetchingState ? bgProgressView : nil)
	}
}

struct ContentView_Deprecated_Previews: PreviewProvider {
    static var previews: some View {
        ContentView_Deprecated()
    }
}

extension ContentView_Deprecated {
	struct ActivityIndicator: UIViewRepresentable {

		@Binding var isAnimating: Bool
		let style: UIActivityIndicatorView.Style

		func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
			return UIActivityIndicatorView(style: style)
		}

		func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
			isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
		}
	}
}

extension ContentView_Deprecated {
	var bgProgressView: some View {
		ZStack(alignment: .center) {
			Color(.black)
				   .opacity(0.3)
				   .ignoresSafeArea()
			   
		   Rectangle()
			   .blurEffect()
			   .frame(width: 100, height: 100)
			   .cornerRadius(15)
		   
			if #available(iOS 14.0, *) {
				ProgressView()
					.vibrancyEffect()
			} else {
				ActivityIndicator(isAnimating: .constant(true), style: .medium)
					.vibrancyEffect()
			}
	   }
	}
}
