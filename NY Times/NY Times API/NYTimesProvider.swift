//
//  NYTimesProvider.swift
//  NY Times
//
//  Created by Jonathan Holland on 11/29/24.
//

import ComposableArchitecturePattern
import Foundation

/// Provides functionality across NY Times APIs.
protocol NYTimesProvider: TopStoriesProvider, ArticleSearchProvider {}
