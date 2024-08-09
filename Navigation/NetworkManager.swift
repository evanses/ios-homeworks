import Foundation

enum AppConfiguration: String {
    case people = "https://swapi.dev/api/people/8"
    case starships = "https://swapi.dev/api/starships/3"
    case planets = "https://swapi.dev/api/planets/5"
}

enum NetworkError: Error {
    case noData
    case parsingError
    case notInternet
    case responseError
    case smthWentWrong
    
    var description: String {
        switch self {
        case .noData:
            return "Нет данных"
        case .parsingError:
            return "Ошиюка парсинга данных"
        case .notInternet:
            return "Нет интернета"
        case .responseError:
            return "Неверный ответ сервера"
        case .smthWentWrong:
            return "Что-то пошло не так"
        }
    }
}

struct NetUser: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}

struct PlanetInfo: Decodable {
    let orbitalPeriod: String
    
    private enum CodingKeys: String, CodingKey {
        case orbitalPeriod = "orbital_period"
    }
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    func getUser(by id: Int, completion: @escaping ((Result<String, NetworkError>) -> Void)) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos/\(id)") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
        
            if let error = error {
                completion(.failure(.notInternet))
                print(error.localizedDescription)
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                completion(.failure(.responseError))
                return
            }
            
            guard let data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                guard let user = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    completion(.failure(.smthWentWrong))
                    return
                }
                
                guard let userTitle = user["title"] as? String else {
                    completion(.failure(.smthWentWrong))
                    return
                }
                
                completion(.success(userTitle))
                
            } catch {
                completion(.failure(.parsingError))
            }
            
        }.resume()
        
    }
    
    func getPlanetOrbitalPeriod(completion: @escaping ((Result<String, NetworkError>) -> Void)) {
        guard let url = URL(string: "https://swapi.dev/api/planets/1") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
        
            if let error {
                completion(.failure(.notInternet))
                print(error.localizedDescription)
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                completion(.failure(.responseError))
                return
            }
            
            guard let data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let answer = try JSONDecoder().decode(PlanetInfo.self, from: data)
                
                completion(.success(answer.orbitalPeriod))
                
            } catch {
                completion(.failure(.parsingError))
            }
            
        }.resume()
        
    }
    
    func request(for configuration: AppConfiguration) {
        
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
