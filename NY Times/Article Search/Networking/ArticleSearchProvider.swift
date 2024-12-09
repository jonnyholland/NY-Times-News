//
//  ArticleSearchProvider.swift
//  NY Times
//
//  Created by Jonathan Holland on 12/4/24.
//

import Foundation

/// An object that searches NY Times API for specific articles.
protocol ArticleSearchProvider {
	/// Searches for articles based on the query string.
	/// - Parameter query: A query string to search against.
	/// - Throws: Any error encountered during fetching or decoding.
	/// - Returns: A collection of articles from the service.
	func searchArticles(query: String) async throws -> [QueryDoc]
}
