//
//  ParkRequestResult.swift
//  embrace-outdoors-ios
//
//  Created by David Rifkin on 8/13/24.
//

import Foundation

struct ParkRequestResult: Codable {
    let total: String
    let limit: String
    let data: [Park]
    
    struct Park: Codable {
        let url: String
        let fullName: String
        let parkCode: String
        let description: String
        let latitude: String
        let longitude: String
    }
}

extension ParkRequestResult.Park {
    var parkDescription: String {
        self.description
    }
    
    var parkName: String {
        self.fullName
    }
}

