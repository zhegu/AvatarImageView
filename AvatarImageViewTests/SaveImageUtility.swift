//
//  SaveImageUtility.swift
//  AvatarImageView
//
//  Created by Ayush Newatia on 11/08/2016.
//  Copyright © 2016 Ayush Newatia. All rights reserved.
//

import UIKit
import XCTest
@testable import AvatarImageView

// THIS SHOULD NOT RUN AS PART OF A NORMAL TEST RUN. It is meant to be used to save generated images to then compare them in unit tests.
// This test case is disabled in the scheme.
class SaveImageUtility: XCTestCase {
    
    func testSaveImage() {
        let data = TestData(name: "")
        
        var config = TestConfig()
        config.shape = .Square
        
        let avatarImageView = AvatarImageView(frame: CGRectMake(0, 0, 100, 100))
        avatarImageView.configuration = config
        avatarImageView.dataSource = data
        
//        let imageData = UIImagePNGRepresentation(avatarImageView.image!)!
        avatarImageView.asImage().saveToDesktop()
    }
}

extension UIView {
    func asImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.mainScreen().scale)
        let context = UIGraphicsGetCurrentContext()!
        layer.renderInContext(context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

extension UIImage {
    func saveToDesktop(withName name: String = "image.png") {
        let imageData = UIImagePNGRepresentation(self)
        let simluatorDesktopPath = NSSearchPathForDirectoriesInDomains(.DesktopDirectory, .UserDomainMask, true).first!
        let splitPath = simluatorDesktopPath.componentsSeparatedByString("/")
        let path = "/\(splitPath[1])/\(splitPath[2])/Desktop/\(name)"
        
        NSFileManager.defaultManager().createFileAtPath(path, contents: imageData, attributes: nil)
    }
}