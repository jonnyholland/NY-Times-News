//
//  ContentView.swift
//  NY Times
//
//  Created by Jonathan Holland on 11/28/24.
//

import SwiftUI
import SwiftData

struct ContentView<Provider: NYTimesProvider>: View {
	var provider: Provider
	
	@SceneStorage("CurrentTabSelection") var tabSelection: TabSelection = .topStories
	@SceneStorage("TopStoriesViewStyle") var viewStyle: ArticleViewType = .card
	
	@State private var topStories = [TopStoriesArticle]()
	@State private var selectedArticle: TopStoriesArticle?
	@Binding var refreshID: UUID
	@State private var isFetching = false
	@State private var fetchError: Error?
	@State private var showErrorAlert = false

    var body: some View {
		NavigationStack {
			TabView(selection: self.$tabSelection) {
				Tab(TabSelection.topStories.displayText, systemImage: "star.circle", value: .topStories) {
					TopStoriesView(articles: self.topStories, selectedArticle: self.$selectedArticle)
				}
				
				Tab(TabSelection.search.displayText, systemImage: "magnifyingglass", value: .search) {
					ArticleSearch()
				}
			}
			.fontDesign(.serif)
			.navigationDestination(item: self.$selectedArticle) { article in
				TopStoryArticleDetail(article: article)
			}
			.toolbar {
				if self.isFetching {
					ProgressView()
						.controlSize(.small)
				}
				Button {
					self.refreshID = UUID()
				} label: {
					Image(systemName: "arrow.counterclockwise")
				}
				.accessibilityLabel(Text("Refresh"))
				.accessibilityHint(Text("Refresh the news"))
			}
			.refreshable {
				self.refreshID = UUID()
			}
        }
		.task(id: self.refreshID) {
			do {
				defer {
					self.isFetching = false
				}
				self.isFetching = true
				
				self.topStories = try await self.provider.getTopStories(for: .home)
			} catch {
				self.fetchError = error
				self.showErrorAlert = true
			}
		}
		.alert(
			"Unable to get news",
			isPresented: self.$showErrorAlert,
			presenting: self.fetchError,
			actions: { error in
				Button("OK", role: .cancel) {}
			},
			message: { error in
				Text(error.localizedDescription)
			}
		)
    }
}

enum TabSelection: String, Hashable, CaseIterable {
	case realTime
	case search
	case topStories
	case popular
	
	var displayText: LocalizedStringKey {
		switch self {
			case .popular: return "Popular"
			case .search: return "Search"
			case .topStories: return "Top Stories"
			case .realTime: return "Current"
		}
	}
}

#Preview {
	ContentView(provider: NYTimesDataProvider(), refreshID: .constant(.init()))
}
