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
        ZStack {
            // page background
            Color("ListColour")
                .ignoresSafeArea()
            
            // page foregound
            VStack {
                HStack {
                    
                    // Pushes button to the right side of the screen
                    Spacer()
                    
                    Button(action: {
                        Task {
                            // removes all items from favourites list
                            favourites.removeAll()
                        }
                    }, label: {
                        Text("Clear Favourites") // Text displayed on the button
                            .font(.title2)
                    })
                    .buttonStyle(.borderedProminent)
                    .tint(Color("Primary")) // button colour
                    .foregroundColor(Color("Tertiary")) // text colour
                    .padding()
                    .padding(.top, 25) // extra padding on top to bring the button out of the safe area
                }
                
                // Iterates list of favourites
                // currentFavourite allows individual 'favourites' to be accessed
                List(favourites, id: \.self) { currentFavourite in
                    // Wraps string to URL
                    RemoteImageView(fromURL: URL(string: currentFavourite.message)!)
                }
            }
            .ignoresSafeArea() // the vstack extends past the edges of the safe area
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
