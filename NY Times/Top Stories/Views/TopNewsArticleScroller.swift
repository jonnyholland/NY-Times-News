//
//  TopNewsArticleScroller.swift
//  NY Times
//
//  Created by Jonathan Holland on 2/15/25.
//

import SwiftUI

/// Displays a card scroller for the selected article in the specified top stories.
struct TopNewsArticleScroller: View {
	let topStories: [TopStoriesArticle]
	@State var selectedArticle: TopStoriesArticle?
	
	var body: some View {
		NavigationStack {
			NYTimesArticleCardScroller(articles: self.topStories, currentArticle: self.selectedArticle) { currentArticle in
				TopStoriesArticleCard(article: currentArticle)
			}
		}
	}
}
