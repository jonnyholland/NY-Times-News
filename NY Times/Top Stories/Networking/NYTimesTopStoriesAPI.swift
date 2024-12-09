//
//  NYTimesTopStoriesAPI.swift
//  NY Times
//
//  Created by Jonathan Holland on 11/28/24.
//

import ComposableArchitecturePattern
import Foundation

struct TopStoriesResponse: Decodable {
	let results: [TopStoriesArticle]
}

/// An API for NY Times top stories.
struct NYTimesTopStoriesAPI: ServerAPI {
	let id: UUID
	
	var supportedReturnObjects: [any Decodable.Type]?
	
	var body: Data?
	
	var queries: [URLQueryItem]?
	
	var headers: [String: String]?
	
	var environment: ServerEnvironment?
	
	var path: String
	var serverPath: String
	
	var supportedHTTPMethods: [HTTPMethod]
		
	init(
		environment: ServerEnvironment? = NYTimesAPIGlobalConstants.productionEnvironment,
		headers: [String : String]? = nil,
		queries: [URLQueryItem]? = NYTimesAPIGlobalConstants.apiQueries,
		supportedHTTPMethods: [HTTPMethod] = [.GET],
		supportedReturnObjects: [any Decodable.Type] = [TopStoriesResponse.self]
	) {
		self.id = UUID()
		
		self.serverPath = APIEndPoints.topStories
		self.path = self.serverPath
		self.environment = environment
		self.headers = headers
		self.queries = queries
		self.supportedHTTPMethods = supportedHTTPMethods
		self.supportedReturnObjects = supportedReturnObjects
	}
}
