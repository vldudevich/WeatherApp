//
//  FrstViewController.swift
//  MyWeatherApp
//
//  Created by vladislav on 14.08.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

class FirstTabViewController: UIViewController {
    
    @IBOutlet private weak var contentView: UIView!
    
    var output: FirstTabViewOutput!
    var pageController = MyPageViewController()
    
    var cityToSearch = "Moscow"
    override func viewDidLoad() {
        super.viewDidLoad()
        output.onViewDidLoad()
    }
    
    @objc func addButtonTouchUpInside() {
        
        let navController = UIStoryboard(name: "SuggestionsTableViewController", bundle: nil).instantiateInitialViewController() as? UINavigationController
        let viewController = navController?.viewControllers.first as? SuggestionsTableViewController
        viewController?.delegate = self
        present(navController!, animated: true)
    }
    
    @objc func editButtonTouchUpInside() {
        
        let alertController = UIAlertController(title: "Delete current page", message: "Would you like delete current page?", preferredStyle: .actionSheet)
        
        let  deleteButton = UIAlertAction(title: "Delete forever", style: .destructive, handler: { (action) -> Void in
            self.pageController.removeCurrentPage()
            
        })
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        })
        
        alertController.addAction(deleteButton)
        alertController.addAction(cancelButton)
        
        self.navigationController!.present(alertController, animated: true, completion: nil)
    }
}
extension FirstTabViewController: FirstTabViewInput {
    func onWeatherPageGet(results: TodayWeatherContentViewController) {
        
        pageController.addController(controller: results)
  }
    
    func setupState() {
        
        self.title = "Today"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTouchUpInside))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTouchUpInside))
        
        addChild(pageController)
        contentView.addSubview(pageController.view)
        pageController.didMove(toParent: self)
    
    }
}
extension FirstTabViewController: SuggestionsTableResultDelegate {
    
    func shareCityTouchUpInside(_ city: String) {
        if city.firstIndex(of: ",") != nil {
            output.getTodayData(cityToSearch: String(city.prefix(upTo: city.firstIndex(of: ",")!)))
        } else {
            output.getTodayData(cityToSearch: city)
        }
    }
}
