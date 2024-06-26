class Checker {
    
    static let shared = Checker()
    
    private let login: String = "cat"
    private let password: String = "qwerty123"
    
    private init() { }
    
    func check(with login: String, and password: String) -> Bool {
        
        if login == self.login && password == self.password {
            return true
        }
        
        return false
    }
}
