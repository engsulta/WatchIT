//
//  ApiManager.swift
//  WatchIT
//
//  Created by Sulta on 4/21/18.
//  Copyright © 2018 Sulta. All rights reserved.
//

import Foundation
import Alamofire

extension Notification.Name{
    static let movieChangeRadioChannel = Notification.Name("movieChangeRadioChannel")
}

class ApiManager : NSObject {
    
    static let MOVIES_KEY : String="results"
    var moviesArr:[Movie]=[Movie]()
    
    
    
    
    open func fetchAllfilms(url:String ){
        let url = URL(string: url)!
        Alamofire.request(url).responseJSON{
            response in
            if let movieJson = response.result.value {
                let responseObject:Dictionary = movieJson as! Dictionary<String,Any>
                let movieObjArr:[Dictionary] = responseObject["results"] as! [Dictionary<String,Any>]
                self.moviesArr.removeAll()
                for movie in movieObjArr {
                    
                    self.moviesArr.append(Movie(id: movie["id"] as! Int, title: movie["original_title"] as? String ?? "notitle", rating: movie["vote_average"] as! Double, viewCount: movie["vote_count"] as! Int, overview: movie["overview"] as? String ?? "", releaseDate: movie["release_date"] as! String, backDropPath: movie["backdrop_path"] as? String ?? "", poster: movie["poster_path"] as? String ?? ""))
                    
                }
                self.fetchAllKeys()
                
                NotificationCenter.default.post(name: Notification.Name.movieChangeRadioChannel, object: self, userInfo: ["movies" : self.moviesArr])
                
                
                
            }
            
        }
        
        
    }
    open func fetchAllKeys(){
        
        for movie in self.moviesArr{
            let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie.id)/videos?api_key=17573bb6e87afe885b35b2c812b40aa8")!
            Alamofire.request(url).responseJSON{
                response in
                if let trailerJson = response.result.value {
                    let responseObject:Dictionary = trailerJson as! Dictionary<String,Any>
                    let trailerObjArr:[Dictionary] = responseObject["results"] as? [Dictionary<String,Any>] ?? []
                    for trailer in trailerObjArr {
                        if (trailer["site"] as! String )=="YouTube"{//take first key only
                            // self.youtubeKey = trailer["key"] as! String
                            movie.trailerKey = trailer["key"] as? String
                            break
                        }
                        
                    }
                    
                }
                
            }
            
            
        }
        
    }
        
      
        
        
        
        
    }
    

