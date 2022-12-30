//
//  InfoView_Current.swift
//  AiImageGen
//
//  Created by Martin.Q on 2022/12/30.
//

import SwiftUI

@available(iOS 15.0, *)
struct InfoView_Current: View {
	let blogAddr = URL(string: "https://chillog.page")
	let openAiAddr = URL(string: "https://openai.com")
	
	var body: some View {
		VStack {
			HStack {
				VStack(alignment: .leading) {
					Text("Made by")
						.font(.largeTitle)
					
					Link("@Eggthem17", destination: blogAddr!)
						.tint(.orange)
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
				.background(.primary)
			
			HStack {
				VStack(alignment: .leading) {
					Text("Powered by")
						.font(.largeTitle)
					
					Link("@OpenAI", destination: openAiAddr!)
				}
				
				Spacer()
				
				Image("openai_logo")
					.resizable()
					.frame(width: 60, height: 60)
					.cornerRadius(15)
					.overlay(content: {
						RoundedRectangle(cornerRadius: 15)
							.stroke(.primary, lineWidth: 3)
					})
			}
			.frame(width: 240)
			.padding()
		}
		.frame(width: 240)
		.navigationBarTitleDisplayMode(.inline)
	}
}

@available(iOS 15.0, *)
struct InfoView_Current_Previews: PreviewProvider {
    static var previews: some View {
        InfoView_Current()
    }
}
