//
//  NYTimesArticle.swift
//  NY Times
//
//  Created by Jonathan Holland on 11/28/24.
//

import Foundation

struct TopStoriesArticle: Decodable, Hashable {
	let section: ArticleSection
	let subSection: String?
	let title: String
	let abstract: String
	let url: String
	let uri: String
	let byline: String
	let itemType: String
	let updateDate: Date?
	let createdDate: Date
	let publishedDate: Date
	let materialTypeFacet: String?
	let kicker: String?
	let multimedia: [Media]?
	
	enum CodingsKeys: String, CodingKey {
		case section
		case subSection = "subsection"
		case title
		case abstract
		case url
		case uri
		case byline
		case itemType = "item_type"
		case updateDate = "updated_date"
		case createdDate = "created_date"
		case publishedDate = "published_date"
		case materialTypeFacet = "material_type_facet"
		case kicker
		case multimedia
	}
}

extension TopStoriesArticle {
	struct Media: Decodable, Hashable {
		let url: String?
		let format: String?
		let height: Int?
		let width: Int?
		let type: String?
		let subtype: String?
		let caption: String?
		let copyright: String?
	}
}
