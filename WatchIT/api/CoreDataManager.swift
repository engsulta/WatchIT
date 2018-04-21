//
//  CoreDataManager.swift
//  WatchIT
//
//  Created by Sulta on 4/21/18.
//  Copyright © 2018 Sulta. All rights reserved.
//

import Foundation
import CoreData
class CoreDataManager {
    var movies : [NSManagedObject] = [NSManagedObject]()
    
    func fetchallMovies(appDelegate:AppDelegate)-> [Movie]{
        var retMovies:[Movie]=[Movie]()
        
        //2
        let managedContext = appDelegate.persistentContainer.viewContext
        
        
        //3
        let request = NSFetchRequest<NSManagedObject>(entityName: "MovieEntity")
        
        do{
            try  movies =  managedContext.fetch(request)
            for movie in movies{
                retMovies.append(Movie(id: movie.value(forKey: "id") as! Int, title: movie.value(forKey: "title")as! String, rating: movie.value(forKey: "rating") as! Double, viewCount: movie.value(forKey: "viewCount")as! Int, overview: movie.value(forKey: "overview")as! String, releaseDate: movie.value(forKey: "releaseDate") as! String, backDropPath: movie.value(forKey: "backDropPath")as! String, poster: movie.value(forKey: "posterPath")as! String))
            }
            
            NSLog("%@","fetched done" )
            
        }catch{
            
            
        }
        return retMovies
        
        }
    
    func addMovie( movie:Movie ,appDelegate:AppDelegate) {
       
       
        
        //2
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //3
        let entity = NSEntityDescription.entity(forEntityName: "MovieEntity", in: managedContext)
        
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
