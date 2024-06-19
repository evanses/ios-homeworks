import UIKit

protocol UserService {
    
    func check(with login: String) -> User?
    
}

class User {
    public var login: String
    public var fullName: String
    public var avatar: UIImage
    public var status: String
    
    init(login: String, fullName: String, avatar: UIImage, status: String) {
        self.login = login
        self.fullName = fullName
        self.avatar = avatar
        self.status = status
    }
}

final class CurrentUserService : UserService {
    var user: User?
    
    init() {
        //pass
    }
    
    func check(with login: String) -> User? {
        
        if login == "cat" {
            
            self.user = User(
                login: "cat",
                fullName: "Боец ММА KickCat",
                avatar: UIImage(resource: .avatar),
                status: "За вискас и двор..."
            )
            
        }
        
        return self.user
    }
    
}

final class TestUserService : UserService {
    var user: User?

    init() {
        //pass
    }
    
    func check(with login: String) -> User? {
        
        if login == "cat" {
            
            self.user = User(
                login: "testUser",
                fullName: "Тестовый кот",
                avatar: .emptyUserAvatar,
                status: "Мне бы стать настоящим"
            )

        }
        
        return self.user
    }
}
