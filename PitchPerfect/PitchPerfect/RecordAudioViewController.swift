//
//  RecordAudioViewController.swift
//  PitchPerfect
//
//  Created by James Luo on 18/8/17.
//  Copyright © 2017 James Luo. All rights reserved.
//

import UIKit
import AVFoundation

class RecordAudioViewController: UIViewController {
    
    var audioRecorder: AVAudioRecorder!

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let playSoundViewController = segue.destination as? PlaySoundsViewController
        playSoundViewController?.recordedAudioURL = sender as? URL
    }
    
    private func setUIState(isRecording: Bool, recordingText: String) {
        label.text = recordingText
        stopButton.isEnabled = isRecording
        recordButton.isEnabled = !isRecording
    }


    @IBAction func recordAudio(_ sender: Any, forEvent event: UIEvent) {
        setUIState(isRecording: true, recordingText: "Recording in progress")
        
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
        setUIState(isRecording: false, recordingText: "Tap to Record")
        
        audioRecorder.stop()
        try! AVAudioSession.sharedInstance().setActive(false)
    }
}

// MARK: - AVAudioRecorderDelegate
extension RecordAudioViewController: AVAudioRecorderDelegate {
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if (flag) {
            performSegue(withIdentifier: "playAudio", sender: audioRecorder.url)
        } else {
            showAlert("Recording Stopped", message: "recording stopped because of an audio encoding error.")
        }
    }
    
    func showAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: title, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

