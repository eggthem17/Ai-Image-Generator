//
//  AiImageGenApp.swift
//  AiImageGen
//
//  Created by Martin.Q on 2022/12/22.
//

import SwiftUI

@available(iOS 14.0, *)
@main
struct AiImageGenApp: App {
    var body: some Scene {
        WindowGroup {
			if #available(iOS 15.0, *) {
				ContentView_Current()
			} else {
				ContentView_Deprecated()
			}
        }
    }
}
