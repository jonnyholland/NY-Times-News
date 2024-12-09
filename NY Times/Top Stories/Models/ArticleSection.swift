//
//  ArticleSection.swift
//  NY Times
//
//  Created by Jonathan Holland on 11/28/24.
//

import SwiftUI

enum ArticleSection: String, CaseIterable, Decodable {
	case arts
	case automobiles
	case books
	case briefing
	case business
	case climate
	case entertainment
	case fashion
	case health
	case home
	case international
	case lifestyle
	case magazine
	case movies
	case nyRegion
	case obituaries
	case opinion
	case politics
	case realEstate
	case science
	case sports
	case style
	case sundayReview
	case technology
	case theater
	case tMagazine
	case travel
	case upshot
	case us
	case weather
	case world
	
	case unknown
	
	var displayName: LocalizedStringKey {
		switch self {
			case .nyRegion:
				return "NY Region"
			case .realEstate:
				return "Real Estate"
			case .sundayReview:
				return "Sunday Review"
			case .tMagazine:
				return "T-Magazine"
			default:
				return LocalizedStringKey(self.rawValue.capitalized)
		}
	}
	
	init(from decoder: any Decoder) throws {
		let container = try decoder.singleValueContainer()
		let rawValue = try container.decode(String.self)
		
		if let section = Self(rawValue: rawValue) {
			self = section
		} else {
			self = .unknown
		}
	}
}
