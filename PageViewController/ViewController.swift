//
//  ViewController.swift
//  PageViewController
//
//  Created by Richard Garrison on 5/13/17.
//  Copyright © 2017 Richard Garrison. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var pageViewController: UIViewController?
    var images = ["imperialstarship","millenniumFalcon", "xwing"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        createPageViewController()
    }
    
    func createPageViewController() {
        // istantiate the PageViewController
        let pageController = self.storyboard?.instantiateViewController(withIdentifier: "pageVC") as! UIPageViewController
        pageController.dataSource = self
        
        if images.count > 0 {
            let contentController = getContentViewController(withIndex: 0)!
            let contentControllers = [contentController]
            
            pageController.setViewControllers(contentControllers, direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        }
        
        // Assign to pageViewController property
        pageViewController = pageController
        
        // Add the pageViewController to main viewController (self)
        addChildViewController(pageViewController!)
        
        // Add pageViewController view as a sub view of main viewController
        self.view.addSubview(pageViewController!.view)
        pageViewController!.didMove(toParentViewController: self)
    }

    func getContentViewController(withIndex index: Int) -> ContentViewController? {
        if index < images.count {
           let contentVC = self.storyboard?.instantiateViewController(withIdentifier: "contentVC") as! ContentViewController
            contentVC.itemIndex = index
            contentVC.imageName = images[index]
            
            return contentVC
        }
        return nil
    }


}

extension ViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let contentVC = viewController as! ContentViewController
        
        if contentVC.itemIndex > 0  {
            return getContentViewController(withIndex: contentVC.itemIndex - 1)
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let contentVC = viewController as! ContentViewController
        
        if contentVC.itemIndex + 1 < images.count {
            return getContentViewController(withIndex: contentVC.itemIndex + 1)
        }
        return nil
    }
}









