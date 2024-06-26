import UIKit

protocol UserService {
    var user: User { get set }
    
    func getUser(with login: String) -> User?
}

extension UserService {
    func getUser(with login: String) -> User? {
        return login == user.login ? user : nil
    }
}

class User {
    var login: String
    var fullName: String
    var avatar: UIImage
    var status: String
    
    init(login: String, fullName: String, avatar: UIImage, status: String) {
        self.login = login
        self.fullName = fullName
        self.avatar = avatar
        self.status = status
    }
}

final class CurrentUserService : UserService {
    var user = User(
        login: "cat",
        fullName: "Боец ММА KickCat",
        avatar: UIImage(resource: .avatar),
        status: "За вискас и двор..."
    )

    
    init() {
        //pass
    }

}

final class TestUserService : UserService {
    var user = User(
        login: "cat",
        fullName: "Тестовый кот",
        avatar: .emptyUserAvatar,
        status: "Мне бы стать настоящим"
    )

    init() {
        //pass
    }
    
}
