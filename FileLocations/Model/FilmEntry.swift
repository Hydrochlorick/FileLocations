//
//  FilmEntry.swift
//  FileLocations
//
//  Created by Rick Jacobson on 4/18/21.
//

import Foundation

struct FilmEntry {
    var firstActor: String
    var locations: String?
    var releaseYear: String
    var title: String
}

extension FilmEntry {
    init?(json: [String: Any]) {
        guard let a1 = json["actor_1"] as? String,
            let year = json["release_year"] as? String,
            let title = json["title"] as? String
            else {
                return nil
            }
        
        self.firstActor = a1
        self.releaseYear = year
        self.title = title
        self.locations = "locations"
    }
}
