//
//  NYTimesServer.swift
//  NY Times
//
//  Created by Jonathan Holland on 11/28/24.
//

import ComposableArchitecturePattern
import Foundation

actor NYTimesServer: Server {
	static let topStoriesAPI = NYTimesTopStoriesAPI()
	static let searchAPI = NYTimesSearchAPI()
	
	var environments: [ServerEnvironment]
	var currentEnvironment: ServerEnvironment?
	var apis: [any ServerAPI]
	var requestsBeingProcessed = Set<UUID>()
		
	init(
		environments: [ServerEnvironment],
		supportedAPIs: [any ServerAPI]
	) {
		self.environments = environments
		self.apis = supportedAPIs
	}
	
	init(
		environments: [ServerEnvironment],
		currentEnvironment: ServerEnvironment?,
		supportedAPIs: [any ServerAPI]
	) {
		self.environments = environments
		self.currentEnvironment = currentEnvironment
		self.apis = supportedAPIs
	}
	
	/// Initializer for production use.
	init(
		environments: [ServerEnvironment] = [NYTimesAPIGlobalConstants.productionEnvironment],
		currentEnvironment: ServerEnvironment? = NYTimesAPIGlobalConstants.productionEnvironment
	) {
		self.init(
			environments: environments,
			currentEnvironment: currentEnvironment,
			supportedAPIs: [
				Self.topStoriesAPI,
				Self.searchAPI,
			]
		)
	}
	
	func searchArticles(query: String) async throws -> [QueryDoc] {
		let api = Self.searchAPI
		let queries: [URLQueryItem] = [
			.init(name: "q", value: query),
		]
		let response: ArticleSearchResponse = try await self.get(using: api, to: "articlesearch.json", queries: queries, httpBodyOverride: nil, dateDecodingStrategy: .iso8601, keyDecodingStrategy: .convertFromSnakeCase)
		return response.response.docs
	}
	
	func getTopStories(for section: ArticleSection) async throws -> [TopStoriesArticle] {
		let api = Self.topStoriesAPI
		let response: TopStoriesResponse = try await self.get(using: api, to: "/\(section.rawValue).json", dateDecodingStrategy: .iso8601, keyDecodingStrategy: .convertFromSnakeCase)
		return response.results
	}
}
