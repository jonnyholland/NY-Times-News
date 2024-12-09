//
//  ArticleSearch.swift
//  NY Times
//
//  Created by Jonathan Holland on 12/4/24.
//

import SwiftUI

struct ArticleSearch<Provider: ArticleSearchProvider>: View {
	private var provider: Provider
	
	init(provider: Provider = NYTimesDataProvider()) {
		self.provider = provider
	}
	
	@SceneStorage("ArticleSearchText") private var searchText: String = ""
	@State private var articles = [QueryDoc]()
	@State private var selection: QueryDoc?
	
	@State private var isSearching = false
	
	var body: some View {
		VStack {
			TextField("Search for any article…", text: self.$searchText)
				.textFieldStyle(.roundedBorder)
				.onSubmit {
					guard !self.searchText.isEmpty else {
						return
					}
					Task {
						do {
							self.articles = try await self.provider.searchArticles(query: self.searchText)
						} catch {
							print("Unable to search articles: \(error).")
						}
					}
				}
			
			Spacer()
			
			List(self.articles, id: \.self, selection: self.$selection) { doc in
				QueryDocRow(doc: doc)
			}
		}
		.safeAreaPadding()
		.opacity(self.isSearching ? 0.3 : 1)
		.overlay {
			if self.isSearching {
				ProgressView()
			}
		}
		.toolbar {}
		.task {
			if !self.searchText.isEmpty {
				do {
					self.articles = try await self.provider.searchArticles(query: self.searchText)
				} catch {
					print("Unable to search articles: \(error).")
				}
			}
		}
	}
}
