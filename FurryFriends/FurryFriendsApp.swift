//
//  FurryFriendsApp.swift
//  FurryFriends
//
//  Created by Russell Gordon on 2022-02-26.
//

import SwiftUI

@main
struct FurryFriendsApp: App {
    // MARK: Stored Properties
    
    // The list of favourites
    @State private var favouriteList: [DogPathEndpoint] = []
    
    // MARK: Computed Properties
    var body: some Scene {
        WindowGroup {
                
            // Displays the views in tabs
            TabView {
                
                // Passing in 'favouriteList' into the 'favourites' variable in the view
                DogsView(favourites: $favouriteList)
                // The 'label' of the tab
                    .tabItem {
                        //Custom icon of dog
                        Image("dogIcon")
                        Text("Dogs")
                    }
                
                /// Removed the CatView becuase the endpoint is not working
            //  CatsView()
//             // The 'label' of the tab
//                   .tabItem {
//                      //Custom icon of cat
//                       Image("catIcon")
                //       Text("Cats")
                //   }
                
                // Passing in 'favouriteList' into the 'favourites' variable in the view
                FavouritesListView(favourites: $favouriteList)
                // The 'label' of the tab
                    .tabItem {
                        Image(systemName: "heart.text.square") // favourites icon
                        Text("Favourites")
                    }
            }
        }
    }
}
