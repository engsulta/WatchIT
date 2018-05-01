
import UIKit

public protocol MovieUpdateDelegate {
    func updateMoviewithFilterOption(str:String)
}
class FilterMenuViewController: UIViewController  {
   
   var movieUpdateDelegate : MovieUpdateDelegate?
    
    
    
    @IBAction func onMostViewed(_ sender: UIButton) {
        movieUpdateDelegate?.updateMoviewithFilterOption(str: "mostviewed")
    }
    @IBAction func onMostPopularPressed(_ sender: UIButton) {
        movieUpdateDelegate?.updateMoviewithFilterOption(str: "mostpopular")
    }
    @IBOutlet weak var mytopview: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
    }
    func updateUI(){
        if self.presentationController is UIPopoverPresentationController {
            view.backgroundColor = .clear
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let fittedSize = mytopview?.sizeThatFits(UILayoutFittingCompressedSize){
            preferredContentSize = CGSize(width: fittedSize.width+30, height: fittedSize.height+30)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
