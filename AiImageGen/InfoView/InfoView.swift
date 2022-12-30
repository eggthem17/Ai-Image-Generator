//
//  InfoView.swift
//  AiImageGen
//
//  Created by Martin.Q on 2022/12/23.
//

import SwiftUI

struct InfoView: View {
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

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
