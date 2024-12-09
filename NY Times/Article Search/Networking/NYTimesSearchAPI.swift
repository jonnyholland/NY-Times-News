//
//  NYTimesSearchAPI.swift
//  NY Times
//
//  Created by Jonathan Holland on 12/4/24.
//

import ComposableArchitecturePattern
import Foundation

struct ArticleSearchResponse: Decodable {
	let response: ArticleSearchDoc
	
	struct ArticleSearchDoc: Decodable {
		let docs: [QueryDoc]
	}
}

/// An API for search of NY Times articles.
struct NYTimesSearchAPI: ServerAPI {
	let id: UUID
	
	var supportedReturnObjects: [any Decodable.Type]?
	
	var body: Data?
	
	var queries: [URLQueryItem]?
	
	var headers: [String: String]?
	
	var environment: ServerEnvironment?
	
	var path: String
	var serverPath: String
	
	var supportedHTTPMethods: [HTTPMethod]
	
	/// Designated initializer.
	init(
		environment: ServerEnvironment? = NYTimesAPIGlobalConstants.productionEnvironment,
		headers: [String : String]? = nil,
		queries: [URLQueryItem]? = NYTimesAPIGlobalConstants.apiQueries,
		supportedHTTPMethods: [HTTPMethod] = [.GET],
		supportedReturnObjects: [any Decodable.Type] = [ArticleSearchResponse.self]
	) {
		self.id = UUID()
		
		self.serverPath = APIEndPoints.search
		self.path = self.serverPath
		self.environment = environment
		self.headers = headers
		self.queries = queries
		self.supportedHTTPMethods = supportedHTTPMethods
		self.supportedReturnObjects = supportedReturnObjects
	}
}
