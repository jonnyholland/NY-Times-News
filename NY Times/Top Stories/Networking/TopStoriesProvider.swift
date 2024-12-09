//
//  TopStoriesProvider.swift
//  NY Times
//
//  Created by Jonathan Holland on 11/28/24.
//

import Foundation

/// An object that provides top stories from the NY Times API.
protocol TopStoriesProvider {
	/// Gets the top stories for the given section.
	/// - Throws: Any error encountered during fetching or decoding.
	/// - Returns: A collection of articles from the service.
	func getTopStories(for section: ArticleSection) async throws -> [TopStoriesArticle]
}
