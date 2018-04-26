//
//  ApiManager.swift
//  WatchIT
//
//  Created by Sulta on 4/21/18.
//  Copyright © 2018 Sulta. All rights reserved.
//

import Foundation
import Alamofire

class ApiManager : NSObject {
    static let MOVIES_KEY : String="results"
    var moviesArr:[Movie]=[Movie]()
    var myController:UICollectionViewController?
    
    @objc var doneStr:String?
    //        {
    //
    //        var moviesArrret:[Movie]=[Movie]()
    //
    //        let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=17573bb6e87afe885b35b2c812b40aa8&sort_by=popularity.desc")!
    //        Alamofire.request(url).responseJSON{
    //            response in
    //            if let movieJson = response.result.value {
    //                let responseObject:Dictionary = movieJson as! Dictionary<String,Any>
    //                let movieObjArr:[Dictionary] = responseObject["results"] as! [Dictionary<String,Any>]
    //                for movie in movieObjArr {
    //                    moviesArrret.append(Movie(id: movie["id"] as! Int, title: movie["original_title"] as! String, rating: movie["vote_average"] as! Double, viewCount: movie["vote_count"] as! Int, overview: movie["overview"] as! String, releaseDate: movie["release_date"] as! String, backDropPath: movie["backdrop_path"] as! String, poster: movie["poster_path"] as! String))
    //                }
    //
    //            }
    //
    //        }
    //        return moviesArrret
    //
    //
    //    }
    
    open func fetchAllfilms() -> [Movie]{
        let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=17573bb6e87afe885b35b2c812b40aa8&sort_by=popularity.desc")!
        Alamofire.request(url).responseJSON{
            response in
            if let movieJson = response.result.value {
                let responseObject:Dictionary = movieJson as! Dictionary<String,Any>
                let movieObjArr:[Dictionary] = responseObject["results"] as! [Dictionary<String,Any>]
                for movie in movieObjArr {
                    
                    self.moviesArr.append(Movie(id: movie["id"] as! Int, title: movie["original_title"] as! String, rating: movie["vote_average"] as! Double, viewCount: movie["vote_count"] as! Int, overview: movie["overview"] as! String, releaseDate: movie["release_date"] as! String, backDropPath: movie["backdrop_path"] as! String, poster: movie["poster_path"] as! String))
                    
                }
                self.fetchAllKeys()
                self.doneStr="done"
                (self.myController as! RecentMoviesController).updateUi(arr: self.moviesArr)
                //                DispatchQueue.main.sync{
                //
                //                }
                
                
            }
            
        }
        
        return moviesArr
    }
    open func fetchAllKeys(){
        
        for movie in self.moviesArr{
            let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie.id)/videos?api_key=17573bb6e87afe885b35b2c812b40aa8")!
            Alamofire.request(url).responseJSON{
                response in
                if let trailerJson = response.result.value {
                    let responseObject:Dictionary = trailerJson as! Dictionary<String,Any>
                    let trailerObjArr:[Dictionary] = responseObject["results"] as! [Dictionary<String,Any>]
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
//
//    func getTrailerForMovie(movieKey:Int,movieIndex:Int){
//
//        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieKey)/videos?api_key=17573bb6e87afe885b35b2c812b40aa8")!
//        Alamofire.request(url).responseJSON{
//            response in
//
//            if let trailerJson = response.result.value {
//                let responseObject:Dictionary = trailerJson as! Dictionary<String,Any>
//                let trailerObjArr:[Dictionary] = responseObject["results"] as! [Dictionary<String,Any>]
//                for trailer in trailerObjArr {
//                    if (trailer["site"] as! String )=="YouTube"{//take first key only
//                        // self.youtubeKey = trailer["key"] as! String
//                        self.moviesArr[movieIndex].posterPath = trailer["key"] as? String
//                        break
//                    }
//                    
//                }
//
//            }
//
//        }
//
//    }
//
//
//
}
