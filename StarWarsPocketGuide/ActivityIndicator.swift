//
//  ActivityIndicator.swift
//  StarWarsPojectGuide
//
//  Created by RICHARD MONSON-HAEFEL on 11/16/17.
//  Copyright © 2017 RICHARD MONSON-HAEFEL. All rights reserved.
//

import UIKit

/**
 This code is adapted from GitHub project [erangaeb/dev-notes](https://github.com/erangaeb/dev-notes/blob/master/swift/ViewControllerUtils.swift)
 
 In order to show the activity indicator, call the function from your view controller
 `ActivityIndicator.shared.showActivityIndicator(self.view)`

 In order to hide the activity indicator, call the function from your view controller
 `ActivityIndicator.shared.hideActivityIndicator(self.view)`
*/

public class ActivityIndicator {

    // MARK: - Singleton
    public static let shared: ActivityIndicator = ActivityIndicator()

    var container: UIView = UIView()
    var loadingView: UIView?
    var activityIndicator: UIActivityIndicatorView?

    /*
     Show customized activity indicator,
     actually add activity indicator to passing view
     */
    func showActivityIndicator(forView uiView: UIView) {
        guard activityIndicator == nil else {
            return
        }

        container.frame = uiView.frame
        container.center = uiView.center
        container.backgroundColor = UIColor.fromHex(rgbValue: 0xffffff, alpha: 0.3)

        loadingView = UIView()
        loadingView?.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView?.center = uiView.center
        loadingView?.backgroundColor = UIColor.fromHex(rgbValue: 0x444444, alpha: 0.7)
        loadingView?.clipsToBounds = true
        loadingView?.layer.cornerRadius = 10

        activityIndicator = UIActivityIndicatorView()

        activityIndicator?.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator?.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge

        activityIndicator?.center = CGPoint(x: (loadingView?.frame.size.width)! / 2, y: (loadingView?.frame.size.height)! / 2)

        loadingView?.addSubview(activityIndicator!)
        container.addSubview(loadingView!)
        uiView.addSubview(container)
        activityIndicator?.startAnimating()
    }

    /*
     Hide activity indicator
     Actually remove activity indicator from its super view
     */
    func hideActivityIndicator() {
        activityIndicator?.stopAnimating()
        container.removeFromSuperview()

        defer {
            activityIndicator = nil
            loadingView = nil
        }
    }
}
