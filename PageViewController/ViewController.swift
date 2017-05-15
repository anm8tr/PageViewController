//
//  ViewController.swift
//  PageViewController
//
//  Created by Richard Garrison on 5/13/17.
//  Copyright © 2017 Richard Garrison. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var pageViewController: UIViewController?
    var images = ["imperialstarship","millenniumFalcon", "xwing", "tiefighter", "tiedefender"]
    var pendingIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        createPageViewController()
    }
    
    func createPageViewController() {
        // istantiate the PageViewController
        let pageController = self.storyboard?.instantiateViewController(withIdentifier: "pageVC") as! UIPageViewController
        pageController.dataSource = self
        pageController.delegate = self
        
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

extension ViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    // UIPageViewControllerDatasource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let contentVC = viewController as! ContentViewController
        var index = contentVC.itemIndex
        
        if index == 0 || index == NSNotFound {
            return getContentViewController(withIndex: images.count - 1)
        }
        
        index -= 1     // index = index - 1
        
        return getContentViewController(withIndex: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let contentVC = viewController as! ContentViewController
        var index = contentVC.itemIndex
        
        if index == NSNotFound {
            return nil
        }
        index += 1
        
        if index == images.count {
            return getContentViewController(withIndex: 0)
        }
        
        return getContentViewController(withIndex: index)
    }
    
    // UIPageViewControllerDelegate
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        pendingIndex = (pendingViewControllers.first as! ContentViewController).itemIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let index = pendingIndex {
                self.pageControl.currentPage = index
            }
        }
    }
}









