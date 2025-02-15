//
//  NYTimesArticleCardScroller.swift
//  NY Times
//
//  Created by Jonathan Holland on 12/3/24.
//

import SwiftUI

enum ArticleViewType: String, Hashable {
	case list
	case card
}

struct NYTimesArticleCardScroller<T: Hashable, ArticleView: View>: View {
	let articles: [T]
	@State var currentArticle: T?
	let articleView: (T) -> ArticleView
	
	private var canGoBack: Bool {
		guard let currentArticle else {
			return false
		}
		
		return self.articles.startIndex != self.articles.firstIndex(of: currentArticle)
	}
	
	private var canGoForward: Bool {
		guard let currentArticle else {
			return true
		}
		
		return self.articles.endIndex != self.articles.firstIndex(of: currentArticle)
	}
	
	var body: some View {
		HStack {
			Button {
				guard let currentArticle, let index = self.articles.firstIndex(of: currentArticle) else {
					return
				}
				
				if let previousIndex = self.articles.index(index, offsetBy: -1, limitedBy: self.articles.startIndex) {
					self.currentArticle = self.articles[previousIndex]
				}
			} label: {
				Image(systemName: "arrow.left")
			}
			.disabled(!self.canGoBack)
			
			Spacer()
				.frame(maxWidth: 150)
			
			if let currentArticle {
				self.articleView(currentArticle)
			}
			
			Spacer()
				.frame(maxWidth: 150)
			
			Button {
				guard let currentArticle, let index = self.articles.firstIndex(of: currentArticle) else {
					self.currentArticle = self.articles.first
					return
				}
				
				if let nextIndex = self.articles.index(index, offsetBy: 1, limitedBy: self.articles.endIndex) {
					self.currentArticle = self.articles[nextIndex]
				}
			} label: {
				Image(systemName: "arrow.right")
			}
			.disabled(!self.canGoForward)
		}
		.safeAreaPadding()
	}
}
