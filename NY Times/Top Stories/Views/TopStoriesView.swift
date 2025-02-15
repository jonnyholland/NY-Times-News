//
//  TopStoriesView.swift
//  NY Times
//
//  Created by Jonathan Holland on 11/29/24.
//

import SwiftUI

struct TopStoriesView: View {
	let articles: [TopStoriesArticle]
	
	@Binding var selectedArticle: TopStoriesArticle?
	
	@SceneStorage("TopStoriesViewStyle") var viewStyle: ViewType = .card
	
	var body: some View {
		VStack {
			self.content
		}
		.toolbar {
			ToolbarItem(placement: .navigation) {
				Text(Date().formatted(date: .abbreviated, time: .omitted))
					.bold()
			}
			
			ToolbarItem {
				Picker("View Style", selection: self.$viewStyle) {
					Image(systemName: "list.bullet")
						.help("View as a list")
						.tag(ViewType.list)
					
					Image(systemName: "square.grid.2x2")
						.help("View as cards")
						.tag(ViewType.card)
				}
				.pickerStyle(.segmented)
			}
		}
	}
	
	@ViewBuilder
	private var content: some View {
		if !self.articles.isEmpty {
			switch self.viewStyle {
				case .card: self.card
				case .list: self.list
			}
		} else {
			Text("No stories available…")
				.font(.largeTitle)
		}
	}
	
	private var list: some View {
		List(
			self.articles,
			id: \.self,
			selection: self.$selectedArticle
		) { article in
			TopStoriesArticleCell(article: article)
		}
		.frame(minWidth: 250, minHeight: 250, alignment: .top)
		.listStyle(.plain)
		.background(.regularMaterial)
	}
	
	private var card: some View {
		NYTimesArticleCardScroller(articles: self.articles, currentArticle: self.articles.first) { currentArticle in
			TopStoriesArticleCard(article: currentArticle)
		}
	}
	
	enum ViewType: String, Hashable {
		case list
		case card
	}
}

#Preview {
	TopStoriesView(
		articles: [
			.init(
				section: .health,
				subSection: "covid",
				title: "A New Covid Vaccine May Be Coming Soon",
				abstract: "The WHO recently announced that a new Covid-19 vaccine is in the works.",
				url: "https://nytimes.com/new-covid-vaccine-may-be-coming-soon.html",
				uri: "",
				byline: "By Bill Smith",
				itemType: "",
				updateDate: nil,
				createdDate: .now,
				publishedDate: .now,
				materialTypeFacet: nil,
				kicker: nil,
				multimedia: nil
			)
		],
		selectedArticle: .init(projectedValue: .constant(nil))
	)
}
