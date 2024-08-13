//
//  DetailViewModel.swift
//  embrace-outdoors-ios
//
//  Created by David Rifkin on 8/13/24.
//

import Foundation

@Observable
class DetailViewModel {
    private let park: ParkRequestResult.Park
    
    var parkDescription: String {
        park.parkDescription
    }
    
    var parkName: String {
        park.parkName
    }
    
    init(park: ParkRequestResult.Park) {
        self.park = park
    }
}
