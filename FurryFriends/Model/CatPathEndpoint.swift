//
//  CatPathEndpoint.swift
//  FurryFriends
//
//  Created by Nathan Smith on 2022-03-05.
//

import Foundation


// Allows for the decoding, encoding, and hashing of this structure
struct CatPathEndpoint: Decodable, Hashable, Encodable {
    
    // The web URL of the image, stored as a string
    var file: String
}
