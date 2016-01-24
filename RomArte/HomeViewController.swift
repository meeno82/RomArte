//
//  ViewController.swift
//  RomArte
//
//  Created by Claudio Segoloni on 01/01/16.
//  Copyright © 2016 RomArte. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    */

}

