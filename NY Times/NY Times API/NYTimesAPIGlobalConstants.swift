//
//  NYTimesAPIGlobalConstants.swift
//  NY Times
//
//  Created by Jonathan Holland on 12/4/24.
//

import ComposableArchitecturePattern
import Foundation

/// Global constants used across all APIs.
enum NYTimesAPIGlobalConstants {
	/// The server environment for production.
	static let productionEnvironment: ServerEnvironment = .production(url: NYTimesAPIGlobalConstants.baseURL)
	
	/// The base url string for the NY Times API.
	static let baseURL = "https://api.nytimes.com/svc"
	
	/// The general API queries for all NY Times APIs.
	static var apiQueries: [URLQueryItem] = [
		.init(name: "api-key", value: ProcessInfo.processInfo.environment["API_KEY"]),
	]
}
