//
//  FavouritesListView.swift
//  FurryFriends
//
//  Created by Nathan Smith on 2022-03-05.
//

import SwiftUI

struct FavouritesListView: View {
    // MARK: Stored Properties
    
    // Keeps track of favourites, binded to the *central* favourite list in "FurryFriendsApp"
    @Binding var favourites: [DogPathEndpoint]
    
    // MARK: Computed Properties
    var body: some View {
        // Iterates list of favourites
        // currentFavourite allows individual 'favourites' to be accessed
        List(favourites, id: \.self) { currentFavourite in
                                    // Wraps string to URL
            RemoteImageView(fromURL: URL(string: currentFavourite.message)!)
        }
    }
}

struct FavouritesListView_Previews: PreviewProvider {
    // variable allows preview to run
    @State static var huron: [DogPathEndpoint] = []
    static var previews: some View {
        // you need to pass a property for favourites, It needs to be a binding and it needs to be a [DogPathEndpoint].type, the easiest way to do this is by making the 'temp' variable
        FavouritesListView(favourites: $huron)
    }
}
