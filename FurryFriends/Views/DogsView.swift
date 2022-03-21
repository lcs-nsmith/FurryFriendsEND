//
//  DogsView.swift
//  FurryFriends
//
//  Modified by Nathan Smith on 2022-03-05.
//

import SwiftUI

struct DogsView: View {
    
    // MARK: Stored properties
    // Model for which the "DogPathEndpoint" is brought in
    // 'message' is the web URL stored as a string { property of "DogPathEndpoint"
    @State var path: DogPathEndpoint = DogPathEndpoint(message: "https://upload.wikimedia.org/wikipedia/commons/thumb/9/99/White_Background_%28To_id_screen_dust_during_cleanup%29.jpg/640px-White_Background_%28To_id_screen_dust_during_cleanup%29.jpg")
    //*link to blank white image 640 x 360*
    // so that the image the program loads before the one we actualy want is a blank
    
    // Keeps track of favourites
    @Binding var favourites: [DogPathEndpoint]
    
    // Detect when the app changes states (background, foreground, inactive)
    @Environment(\.scenePhase) var scenePhase
    
    // Relative to whether the app has just started
    @State var isIntialStartup: Bool = true
    
    // MARK: Computed properties
    var body: some View {
        ZStack {
            
            // page background
            Color("ListColour")
                .ignoresSafeArea()
            
            // page foreground
            VStack() {
                // Shows the main image
                RemoteImageView(fromURL: URL(string: path.message)!)
                // Force unwrapped, will fail if there is no value that can be obtained
                
                HStack {
                    Button(action: {
                        Task {
                            // Calls function that loads a new photo
                            await loadNewImage()
                        }
                    }, label: {
                        Text("Show me another dog!") // Text displayed on the button
                            .font(.title2)
                    })
                    .buttonStyle(.borderedProminent)
                    .tint(Color("Primary")) // button colour
                    .foregroundColor(Color("Tertiary")) // text colour
                    .padding()
                    
                    Image(systemName: "heart.circle")
                        .resizable()
                        .frame(width: 40, height: 40)
                    // if the current image is in the favourites, then change the foregorund colour to red, if not, then the button colour should be secondary (gray)
                        .foregroundColor(favourites.contains(path) == true ? .red : .secondary)
                        .onTapGesture {
                            // if the current image is not in the favourites already, append it to the favourites
                            if favourites.contains(path) == false {
                                favourites.append(path)
                            }
                        }
                }
            }
        }
        // Runs once when the app is opened
        .task {
            // If the app has just started, load a new image
            if isIntialStartup == true {
                await loadNewImage()
                
                //  Loads the favourites saved in local storage
                await loadFavourites()
            }
            // set 'isIntialSetup' to false so that a new image is now loaded when the user switches so a different tab and comes back
            isIntialStartup = false
        }
        // Peforms a function when the app state changes (foreground, background, inactive)
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .inactive {
                print("inactive")
            } else if newPhase == .active {
                print("active")
            } else {
                print("background")
                persistFavourites()
            }
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
    
    // Saves the the data to local storage
    func persistFavourites() {
        // Get a location to save the data
        let filename = getDocumentDirectory()
            .appendingPathComponent(savedFavouritesLabel)
        
        // Tries to encode the data in the list of favourites to JSON format
        do {
            let encoder = JSONEncoder()
            
            // Directs the encoder to format the output as 'pretty print', meaning that it is easily readable by humans
            encoder.outputFormatting = .prettyPrinted
            
            // Encodes the list of favourites
            let data = try encoder.encode(favourites)
            
            // Writes the JSON formatted data to a file in the filename location derived in 'getDocumentDirectory'
            // .atomicWrite means the write will either succeed or fail, it won't write part of a file
            // .completeFileProtection means that the data will be encrypted
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
            
            // Diagnostics
            print("* data write successful *")
            print("=============")
            print(String(data: data, encoding: .utf8)!)
        } catch {
            // Diagnostics
            print("* error writing data *")
            print("=============")
            print(error.localizedDescription)
        }
    }
    
    // Loads the data saved in local storage
    func loadFavourites() async {
        // Gets the location for where the data is saved
        let filename = getDocumentDirectory()
            .appendingPathComponent(savedFavouritesLabel)
        
        // Attempts to load the data from local storage
        do {
            // Load the RAW data from local storage
            let data = try  Data(contentsOf: filename)
            
            // Decodes the RAW data to a data structure native to swift
            favourites = try JSONDecoder().decode([DogPathEndpoint].self, from: data)
            
            // Diagnostics
            print("* read data from the documents directory with success *")
            print("=============")
            print(String(data: data, encoding: .utf8)!)
        } catch {
            // Diagnostics
            print("* error fetching stored data *")
            print("=============")
            print(error.localizedDescription)
        }
    }
}

struct DogsView_Previews: PreviewProvider {
    // variable allows preview to run
    @State static var temp: [DogPathEndpoint] = []
    static var previews: some View {
        // you need to pass a property for favourites, It needs to be a binding and it needs to be a [DogPathEndpoint].type, the easiest way to do this is by making the 'temp' variable
        DogsView(favourites: $temp)
    }
}
