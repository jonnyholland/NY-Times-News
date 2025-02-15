//
//  NY_TimesApp.swift
//  NY Times
//
//  Created by Jonathan Holland on 11/28/24.
//

import SwiftUI
import SwiftData

@main
struct NY_TimesApp: App {
	var topStoriesProvider = NYTimesDataProvider()
	@State private var refreshID = UUID()
	
    var body: some Scene {
		Window("NY Times News", id: "ny-times-news-content") {
			ContentView(provider: self.topStoriesProvider, refreshID: self.$refreshID)
        }
		.commands {
			CommandGroup(after: .appInfo) {
				Button("Refresh") {
					self.refreshID = UUID()
				}
				.keyboardShortcut("r", modifiers: .command)
			}
		}
    }
}
