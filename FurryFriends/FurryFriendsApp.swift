//
//  FurryFriendsApp.swift
//  FurryFriends
//
//  Created by Russell Gordon on 2022-02-26.
//

import SwiftUI

@main
struct FurryFriendsApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                DogsView()
                    .tabItem {
                        Image("dogIcon")
                            .resizable()
                            .frame(width: 1, height: 1, alignment: .center)
                        Text("Dogs")
                    }
                CatsView()
                    .tabItem {
                        Image("catIcon")
                        Text("Cats")
                    }
            }
        }
    }
}
