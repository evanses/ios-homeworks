struct LoginInspector : LoginViewControllerDelegate {
    
    func check(with login: String, and password: String) -> Bool {
        Checker.shared.check(with: login, and: password)
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
