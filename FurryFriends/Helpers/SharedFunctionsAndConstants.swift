//
//  SharedFunctionsAndConstants.swift
//  FurryFriends
//
//  Created by Nathan Smith on 2022-03-08.
//

import Foundation

// Return the location of the documents directory for this application
func getDocumentDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    // Return the first path of the array
    return paths[0]
}

// defines the directory label where the data is saved
let savedFavouritesLabel = "savedFavourites"
