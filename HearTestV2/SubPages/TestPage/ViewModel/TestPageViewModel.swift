//
//  TestPageViewModel.swift
//  HearTestV2
//
//  Created by Christopher  Ladeira  on 2025/03/30.
//

import Foundation
import AVFoundation
import UIKit
import SwiftUI

class TestPageViewModel: ObservableObject {
    @Published var inputText: String = ""
    @Published var currentRound: Int = 0
    @Published var isLoading: Bool = false
    
    var audioPlayer: AVAudioPlayer?
    var dificultyLevel = 5
    var answer = ""
    var firstPlayer: AVAudioPlayer?
    var numberPlayer: AVAudioPlayer?
    var soundQueue: [String] = ["", "", ""]
    var currentSoundIndex = 0
    var testResults : TestScoresModel? = nil
    var testScore = 0
    var count = 0
    var isViewLoaded = false

    //MARK: set View
    func setView(){
        testResults = TestScoresModel(score: 0, rounds: [])
        isViewLoaded = true
    }
    
    //MARK: start Round
    func startRound(){
        if isViewLoaded{
            self.isLoading = true
            currentSoundIndex = 0
            soundQueue = []
            if currentRound < 10 {
                answer = setRoundAnswer()
                soundQueue = answer.map { String($0) }
                playFirstSound()
                currentRound += 1
            }
        }
    }
    
    //MARK: submit Button Tap Logic
    func submitButtonTapLogic(){
        if currentRound < 10{
            testResults?.rounds?.insert(Round(difficulty: dificultyLevel, tripletPlayed: answer, tripletAnswered: inputText), at: 0)
            
            if inputText == answer{
                if dificultyLevel < 10{
                    dificultyLevel += 1
                }
            }else{
                if dificultyLevel > 1{
                    dificultyLevel -= 1
                }
            }
            
            dispatchOnMainThreadAfter(2) { [self] in
                startRound()
            }
        }else{
            if testResults?.rounds?.count ?? 0 < 10{
                testResults?.rounds?.insert(Round(difficulty: dificultyLevel, tripletPlayed: answer, tripletAnswered: inputText), at: 0)
        }
            currentRound = 10
            uploadTestResultsApi()
        }
        inputText = ""
    }

    // Function to play sound after delay
    func playSound() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if let soundURL = Bundle.main.url(forResource: "sound", withExtension: "mp3") {
                do {
                    self.audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                    self.audioPlayer?.play()
                } catch {
                    print("Error playing sound: \(error.localizedDescription)")
                }
            }
        }
    }
    
    //MARK: play First Sound
    func playFirstSound() {
        currentSoundIndex = 0
        if let soundURL = Bundle.main.url(forResource: "noise_\(dificultyLevel)", withExtension: "m4a") {
            do {
                firstPlayer = try AVAudioPlayer(contentsOf: soundURL)
                firstPlayer?.play()
                firstPlayer?.volume = 0.5
                
                dispatchOnMainThreadAfter(1) {
                    self.playNextSound()
                }
            } catch {
                print("Error loading first sound: \(error)")
            }
        }
    }
    
    //MARK: play Next Sound
    func playNextSound() {
        if currentSoundIndex >= soundQueue.count {
            stopSound()
            return
        }
        
        let soundName = soundQueue[currentSoundIndex]
        if let soundURL = Bundle.main.url(forResource: soundName, withExtension: "m4a") {
            do {
                numberPlayer = try AVAudioPlayer(contentsOf: soundURL)
                numberPlayer?.play()
                currentSoundIndex += 1
                dispatchOnMainThreadAfter(1 + (numberPlayer?.duration ?? 0)) {
                    self.playNextSound()
                }
            } catch {
                print("Error loading sound \(soundName): \(error)")
            }
        }
    }
    
    //MARK: Stop First Sound
    func stopSound() {
        soundQueue.removeAll()
        firstPlayer?.stop()
        firstPlayer = nil
        numberPlayer?.stop()
        numberPlayer = nil
        self.isLoading = false
    }
    
    //MARK: set Round Answer
    func setRoundAnswer()-> String{
        let numbers = Array(1...9).shuffled().prefix(3)
        return numbers.map { String($0) }.joined()
    }
    
    //MARK: append New Data
    func appendNewData(){
        testScore = 0
        count = 0
        for item in testResults?.rounds ?? []{
            if item.tripletAnswered == item.tripletPlayed{
                count += 1
                testScore += count
            }
        }
        
        testResults?.score = testScore
        if let item = testResults {
            GlobalData.shareData.testResults?.append(item)
            let cacheData = JSONEncoder()
            if let cacheBannerData = try? cacheData.encode(GlobalData.shareData.testResults){
                UserDefaults.standard.set(cacheBannerData, forKey: GlobalDataKeys.TestResults.rawValue)
            }
        }
    }
    
    //MARK: Upload Test Results Api
    func uploadTestResultsApi(){
        appendNewData()
        do {
            let jsonData = try JSONEncoder().encode(testResults)
            
            if let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                let body: [String: Any] = jsonObject
                
                SoundTestApi().uploadTestResults(body: body) { [self] bool, apiErrorData, networkError in
                    if bool != nil{
                        dispatchOnMainThread { [self] in
                    //        showAlert(on: delegate.self)
                    }
                    }else if apiErrorData != nil{
                        print(apiErrorData?.errorMessage ?? "")
                    }else if networkError != nil{
                        print(networkError.debugDescription)
                    }
                    //im just hardcoding
                    self.isLoading = false
                }
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }
        
    }
    
    //MARK: show Alert
    func showAlert(on viewController: UIViewController) {
        let alert = UIAlertController(title: "Test Complete", message: "Return to home to view Reults", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Yes", style: .default) { [self] _ in
          //  delegate.navigationController?.popViewController(animated: true)
           }
        alert.addAction(okAction)
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
}

