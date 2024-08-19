import FirebaseCore
import FirebaseAuth

enum LoginError: Error {
    case invalidCreds
    case invalidEmail
    
    var description: String {
        switch self {
        case .invalidCreds:
            return "Введеные логин или пароль неверные"
        case .invalidEmail:
            return "Неверный формат почты"
        }
    }
}

enum SingupError: Error {
    case emailAlreadyInUse
    case invalidEmail
    case smthWentWrong
    case wrongPassword
    
    var description: String {
        switch self {
        case .emailAlreadyInUse:
            return "Пользователь с таким email уже существует"
        case .invalidEmail:
            return "Что-то не так с почтой"
        case .smthWentWrong:
            return "Что-то пошло не так"
        case .wrongPassword:
            return "Пароль не соответствует требованиям"
        }
    }
}

protocol CheckerServiceProtocol {
    func checkCredentials(login: String, pass: String, completion: @escaping((Result<Bool, LoginError>) -> Void))
    
    func signUp(login: String, pass: String, completion: @escaping((Result<Bool, SingupError>) -> Void))
}

class CheckerService: CheckerServiceProtocol {
    
    func checkCredentials(login: String, pass: String, completion: @escaping((Result<Bool, LoginError>) -> Void)) {
        FirebaseAuth.Auth.auth().signIn(withEmail: login, password: pass) { (authResult, error) in
            if let error = error as? NSError {
                
                print(error)
                
                switch AuthErrorCode(rawValue: error.code) {
                case .invalidCredential:
                    completion(.failure(.invalidCreds))
                case .invalidEmail:
                    completion(.failure(.invalidEmail))
                default:
                    completion(.failure(.invalidCreds))
                }
            } else {
                print("User signs in successfully")
                completion(.success(true))
            }
        }
    }
    
    func signUp(login: String, pass: String, completion: @escaping((Result<Bool, SingupError>) -> Void)) {
        Auth.auth().createUser(withEmail: login, password: pass) { authResult, error in
            if let error = error as? NSError {
                
                print(error)
                
                switch AuthErrorCode(rawValue: error.code) {
                case .emailAlreadyInUse:
                    completion(.failure(.emailAlreadyInUse))
                case .invalidEmail:
                    completion(.failure(.invalidEmail))
                case .weakPassword:
                    completion(.failure(.wrongPassword))
                default:
                    completion(.failure(.smthWentWrong))
                }
            } else {
                print("User signs up successfully")
                completion(.success(true))
            }
        }
    }
}
