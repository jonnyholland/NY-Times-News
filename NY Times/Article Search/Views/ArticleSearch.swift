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
	@State private var error: Error?
	@State private var showError = false
	
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
		.toolbar {
			if self.isSearching {
				ProgressView()
					.controlSize(.small)
			}
		}
		.task {
			if !self.searchText.isEmpty {
				defer {
					self.isSearching = false
				}
				self.isSearching = true
				do {
					self.articles = try await self.provider.searchArticles(query: self.searchText)
				} catch {
					self.error = error
					self.showError = true
				}
			}
		}
		.alert(
			"Error encountered searching for article",
			isPresented: self.$showError,
			presenting: self.error,
			actions: { error in
				Button("OK", role: .cancel) {}
				Button("Try again") {
					self.taskID = UUID()
				}
			},
			message: { error in
				Text(error.localizedDescription)
			}
		)
	}
}
