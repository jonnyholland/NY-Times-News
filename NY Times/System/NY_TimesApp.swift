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
	var contentViewModel: ContentViewModel = .init()
	
    var body: some Scene {
		Window("NY Times News", id: "ny-times-news-content") {
			ContentView(viewModel: self.contentViewModel)
        }
		.commands {
			CommandGroup(after: .appInfo) {
				Button("Refresh") {
					Task {
						do {
							try await self.contentViewModel.refresh()
						} catch {
							print("Unable to refresh: \(error)")
						}
					}
				}
				.keyboardShortcut("r", modifiers: .command)
			}
		}
    }
}
