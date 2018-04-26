//
//  Movie.swift
//  WatchIT
//
//  Created by Sulta on 4/20/18.
//  Copyright © 2018 Sulta. All rights reserved.
//

import Foundation
class Movie: NSObject {
    var title : String?
    var rating : Double?
    var id : Int
    var viewCount:Int?
    var popularity:Double?
    var generIds:[Int]=[Int]()
    var overview: String?
    var releaseDate:String?
    var backDropPath:String?
    var trailerKey:String?
    var posterPath:String?
    
   
    init(id:Int,title:String,rating:Double,viewCount:Int,overview:String,releaseDate:String,backDropPath:String,poster:String) {
        self.id = id
        self.title = title
        self.rating = rating
        self.backDropPath = backDropPath
        self.posterPath = poster
        self.releaseDate = releaseDate
        self.viewCount = viewCount
        self.overview = overview
}
    
}
