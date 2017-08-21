//
//  RecordAudioViewController.swift
//  PitchPerfect
//
//  Created by James Luo on 18/8/17.
//  Copyright © 2017 James Luo. All rights reserved.
//

import UIKit
import AVFoundation

class RecordAudioViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopButton.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        performSegue(withIdentifier: "playAudio", sender: audioRecorder.url)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let playSoundViewController = segue.destination as? PlaySoundsViewController
        playSoundViewController?.recordedAudioURL = sender as? URL
    }


    @IBAction func recordAudio(_ sender: Any, forEvent event: UIEvent) {
        label.text = "Recording in progress"
        stopButton.isEnabled = true
        recordButton.isEnabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))

        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecord(_ sender: Any) {
        recordButton.isEnabled = true
        stopButton.isEnabled = false
        label.text = "Tap to Record"
        audioRecorder.stop()
        try! AVAudioSession.sharedInstance().setActive(false)
    }
}

