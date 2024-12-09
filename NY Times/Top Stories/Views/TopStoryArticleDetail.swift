//
//  TopStoryArticleDetail.swift
//  NY Times
//
//  Created by Jonathan Holland on 12/3/24.
//

import SwiftUI

struct TopStoryArticleDetail: View {
	@Environment(\.openURL) var openURL
	
	let article: TopStoriesArticle
	
	var body: some View {
		VStack {
			VStack(alignment: .leading) {
				VStack(alignment: .leading, spacing: 10) {
					Text(self.article.title)
						.bold()
						.font(.largeTitle)
					
					Text(self.article.abstract)
						.font(.title)
					
					HStack(alignment: .top) {
						VStack(alignment: .leading) {
							Text(self.article.byline)
							
							HStack {
								Text(self.article.section.displayName)
								if let subSection = article.subSection {
									Text(subSection)
								}
							}
							.font(.footnote)
							.foregroundStyle(.secondary)
						}
						
						Spacer()
						
						if let updateDate = self.article.updateDate {
							Text(updateDate, format: .dateTime)
						} else {
							Text(self.article.publishedDate, format: .dateTime)
						}
					}
				}
				
				Divider()
				//				.frame(maxWidth: 650)
				
				if let media = self.article.multimedia?.first, let url = media.url {
					AsyncImage(url: URL(string: url), scale: 1.0) { image in
						image
							.resizable()
							.aspectRatio(contentMode: .fit)
							.frame(minHeight: 250)
					} placeholder: {
						ProgressView()
					}
				}
				
				Spacer()
			}
			.frame(maxWidth: 650)
			
			Spacer()
		}
		.navigationTitle(self.article.title)
		.safeAreaPadding()
		.fontDesign(.serif)
		.frame(minWidth: 250, minHeight: 250, alignment: .top)
		.toolbar {
			Button("Open", systemImage: "arrow.up.forward.square") {
				guard let url = URL(string: self.article.url) else { return }
				self.openURL(url)
			}
			.help("Open the article in NY Times website.")
		}
	}
}
