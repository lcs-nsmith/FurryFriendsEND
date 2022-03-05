//
//  FavouritesListView.swift
//  FurryFriends
//
//  Created by Nathan Smith on 2022-03-05.
//

import SwiftUI

struct FavouritesListView: View {
    var body: some View {
        List {
            Group {
                ProgressView()
                ProgressView()
                ProgressView()
                ProgressView()
                ProgressView()
                ProgressView()
                ProgressView()
                ProgressView()
                ProgressView()
                ProgressView()
            }
            Group {
                ProgressView()
                ProgressView()
                ProgressView()
                ProgressView()
                ProgressView()
                ProgressView()
                ProgressView()
            }
        }
    }
}

struct FavouritesListView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesListView()
    }
}
