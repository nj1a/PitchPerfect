//
//  ViewController.swift
//  PitchPerfect
//
//  Created by NATHAN JIA on 2016-08-19.
//  Copyright © 2016 njiaNathan Jia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var recordingLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func reordAudio(sender: AnyObject) {
        print("record button pressed")
        recordingLabel.text = "Recording..."
    }

    @IBAction func stopRecording(sender: AnyObject) {
        print("stop recording pressed")
    }
}

