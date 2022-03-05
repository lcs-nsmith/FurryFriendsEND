//
//  ContentView.swift
//  FurryFriends
//
//  Created by Russell Gordon on 2022-02-26.
//

import SwiftUI
import Foundation

struct ContentView: View {
    
    // MARK: Stored properties
    
    // Model for which the "DogPathEndpoint" is brought in
    // 'message' is the web URL stored as a string { property of "DogPathEndpoint"
    @State var path: DogPathEndpoint = DogPathEndpoint(message: "https://upload.wikimedia.org/wikipedia/commons/thumb/9/99/White_Background_%28To_id_screen_dust_during_cleanup%29.jpg/640px-White_Background_%28To_id_screen_dust_during_cleanup%29.jpg")
    //*link to blank white image 640 x 360*
    // so that the image the program loads before the one we actualy want is a blank
    
    // MARK: Computed properties
    
    var body: some View {
        
        VStack {
            
            // Shows the main image
            RemoteImageView(fromURL: URL(string: path.message)!)
            // Force unwrapped, will fail (and has failed) if there is no value that can be obtained
            
            // Push main image to top of screen
            Spacer()

        }
        // Runs once when the app is opened
        .task {
            await loadNewImage()
        }
        .navigationTitle("Furry Friends")
        
    }
    
    // MARK: Functions
    
    func loadNewImage() async {
        // Assemble the URL that points to the endpoint
        let url = URL(string: "https://dog.ceo/api/breeds/image/random")!
        
        // Defines the type of data I want from the endpoint
        // Configures the request to the website
        var request = URLRequest(url: url)
        // Asks for JSON data
        request.setValue("application/json",
                         forHTTPHeaderField: "Accept")
        
        // Start a session to interact with the endpoint
        let urlSession = URLSession.shared
        
        // Tries to fetch a new Image
        // It may not work, so there is a do-catch block
        do {
            
            // Get the raw data from the endpoint
            let (data, _) = try await urlSession.data(for: request)
            
            // Attempt to decode the raw data into a Swift structure
            // Takes what is in "data" and tries to put it into "path"
            //                                 DATA TYPE TO DECODE TO
            //                                         |
            //                                         V
            path = try JSONDecoder().decode(DogPathEndpoint.self, from: data)
            
        } catch {
            print("Could not retrieve or decode the JSON from endpoint.")
            // Print the contents of the "error" constant that the do-catch block populates
            print(error)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            ContentView()
        }
    }
}
