//
//  NYTimesDataProvider.swift
//  NY Times
//
//  Created by Jonathan Holland on 12/4/24.
//

import ComposableArchitecturePattern
import Foundation

actor NYTimesDataProvider: NYTimesProvider {
	static let environment: ServerEnvironment = .production(url: NYTimesAPIGlobalConstants.baseURL)
	
	private lazy var server: NYTimesServer = .init()
	
	func getTopStories(for section: ArticleSection) async throws -> [TopStoriesArticle] {
		return try await self.server.getTopStories(for: section)
	}
	
	func searchArticles(query: String) async throws -> [QueryDoc] {
		return try await self.server.searchArticles(query: query)
	}
}
