//
//  NewsResponse.swift
//  NewsJsonParser
//
//  Created by engrInzamamulhaq on 25/06/2020.
//  Copyright © 2020 Inzamam ul haq. All rights reserved.
//

import Foundation

struct NewsResponse : Codable {
    
    let rows : [News]?
    let title : String?
    
    enum CodingKeys: String, CodingKey {
        case rows = "rows"
        case title = "title"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        rows = try values.decodeIfPresent([News].self, forKey: .rows)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }
}
