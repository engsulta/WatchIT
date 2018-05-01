
//
//  DetailsViewController.swift
//  WatchIT
//
//  Created by Sulta on 4/20/18.
//  Copyright © 2018 Sulta. All rights reserved.
//

import UIKit
import SDWebImage
class DetailsViewController: UIViewController {
    var movie:Movie?
    var coredata:CoreDataManager=CoreDataManager()
    @IBAction func addToFav(_ sender: UIButton) {
        if  coredata.addToFavorite(movie: movie!) == true {
        //coredata.addMovie(movie: movie!, appDelegate: UIApplication.shared.delegate as! AppDelegate)
        self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func donePressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var doneAction: UIBarButtonItem!
   
    @IBAction func watchOnYouTube(_ sender: UIButton) {
        //let trailerUrl:String="https://youtube.com/watch?v="+(movie?.trailerKey)!
       // let youtubeurl = URL(string: trailerUrl)
        let youtubeId = movie?.trailerKey
        var youtubeUrl = URL(string:"youtube://"+youtubeId!)!
        if UIApplication.shared.canOpenURL(youtubeUrl){
            UIApplication.shared.open(youtubeUrl, options: [:], completionHandler:{ res in })
        } else{
            youtubeUrl = URL(string:"https://www.youtube.com/watch?v="+youtubeId!+".com")!
            //UIApplication.shared.openURL(youtubeUrl)
        UIApplication.shared.open(youtubeUrl, options: [:], completionHandler:{ res in })

        }
    }
    @IBOutlet weak var moviePosterRepeated: UIImageView!
    @IBOutlet weak var movieOverView: UITextView!
    @IBOutlet weak var movieGenres: UILabel!
    @IBOutlet weak var movieDuration: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieViewCount: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTitle.text=movie?.title
        movieRating.text=movie?.rating?.description
        movieViewCount.text=movie?.viewCount?.description
        let imageurl:String="https://image.tmdb.org/t/p/w500" + (self.movie?.posterPath)!
        let url = URL(string: imageurl)
        moviePoster.__sd_setImage(with: url)
        moviePosterRepeated.__sd_setImage(with: url)
        movieOverView.text=movie?.overview
        movieGenres.text="Animaiton|Action"
        movieDuration.text="1h:30min"
    movieYear.text=movie?.releaseDate?.components(separatedBy: "-")[0]
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
