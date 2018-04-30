//
//  CoreDataManager.swift
//  WatchIT
//
//  Created by Sulta on 4/21/18.
//  Copyright © 2018 Sulta. All rights reserved.
//

import Foundation
import CoreData


extension Notification.Name{
    static let favouriteChangeRadioChannel = Notification.Name("favouriteChangeRadioChannel")
}


class CoreDataManager {
    var movies : [NSManagedObject] = [NSManagedObject]()
    var label :String?
    var retMovies:[Movie]=[Movie]()

    
    
    func fetchallMovies(appDelegate:AppDelegate)-> [Movie]{
        //2
        let managedContext = appDelegate.persistentContainer.viewContext
        
        
        //3
        let request = NSFetchRequest<NSManagedObject>(entityName: "MEntity")
        DispatchQueue.global(qos: .default).async {
            do{
                try  self.movies =  managedContext.fetch(request)
                for movie in self.movies{
                    //print (movie.value(forKey: "overview") ?? "nil"  )
                    if movie.value(forKey: "overview") != nil {
                        self.retMovies.append(Movie(id: movie.value(forKey: "id") as! Int , title: movie.value(forKey: "title") as! String, rating: movie.value(forKey: "rating") as! Double, viewCount: movie.value(forKey: "viewCount") as! Int, overview: movie.value(forKey: "overview")as! String, releaseDate: movie.value(forKey: "releaseDate") as! String, backDropPath: movie.value(forKey: "backDropPath")as! String, poster: movie.value(forKey: "posterPath")as! String))
                    }
                }
//                NotificationCenter.default.post(name: Notification.Name.favouriteChangeRadioChannel, object: self, userInfo: ["movies" : self.retMovies])
                
                NSLog("%@","fetched done" )
                
            }catch{
                
                
            }
            DispatchQueue.main.async {
                print("This is run on the main queue, after the previous code in outer block")
            }
        }
        do{
            try  movies =  managedContext.fetch(request)
            for movie in movies{
                //print (movie.value(forKey: "overview") ?? "nil"  )
                if movie.value(forKey: "overview") != nil {
                 retMovies.append(Movie(id: movie.value(forKey: "id") as! Int , title: movie.value(forKey: "title") as! String, rating: movie.value(forKey: "rating") as! Double, viewCount: movie.value(forKey: "viewCount") as! Int, overview: movie.value(forKey: "overview")as! String, releaseDate: movie.value(forKey: "releaseDate") as! String, backDropPath: movie.value(forKey: "backDropPath")as! String, poster: movie.value(forKey: "posterPath")as! String))
               }
            }
              NotificationCenter.default.post(name: Notification.Name.favouriteChangeRadioChannel, object: self, userInfo: ["movies" : self.retMovies])
            
            NSLog("%@","fetched done" )
            
        }catch{
            
            
        }
        return retMovies
        
        }
    
    func addMovie( movie:Movie ,appDelegate:AppDelegate) {
       
       
        
        //2
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //3
        let entity = NSEntityDescription.entity(forEntityName: "MEntity", in: managedContext)
        
        //4
        let movieObject  = NSManagedObject(entity: entity!, insertInto: managedContext)
        //5
        movieObject.setValue(movie.title, forKey: "title")
        movieObject.setValue(movie.rating, forKey: "rating")
        movieObject.setValue(movie.id, forKey: "id")
        movieObject.setValue(movie.viewCount, forKey: "viewCount")
        movieObject.setValue(movie.releaseDate, forKey: "releaseDate")
        movieObject.setValue(movie.posterPath, forKey: "posterPath")
        movieObject.setValue(movie.backDropPath, forKey: "backDropPath")
        do{
            try   managedContext.save()
            NSLog("%@","done")
            
        }catch{
            
            print("Error")
            NSLog("%@","done")
            
        }
                
    }
}
