//
//  Dispatch.swift
//  HearTestV2
//
//  Created by Christopher  Ladeira  on 2025/03/30.
//

import Foundation

import Foundation

func dispatchOnMainThread(_ action: @escaping () -> Void) {
    if Thread.isMainThread {
        action()
    } else {
        DispatchQueue.main.async {
            action()
        }
    }
}

func dispatchOnMainThreadAfter(_ seconds: Double, _ action: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
        action()
    }
}

func dispatchOnBackgroundThread(_ action: @escaping () -> Void) {
    DispatchQueue.global(qos: .background).async {
      action()
    }
}
