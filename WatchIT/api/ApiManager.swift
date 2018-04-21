//
//  ApiManager.swift
//  WatchIT
//
//  Created by Sulta on 4/21/18.
//  Copyright © 2018 Sulta. All rights reserved.
//

import Foundation
import Alamofire

class ApiManager{
    static let MOVIES_KEY : String="results"
    var moviesArr:[Movie]=[Movie]()
    
    public func fetchAllfilms() -> [Movie]{
        let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=17573bb6e87afe885b35b2c812b40aa8&sort_by=popularity.desc")!
        Alamofire.request(url).responseJSON{
            response in
            if let movieJson = response.result.value {
                let responseObject:Dictionary = movieJson as! Dictionary<String,Any>
                let movieObjArr:[Dictionary] = responseObject["results"] as! [Dictionary<String,Any>]
                for movie in movieObjArr {
                    self.moviesArr.append(Movie(id: movie["id"] as! Int, title: movie["original_title"] as! String, rating: movie["vote_average"] as! Double, viewCount: movie["vote_count"] as! Int, overview: movie["overview"] as! String, releaseDate: movie["release_date"] as! String, backDropPath: movie["backdrop_path"] as! String, poster: movie["poster_path"] as! String))
                }
                
            }
            
        }
            return moviesArr
        }
        
    
    
}
