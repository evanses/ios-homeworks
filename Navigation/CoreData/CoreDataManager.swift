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
        container.viewContext.automaticallyMergesChangesFromParent = true
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
        
        persistentContainer.viewContext.perform {
            print("updated! in savedPost = \(savedPost.count)")
        }
    
        return posts
    }
    
    func findPosts(by author: String) -> [Post]{
        let predicate = NSPredicate(format: "author CONTAINS[cd] %@", author)
        let fetchRequest = NSFetchRequest<SavedPost>(entityName: "SavedPost")
        fetchRequest.predicate = predicate
        var posts: [Post] = []
        
        do {
            let res = try persistentContainer.viewContext.fetch(fetchRequest)
            res.forEach { post in
                guard let author = post.author, let desc = post.desc, let image = post.image else {
                    return
                }
                
                let newPost = Post(author: author, description: desc, image: image, likes: Int(post.likes), views: Int(post.views))
                
                posts.append(newPost)
            }
        } catch let error {
            print("Error fetching data:\(error.localizedDescription)")
            return []
        }
        
        return posts
    }
    
    func add2Favorite(post: Post) {
        persistentContainer.performBackgroundTask { backContext in
            let fPost = SavedPost(context: backContext)
            fPost.author = post.author
            fPost.desc = post.description
            fPost.image = post.image
            fPost.likes = Int64(post.likes)
            fPost.views = Int64(post.views)
            
            try? backContext.save()
        }
    }
    
    func removeFromFavorites(with savedPost: SavedPost) {
        persistentContainer.performBackgroundTask { backContext in
            let postToDelete = backContext.object(with: savedPost.objectID)
            
            backContext.delete(postToDelete)
            try? backContext.save()
        }
    }
}
