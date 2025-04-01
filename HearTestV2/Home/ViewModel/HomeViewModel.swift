//
//  HomeViewModel.swift
//  HearTestV2
//
//  Created by Christopher  Ladeira  on 2025/03/30.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    func checkForStoredValues()-> Bool{
        if UserDefaults.standard.value(forKey: GlobalDataKeys.TestResults.rawValue) != nil{
            if let cacheData = (UserDefaults.standard.value(forKey: GlobalDataKeys.TestResults.rawValue)) as? Data{
                let decoder = JSONDecoder()
                if let cacheData = try? decoder.decode([TestScoresModel].self, from: cacheData){
                    GlobalData.shareData.testResults = cacheData
                    return true
                }
            }
        }
        return false
    }
    
}
