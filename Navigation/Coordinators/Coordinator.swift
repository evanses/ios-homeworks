import UIKit

protocol Coordinator: AnyObject {
    var coordinators: [Coordinator] { get set }
}
