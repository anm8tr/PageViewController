//
//  ContentViewController.swift
//  PageViewController
//
//  Created by Richard Garrison on 5/13/17.
//  Copyright © 2017 Richard Garrison. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var imageLabel: UILabel!
    
    var itemIndex: Int = 0
    var imageName: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let currentImage = imageName {
          imageView.image = UIImage(named: imageName!)
          imageLabel.text = currentImage
    }

    func didReceiveMemoryWarning() {
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
}
