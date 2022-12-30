//
//  InfoView_Deprecated.swift
//  AiImageGen
//
//  Created by Martin.Q on 2022/12/30.
//

import SwiftUI

struct InfoView_Deprecated: View {
	let blogAddr = URL(string: "https://chillog.page")
	let openAiAddr = URL(string: "https://openai.com")
	
	var body: some View {
		VStack {
			HStack {
				VStack(alignment: .leading) {
					Text("Made by")
						.font(.largeTitle)
					
					Link("@Eggthem17", destination: blogAddr!)
						.accentColor(.orange)
				}
				
				Spacer()
				
				Image("chillog_logo")
					.resizable()
					.frame(width: 60, height: 60)
					.cornerRadius(15)
			}
			.frame(width: 240)
			.padding()
			
			Divider()
				.frame(minHeight: 2)
				.background(
					Color.primary
				)
			
			HStack {
				VStack(alignment: .leading) {
					Text("Powered by")
						.font(.largeTitle)
					
					Link("@OpenAI", destination: openAiAddr!)
						.accentColor(.blue)
				}
				
				Spacer()
				
				Image("openai_logo")
					.resizable()
					.frame(width: 60, height: 60)
					.cornerRadius(15)
					.overlay(
						RoundedRectangle(cornerRadius: 15)
							.stroke(Color.primary, lineWidth: 3)
					)
			}
			.frame(width: 240)
			.padding()
		}
		.frame(width: 240)
		.modifier(navigationInline())
	}
}

struct InfoView_Deprecated_Previews: PreviewProvider {
    static var previews: some View {
        InfoView_Deprecated()
    }
}

struct navigationInline: ViewModifier {
	func body(content: Content) -> some View {
		if #available(iOS 15.0, *) {
			content
				.navigationBarTitleDisplayMode(.inline)
		} else {
			content
				.navigationBarTitle("", displayMode: .inline)
		}
	}
}
