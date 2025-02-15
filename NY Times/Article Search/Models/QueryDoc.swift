//
//  QueryDoc.swift
//  NY Times
//
//  Created by Jonathan Holland on 12/4/24.
//

import Foundation

/// The response object from the NY Times API for search.
struct QueryDoc: Decodable, Hashable {
	let abstract: String
	let webUrl: String
	let snippet: String
	let leadParagraph: String?
	let source: String?
	let headline: Headline
	let pubDate: Date
	let newsDesk: String
	let sectionName: String
	let subsectionName: String?
	let byline: Byline?
	let typeOfMaterial: String?
	let wordCount: Int
	let uri: String
	let multimedia: [Media]?
}

extension QueryDoc {
	struct Headline: Decodable, Hashable {
		let main: String
		let kicker: String?
		let printHeadline: String?
	}
	
	struct Byline: Decodable, Hashable {
		let original: String?
		let person: [Person]?
	}
}

extension QueryDoc {
	struct Person: Decodable, Hashable {
		let firstname: String
		let middlename: String?
		let lastname: String?
		let qualifier: String?
		let title: String?
		let role: String?
		let organization: String?
		let rank: Int
	}
}

extension QueryDoc {
	struct Media: Decodable, Hashable {
		let rank: Int
		let subtype: SubType?
		let caption: String?
		let credit: String?
		let type: String
		let url: String
		let height: Int
		let width: Int
		
		enum SubType: String, Decodable {
			case xlarge, large, medium, small, other
			
			init(from decoder: any Decoder) throws {
				let container = try decoder.singleValueContainer()
				let string = try container.decode(String.self)
				if let subType = SubType(rawValue: string) {
					self = subType
				} else {
					self = .other
				}
			}
		}
	}
}
