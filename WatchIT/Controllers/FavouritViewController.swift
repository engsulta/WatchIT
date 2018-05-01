//
//  FavouritViewController.swift
//  WatchIT
//
//  Created by Sulta on 4/20/18.
//  Copyright © 2018 Sulta. All rights reserved.
//

import UIKit
import CoreData

class FavouritViewController: UITableViewController {
    var coredata:CoreDataManager=CoreDataManager()
    var movies:[Movie]?
    var dvc:DetailsViewController?
    var oddoreven = false
    var favMoviechangeObserver : NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        coredata.label!.observe(label.size()){
//            (label,change) in
//
//        }
        
       // movies = coredata.fetchallMovies(appDelegate: UIApplication.shared.delegate as! AppDelegate)
        movies = coredata.getAllMovies()
    }
   
    
    override func viewDidAppear(_ animated: Bool) {

        favMoviechangeObserver = NotificationCenter.default.addObserver(
            forName: Notification.Name.favouriteChangeRadioChannel,
            object: self.coredata,
            queue: OperationQueue.main,
            using: {
                notification in
                self.methodOfReceivedNotification(notification: notification)
        }
        )

    }
    
    // MARK: - de init
    override func viewWillDisappear(_ animated: Bool) {
        if let observer = self.favMoviechangeObserver{
            NotificationCenter.default.removeObserver(observer)

        }

    }
    
    @objc func methodOfReceivedNotification(notification: Notification){
        updateUi(arr: notification.userInfo?["movies"] as! [Movie])
    }
    

    func updateUi(arr: [Movie]){
        self.movies = arr
        self.tableView.reloadData()
        
        
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies!.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the cell...
        
        let movieImageView1 = cell.viewWithTag(1) as! UIImageView
        let movieImageView2 = cell.viewWithTag(2) as! UIImageView
        
        let imageurl:String="https://image.tmdb.org/t/p/w500" + (self.movies?[indexPath.row].posterPath)!
        let url = URL(string: imageurl)
        movieImageView1.__sd_setImage(with: url)
        if (indexPath.row+1 < self.movies!.count){
        let imageurl2:String="https://image.tmdb.org/t/p/w500" + (self.movies![indexPath.row+1].posterPath)!
        let url2 = URL(string: imageurl2)
            movieImageView2.__sd_setImage(with: url2)
            
        }
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if oddoreven{
            dvc?.movie=self.movies?[indexPath.row+1]
        }
        else{
            dvc?.movie=self.movies?[indexPath.row]
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.identifier){
        case "showDetails"? :
            dvc=segue.destination as? DetailsViewController
            //dvc?.movie=self.movies[((self.collectionView?.indexPath(for: sender as! UICollectionViewCell))?.row)!]
            
            
        case "showDetailsOdd"? :
            dvc=segue.destination as? DetailsViewController
            oddoreven = true
            
        case "showDetialsEven"? :
            dvc=segue.destination as? DetailsViewController
            oddoreven = false
            
        default :break
        }
    }
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
