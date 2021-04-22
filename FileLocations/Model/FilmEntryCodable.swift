//
//  FilmEntryCodable.swift
//  FileLocations
//
//  Created by Rick Jacobson on 4/22/21.
//

import Foundation

struct FilmEntryCodable: Codable {
    var firstActor: String
    var locations: String
    var releaseYear: String
    var title: String
    
    enum CodingKeys: String, CodingKey {
        case firstActor = "actor_1"
        case locations = "locations"
        case releaseYear = "releaseYear"
        case title = "title"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        firstActor = (try container.decodeIfPresent(String.self, forKey: .firstActor)) ?? "Unknwon"
        locations = (try container.decodeIfPresent(String.self, forKey: .locations)) ?? "Unkonwn Location"
        releaseYear = (try container.decodeIfPresent(String.self, forKey: .releaseYear)) ?? "Unknown Year"
        title = (try container.decodeIfPresent(String.self, forKey: .title)) ?? "Unknown Title"
    }
}
