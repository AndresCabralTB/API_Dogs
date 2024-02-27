import SwiftUI

struct ContentView: View {
    
    @State var dogs: [String] = []
    @State var searchDogs = ""
    
    var body: some View {
        VStack {
            NavigationView {
                List(dogs, id: \.self) { imageUrl in
                    AsyncImage(url: URL(string: imageUrl)) { image in
                        image.resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                }
                .navigationTitle("Dogs")

                //10,implementamos el search bar
                .searchable(text: $searchDogs, prompt: "Search Fruit")
                .task{
                    dogs = await getImages(for: searchDogs)
                }
                }
            }
        }
    }
    
    func getImages(for breed: String) async -> [String] {
        guard !breed.isEmpty else { return [] }
        
        let url = URL(string: "https://dog.ceo/api/breed/\(breed)/image")!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let response = try decoder.decode(DogImageResponse.self, from: data)
            return response.message
        } catch {
            print("Error fetching images: \(error)")
            return []
        }
    }

struct DogImageResponse: Codable {
    let message: [String]
    let status: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
