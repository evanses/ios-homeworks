import FirebaseAuth

struct LoginInspector : LoginViewControllerDelegate {
    
    func check(with login: String, and password: String, completion: @escaping((Result<User, LoginError>) -> Void)) {
        let checkerService = CheckerService()
        checkerService.checkCredentials(login: login, pass: password) { result in
            switch result {
            case .success(true):
                
                let user = User(
                    login: (FirebaseAuth.Auth.auth().currentUser?.email)!,
                    fullName: (FirebaseAuth.Auth.auth().currentUser?.email)!,
                    avatar: UIImage(resource: .avatar),
                    status: "Я пришел с Firebase!"
                )
                
                completion(.success(user))
                
            case .failure(.invalidEmail):
                completion(.failure(.invalidEmail))
            case .failure(.invalidCreds):
                completion(.failure(.invalidCreds))
            default:
                completion(.failure(.invalidCreds))
            }
        }
    }
    
    func singUp(with login: String, and password: String, completion: @escaping((Result<Bool, SingupError>) -> Void)) {
        let checkerService = CheckerService()
        checkerService.signUp(login: login, pass: password) { result in
            switch result {
                
            case .success(true):
                completion(.success(true))
                
            case .failure(.emailAlreadyInUse):
                completion(.failure(.emailAlreadyInUse))
                
            case .failure(.invalidEmail):
                completion(.failure(.invalidEmail))
                
            case .failure(.wrongPassword):
                completion(.failure(.wrongPassword))
                
            default:
                completion(.failure(.smthWentWrong))
            }
        }
    }
}

protocol LoginFactory {
    
    func makeLoginInspector() -> LoginInspector
    
}

struct MyLoginFactory : LoginFactory {
    
    func makeLoginInspector() -> LoginInspector {
        LoginInspector()
    }
}
