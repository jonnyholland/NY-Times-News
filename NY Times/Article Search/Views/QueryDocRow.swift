//
//  QueryDocRow.swift
//  NY Times
//
//  Created by Jonathan Holland on 12/7/24.
//

import SwiftUI

protocol ArticleRepresentable: Hashable {
	var title: String { get }
	var abstract: String { get }
	var url: URL? { get }
	var byline: String? { get }
	var publishedDate: Date { get }
	var articleMediaURL: URL? { get }
}

struct QueryDocRow: View {
	let doc: QueryDoc
	
	var body: some View {
		HStack(alignment: .top, spacing: 20) {
			if let multimedia = self.doc.multimedia, let media = multimedia.first(where: { $0.subtype == .xlarge || $0.subtype == .large }) {
				AsyncImage(url: URL(string: "https://static01.nyt.com/" + media.url), scale: 1.0) { image in
					image
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 150, height: 150)
				} placeholder: {
					ProgressView()
				}
				
				Divider()
			}
			
			VStack(alignment: .leading, spacing: 2) {
				HStack(spacing: 20) {
					Text(self.doc.pubDate, format: .dateTime)
					
					Divider()
						.frame(maxHeight: 15)
					
					Text(self.doc.sectionName)
					
					if let source = self.doc.source {
						Divider()
							.frame(maxHeight: 15)
						
						Text(source)
					}
				}
				.font(.callout)
				.foregroundStyle(.secondary)
				.frame(maxWidth: .infinity, alignment: .leading)
				
				Text(self.doc.headline.main)
					.bold()
					.font(.title3)
				
				Text(self.doc.abstract)
					.lineLimit(5)
				
				if let byline = self.doc.byline, let original = byline.original {
					Text(original)
						.font(.footnote)
						.foregroundStyle(.secondary)
				}
			}
		}
		.safeAreaPadding()
		.frame(maxWidth: .infinity, maxHeight: 200)
	}
}
