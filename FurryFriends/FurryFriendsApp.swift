//
//  FurryFriendsApp.swift
//  FurryFriends
//
//  Created by Russell Gordon on 2022-02-26.
//

import SwiftUI

@main
struct FurryFriendsApp: App {
    
    //MARK: Computed Properties
    var body: some Scene {
        WindowGroup {
            // Displays the views in tabs
            TabView {
                DogsView()
                    // The 'label' of the tab
                    .tabItem {
                        //Custom icon of dog
                        Image("dogIcon")
                        Text("Dogs")
                    }
                CatsView()
                    // The 'label' of the tab
                    .tabItem {
                        //Custom icon of cat
                        Image("catIcon")
                        Text("Cats")
                    }
            }
        }
    }
}
