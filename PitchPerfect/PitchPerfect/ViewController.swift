//
//  ViewController.swift
//  PitchPerfect
//
//  Created by James Luo on 18/8/17.
//  Copyright © 2017 James Luo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func recordAudio(_ sender: Any, forEvent event: UIEvent) {
        print("recording")
        label.text = "recording"
    }
}

