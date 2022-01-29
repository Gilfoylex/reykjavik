//
//  ViewHelper.swift
//  Reykjavik
//
//  Created by PUMA on 2021/11/19.
//

import SwiftUI

extension View {
    func getRect()->CGRect {
        return NSScreen.main!.visibleFrame;
    }
}
