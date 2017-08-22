//
//  ViewController.swift
//  ClickCounter
//
//  Created by James Luo on 21/8/17.
//  Copyright © 2017 James Luo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var count = 0
    @IBOutlet var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func incrementCount() {
        self.count = self.count + 1
        self.label.text = "\(self.count)"
    }
}

