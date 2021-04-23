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
    var releaseYear: MultiType
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
        releaseYear = (try container.decodeIfPresent(MultiType.self, forKey: .releaseYear)) ?? MultiType.string("Unknown Year")
        title = (try container.decodeIfPresent(String.self, forKey: .title)) ?? "Unknown Title"
    }
}

enum MultiType: Codable {
    func encode(to encoder: Encoder) throws {
        
    }
    
    case int(Int)
    case string(String)
    
    init(from decoder: Decoder) throws {
        if let intValue = try? decoder.singleValueContainer().decode(Int.self){
            self = .int(intValue)
            return
        }
        if let stringValue = try? decoder.singleValueContainer().decode(String.self){
            self = .string(stringValue)
            return
        }
        throw MultiType.missingValue
    }
    enum MultiType: Error {
        case missingValue
    }
}

extension MultiType {
    var value: String {
        switch self {
        case .int(let intValue):
            return String(intValue)
        case .string(let stringValue):
            return stringValue
        }
    }
}
