//
//  CoreDataManager.swift
//  Navigation
//
//  Created by eva on 31.08.2024.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {
        
    }
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func fetchFavoritePosts() -> [Post] {
        let req = SavedPost.fetchRequest()
        let savedPost = (try? persistentContainer.viewContext.fetch(req)) ?? []
        
        var posts: [Post] = []
        
        savedPost.forEach { post in
            guard let author = post.author, let desc = post.desc, let image = post.image else {
                return
            }
            
            let newPost = Post(author: author, description: desc, image: image, likes: Int(post.likes), views: Int(post.views))
            
            posts.append(newPost)
        }
        
        return posts
    }
    
    func add2Favorite(post: Post) {
        let fPost = SavedPost(context: persistentContainer.viewContext)
        fPost.author = post.author
        fPost.desc = post.description
        fPost.image = post.image
        fPost.likes = Int64(post.likes)
        fPost.views = Int64(post.views)
        
        try? persistentContainer.viewContext.save()
    }
    
    func removeFromFavorites(post: SavedPost) {
        let context = post.managedObjectContext
        context?.delete(post)
        try? context?.save()
    }
}
