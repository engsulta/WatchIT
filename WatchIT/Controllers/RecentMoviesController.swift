//
//  RecentMoviesController.swift
//  WatchIT
//
//  Created by Sulta on 4/20/18.
//  Copyright © 2018 Sulta. All rights reserved.
//

import UIKit
import SDWebImage

private let reuseIdentifier = "cell"

struct Filter {
    static let popularity = "https://api.themoviedb.org/3/discover/movie?api_key=17573bb6e87afe885b35b2c812b40aa8&sort_by=popularity.desc"
    static let views = "https://api.themoviedb.org/3/discover/movie?api_key=17573bb6e87afe885b35b2c812b40aa8&sort_by=view_count.desc"
}

class RecentMoviesController: UICollectionViewController {
    //@IBOutlet weak var movieLoadingIndicator: UIActivityIndicatorView!
    var movies:[Movie]=[Movie]()
    
    var dvc:DetailsViewController?
    var movieChangeObserver :NSObjectProtocol?
    
    // @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    let apiManager:ApiManager=ApiManager()
    
    override func awakeFromNib() {
       
    }
    
    @IBAction func byviewCount(_ sender: UIBarButtonItem) {
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiManager.fetchAllfilms(url:Filter.popularity) // default is popular movies
     
        }
    override func viewWillAppear(_ animated: Bool) {
        // progressIndicator.startAnimating()
        
        movieChangeObserver = NotificationCenter.default.addObserver(
            forName: Notification.Name.movieChangeRadioChannel,
            object: self.apiManager,
            queue: OperationQueue.current,
            using: {
                notification in
                // print("movies has changed\(self.movies.count)")
                DispatchQueue.main.async {
                    self.methodOfReceivedNotification(notification: notification)
                    
                }
        }
            
        )
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
// MARK: - Notification handling
    @objc func methodOfReceivedNotification(notification: Notification){
        updateUi(arr: notification.userInfo?["movies"] as! [Movie])
    }
    
    
    // MARK: - de init
    override func viewWillDisappear(_ animated: Bool) {
    if let observer = self.movieChangeObserver{
    NotificationCenter.default.removeObserver(observer)
    
    }
    
    }
    

    // MARK: - updateUI
    open func updateUi(arr:[Movie]){
       movies = arr
     //movieLoadingIndicator.stopAnimating()
    self.collectionView?.reloadData()
    
    }
  
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
   
    return movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    
    // Configure the cell
    
    let movieImageView:UIImageView  = cell.viewWithTag(1) as! UIImageView
    //[cell viewWithTag:1];
    
    let imageurl:String="https://image.tmdb.org/t/p/w500" + movies[indexPath.row].posterPath!
    let url = URL(string: imageurl)
    movieImageView.__sd_setImage(with: url)
    
    return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    return true
    }
    
    
    
 
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print(indexPath.row)
    dvc?.movie=self.movies[indexPath.row]
    NSLog("@", self.movies[indexPath.row])
    
    
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    print(((self.collectionView?.indexPath(for: sender as! UICollectionViewCell))?.row)!)
    if segue.identifier == "showDetails"{
    dvc=segue.destination as? DetailsViewController
    //dvc?.movie=self.movies[((self.collectionView?.indexPath(for: sender as! UICollectionViewCell))?.row)!]
    
    
    }
    }
}
