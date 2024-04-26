import UIKit

struct Photo {
    let fileName: String
}

extension Photo {
    
    static func make() -> [Photo] {
        var list: [Photo] = []
        for i in 0...20 {            
            list.append(
                Photo(fileName: "photos/\(i)")
            )
        }
        
        return list
    }
}
