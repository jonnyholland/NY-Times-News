//
//  TopStoriesArticleCard.swift
//  NY Times
//
//  Created by Jonathan Holland on 12/3/24.
//

import SwiftUI

struct TopStoriesArticleCard: View {
	let article: TopStoriesArticle
	
	var body: some View {
		VStack(alignment: .leading) {
			VStack(alignment: .leading) {
				Text(self.article.title)
					.bold()
					.font(.title2)
				
				Text(self.article.abstract)
					.font(.title3)
			}
			.layoutPriority(1)
			
			if let media = self.article.multimedia?.first, let url = media.url {
				AsyncImage(url: URL(string: url), scale: 1.0) { image in
					image
						.resizable()
						.aspectRatio(contentMode: .fill)
						.layoutPriority(0.5)
				} placeholder: {
					ProgressView()
				}
			}
		}
		.safeAreaPadding()
	}
}
