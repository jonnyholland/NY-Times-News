//
//  ContentView.swift
//  NY Times
//
//  Created by Jonathan Holland on 11/28/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
	@Bindable var viewModel: ContentViewModel
	
	@SceneStorage("CurrentTabSelection") var tabSelection: TabSelection = .topStories
	@State private var refreshID: UUID? = .init()
	
	@SceneStorage("TopStoriesViewStyle") var viewStyle: ArticleViewType = .card
	
	@State private var selectedArticle: TopStoriesArticle?

    var body: some View {
		NavigationStack {
			TabView(selection: self.$tabSelection) {
				Tab(TabSelection.topStories.displayText, systemImage: "star.circle", value: .topStories) {
					TopStoriesView(articles: self.viewModel.topStories, selectedArticle: self.$selectedArticle)
				}
				
				Tab(TabSelection.search.displayText, systemImage: "magnifyingglass", value: .search) {
					ArticleSearch()
				}
			}
			.fontDesign(.serif)
			.navigationDestination(item: self.$selectedArticle) { article in
				TopStoryArticleDetail(article: article)
			}
        }
		.onChange(of: self.tabSelection, initial: true) { _, newValue in
			self.viewModel.tabSelection = newValue
		}
//		.task(id: self.refreshID) {
//			try? await self.viewModel.refresh()
//		}
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
	ContentView(viewModel: ContentViewModel())
}
