//
//  TopStoriesArticleCell.swift
//  NY Times
//
//  Created by Jonathan Holland on 12/3/24.
//

import SwiftUI

struct TopStoriesArticleCell: View {
	let article: TopStoriesArticle
	
	var body: some View {
		HStack(alignment: .top, spacing: 20) {
			if let media = self.article.multimedia?.first, let url = media.url {
				AsyncImage(url: URL(string: url), scale: 1.0) { image in
					image
						.resizable()
						.aspectRatio(contentMode: .fit)
				} placeholder: {
					ProgressView()
				}
			}
			
			VStack(alignment: .leading, spacing: 4) {
				Text(self.article.title)
					.bold()
					.font(.title3)
				
				Text(self.article.abstract)
					.font(.body)
				
				VStack(alignment: .leading) {
					Text(self.article.byline)
					Text(self.article.publishedDate, format: .dateTime)
				}
				.font(.footnote)
				.foregroundStyle(.secondary)
			}
			.lineLimit(2)
		}
		.safeAreaPadding()
		.frame(maxHeight: 135)
	}
}
