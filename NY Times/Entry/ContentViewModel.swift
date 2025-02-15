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
	var isRefreshing = false
	var fetchError: Error? {
		didSet {
			if self.fetchError != nil {
				self.showError = true
			}
		}
	}
	var showError = false
	
	init(provider: NYTimesProvider = NYTimesDataProvider()) {
		self.provider = provider
		
		self._refresh()
	}
	
	private func _refresh() {
		Task {
			defer {
				self.isRefreshing = false
			}
			self.isRefreshing = true
			
			do {
				try await self.refresh()
			} catch {
				self.fetchError = error
			}
		}
	}
	
	func refresh() async throws {
		self.topStories = try await self.provider.getTopStories(for: .home)
	}
}
