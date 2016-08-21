//
//  RecordSoundViewController.swift
//  PitchPerfect
//
//  Created by NATHAN JIA on 2016-08-19.
//  Copyright © 2016 njiaNathan Jia. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // called before view appear on screen
    override func viewWillAppear(animated: Bool) {
        stopRecordingButton.enabled = false
    }
    
    
    // start recording
    @IBAction func reordAudio(sender: AnyObject) {
        print("record button pressed")
        recordingLabel.text = "Recording..."
        stopRecordingButton.enabled = true
        recordButton.enabled = false
        
        // set up path to the recorded audio: document dir
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        // initiate audiorecorder and set this controller as its delegate
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        
        // record voice
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    // stop recording
    @IBAction func stopRecording(sender: AnyObject) {
        print("stop recording pressed")
        recordingLabel.text = "Tap to record"
        
        recordButton.enabled = true
        stopRecordingButton.enabled = false
        
        // stop recordingLabel
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    // jump to the next view
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        print("AudioRecording finished")
        
        if (flag) {
            self.performSegueWithIdentifier("stopRecording", sender: audioRecorder.url)
        } else {
            print("saving failed")
        }
    }
    
    // attach the audio url to the segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundVC = segue.destinationViewController as! PlaySoundsViewController
            let recordedAudioURL = sender as! NSURL
            playSoundVC.recordedAudioURL = recordedAudioURL
        }
    }
}

