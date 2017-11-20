//
//  Extensions.swift
//  StarWarsPojectGuide
//
//  Created by RICHARD MONSON-HAEFEL on 11/9/17.
//  Copyright © 2017 RICHARD MONSON-HAEFEL. All rights reserved.
//

import UIKit
import StarWarsAPI

/**
 The `ModelObject` protocol is used by the `GeneralListVC` when fetching data from
 the StarWarsAPI REST services. It is used so that a generic method in the
 'GeneralListVC' class and filter and sort collection of model objects without
 have to be specific to that class definition of that model object
 */
public protocol ModelObject {
    func identifier() -> String?
    func sortValue() -> String?
}
/// This extension implements the ModelObject protocol.
extension Film: ModelObject {
    public func identifier() -> String? {
        return url
    }

    public func sortValue() -> String? {
        return title
    }
}

/// This extension implements the ModelObject protocol.
extension People: ModelObject {
    public func identifier() -> String? {
        return url
    }

    public func sortValue() -> String? {
        return name
    }
}

/// This extension implements the ModelObject protocol.
extension Species: ModelObject {
    public func identifier() -> String? {
        return url
    }

    public func sortValue() -> String? {
        return name
    }
}

/// This extension implements the ModelObject protocol.
extension Planet: ModelObject {
    public func identifier() -> String? {
        return url
    }

    public func sortValue() -> String? {
        return name
    }
}

/// This extension implements the ModelObject protocol.
extension Vehicle: ModelObject {
    public func identifier() -> String? {
        return url
    }

    public func sortValue() -> String? {
        return name
    }
}

/// This extension implements the ModelObject protocol.
extension Starship: ModelObject {
    public func identifier() -> String? {
        return url
    }

    public func sortValue() -> String? {
        return name
    }
}

/**
 This extension is used by the `FilmVC` to create an alpha gradient on the images
 used to represent the choices in its table view. It's for visual effect only.
 */
extension UIImageView {

    /** This is a convenience method for adding an alpha gradient to an image
     directly.
    */
    public func setImageWithAlphaGradiant(image: UIImage) {
        self.image = imageWithAlphaGradient(img: image)
    }

    /**
     This method takes an image, creates a copy and applies an alpha gradient
     from left to right starting with total transparency (so the image is not
     seen) to full opacity. The copy of the image with the new alpha gradient
     is returned to the caller.
    */
    func imageWithAlphaGradient(img: UIImage) -> UIImage {

        UIGraphicsBeginImageContext(img.size)
        let context = UIGraphicsGetCurrentContext()

        img.draw(at: CGPoint(x: 0, y: 0))

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let locations: [CGFloat] = [0.0, 1.0]

        let bottom = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
        let top = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor

        let colors = [top, bottom] as CFArray

        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: locations)

        let startPoint = CGPoint(x: 0, y: 0)
        let endPoint = CGPoint(x: img.size.width, y: img.size.height)

        context!.drawLinearGradient(gradient!, start: endPoint, end: startPoint, options: CGGradientDrawingOptions(rawValue: UInt32(0)))

        let image = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return image!
    }
}

extension UIColor {
    /*
     Define UIColor from hex value
     
     @param rgbValue - hex color value
     @param alpha - transparency level
     */
    public static func fromHex(rgbValue: UInt32, alpha: Double = 1.0) -> UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8) / 256.0
        let blue = CGFloat(rgbValue & 0xFF) / 256.0
        return UIColor(red: red, green: green, blue: blue, alpha: CGFloat(alpha))
    }
}

extension UIViewController {

    func showAlert(title: String, message: String) {
        if Thread.isMainThread {
            _showAlert(title: title, message: message)
        } else {
            DispatchQueue.main.async {
                self._showAlert(title: title, message: message)
            }
        }
    }

    func _showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)

        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))

        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}
