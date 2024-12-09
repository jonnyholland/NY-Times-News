//
//  ContentViewModel.swift
//  NY Times
//
//  Created by Jonathan Holland on 12/4/24.
//

import Foundation

@Observable
final class ContentViewModel {
	var topStories: [TopStoriesArticle] = []
	var provider: NYTimesProvider
	var tabSelection: TabSelection?
	
	init(provider: NYTimesProvider = NYTimesDataProvider()) {
		self.provider = provider
		
		self._refresh()
	}
	
	private func _refresh() {
		Task {
			do {
				try await self.refresh()
			} catch {
				print("***** error refreshing: \(error)")
			}
		}
	}
	
	func refresh() async throws {
		self.topStories = try await self.provider.getTopStories(for: .home)
	}
}
