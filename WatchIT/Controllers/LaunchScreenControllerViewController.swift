//
//  LaunchScreenControllerViewController.swift
//  WatchIT
//
//  Created by Sulta on 4/23/18.
//  Copyright © 2018 Sulta. All rights reserved.
//

import UIKit

class LaunchScreenControllerViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIViewPropertyAnimator
            .runningPropertyAnimator(
                withDuration: 0,
                delay: 0,
                options: [], animations: {
                    self.logo.transform = CGAffineTransform.identity.translatedBy(x: 10, y: 0)},
                completion: {
                    position in  UIViewPropertyAnimator.runningPropertyAnimator(
                        withDuration: 0.9,
                        delay: 0,
                        options: [], animations: {
                             self.logo.transform = CGAffineTransform.identity.translatedBy(x: -10, y: 0)
                            },
                        completion: {
                            position in
                            
                            self.performSegue(withIdentifier: "startapp", sender: self)
                    }
                    )
            }
        )
        UIViewPropertyAnimator
            .runningPropertyAnimator(
                withDuration: 0.9,
                delay: 0,
                options: [], animations: {
                    self.imageLogo.transform = CGAffineTransform.identity.scaledBy(x: 1.5, y: 1.5)},
                completion: {
                    position in  UIViewPropertyAnimator.runningPropertyAnimator(
                        withDuration: 0.6,
                        delay: 0,
                        options: [], animations: {
                            self.imageLogo.transform = CGAffineTransform.identity.rotated(by: 2*CGFloat.pi)
                            self.imageLogo.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
                            self.imageLogo.alpha = 0},
                        completion: {
                            position in
                            
                            self.performSegue(withIdentifier: "startapp", sender: self)
                    }
                    )
            }
        )
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var imageLogo: UIImageView!
    
    @IBOutlet weak var logo: UILabel!
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
