//
//  GlobalData.swift
//  HearTestV2
//
//  Created by Christopher  Ladeira  on 2025/03/30.
//

import UIKit

class GlobalData {
    
    //MARK: - Public Var
    public static let shareData = GlobalData()
    public var window: UIWindow = UIWindow(frame: UIScreen.main.bounds)
    public var testResults : [TestScoresModel]? = []

}
