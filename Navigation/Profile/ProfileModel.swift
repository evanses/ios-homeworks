import Foundation

enum State {
    case initial
    case loaded
    case error
}

protocol ProfileVMOutput {
    var state: State { get set }
    var fetchedUser: User? { get }
    
    func fetchUserInfo()
}

final class ProfileVM : ProfileVMOutput {
    
    private var user: User
    
    var fetchedUser: User?
    
    var state: State = .initial {
        didSet {
            print("Changed state -> \(state)")
        }
    }
    
    init(user: User) {
        self.user = user
    }
    
    func fetchUserInfo() {
        /// запрос к какой-нибудь апи для получения инфы о пользователе
        
        self.fetchedUser = self.user
        
        state = .loaded
    }
}
