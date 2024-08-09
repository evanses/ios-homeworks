import Foundation

enum AppConfiguration: String {
    case people = "https://swapi.dev/api/people/8"
    case starships = "https://swapi.dev/api/starships/3"
    case planets = "https://swapi.dev/api/planets/5"
}

struct NetworkManager {
    
    static func request(for configuration: AppConfiguration) {
        
        guard let url = URL(string: configuration.rawValue) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                print("Some error:")
                print(error.localizedDescription)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) else {
                print("no valid status code")
                return
            }
            
            guard let data else {
                print("no valid data")
                return
            }
            
            print("headers:")
            print(response.allHeaderFields)
            
            print("data:")
            print(String(data: data, encoding: .utf8))
            
        }.resume()
    }
    
}
