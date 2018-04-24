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

class RecentMoviesController: UICollectionViewController {
    var movies:[Movie]=[Movie]()
    var dvc:DetailsViewController?
   // @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    @objc let apiManager:ApiManager=ApiManager()
    
    override func awakeFromNib() {
//        self.addObserver(self, forKeyPath: #keyPath(apiManager.doneStr), options: [.old,.new,.initial], context: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiManager.myController=self
        movies = apiManager.fetchAllfilms()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
       // progressIndicator.startAnimating()
        
        
    }
    // MARK: - de init
    
    deinit {
        removeObserver(self, forKeyPath: #keyPath(apiManager.doneStr))
    }
    // MARK: - updateUI
    open func updateUi(arr:[Movie]){
        movies = arr
       // progressIndicator.stopAnimating()
        self.collectionView?.reloadData()
        
    }
    
    // MARK: - Key-Value Observing
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(apiManager.doneStr) {
            // Update
            updateUi(arr:self.movies)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
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
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     /*override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return true
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        dvc?.movie=self.movies[indexPath.row]
     
     }*/
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
