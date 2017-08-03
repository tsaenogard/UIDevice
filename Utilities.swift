//
//  Utilities.swift
//  Toast
//
//  Created by smallHappy on 2017/4/6.
//  Copyright © 2017年 SmallHappy. All rights reserved.
//

import UIKit

class Utilities: NSObject {
    
    private static let instance = Utilities()
    static var sharedInstance: Utilities {
        return self.instance
    }
    
    static let device = Device()
}

extension Utilities {
    
    func showAlertView(title: String? = nil, message: String? = nil, target: UIViewController, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmButton = UIAlertAction(title: "確認", style: .default, handler: handler)
        alert.addAction(confirmButton)
        DispatchQueue.main.async { target.present(alert, animated: true, completion: nil) }
    }
    
    func showAlertView(title: String? = nil, message: String? = nil, target: UIViewController, cancelHandler: ((UIAlertAction) -> Void)? = nil, confirmHandler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "取消", style: .default, handler: cancelHandler)
        alert.addAction(cancelButton)
        let confirmButton = UIAlertAction(title: "確認", style: .default, handler: confirmHandler)
        alert.addAction(confirmButton)
        DispatchQueue.main.async { target.present(alert, animated: true, completion: nil) }
    }
    
}

extension Utilities {
    
    enum ToastLength: Double {
        case long = 3.5, short = 2.0
    }
    
    enum ToastStyle {
        case label, view
    }
    
    func toast(taget: UIViewController, style: ToastStyle = .view, message: String, length: ToastLength = .short) {
        let frameW = taget.view.frame.width
        let frameH = taget.view.frame.height
        let gap: CGFloat = 10
        let labelH: CGFloat = 21
        switch style {
        case .label:
            let label = UILabel(frame: CGRect(x: 0, y: frameH - labelH - gap, width: frameW, height: labelH))
            label.text = message
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            label.transform = CGAffineTransform(translationX: 0, y: labelH + gap)
            taget.view.addSubview(label)
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                label.transform = CGAffineTransform.identity
            }, completion: { (isFinish) in
                UIView.animate(withDuration: length.rawValue, animations: {
                    label.alpha = 0.0
                }, completion: { (isFinish) in
                    label.removeFromSuperview()
                })
            })
        case .view:
            let viewH: CGFloat = labelH + gap * 2
            let _view = UIView(frame: CGRect(x: gap, y: frameH - viewH - gap, width: frameW - gap * 2, height: viewH))
            _view.backgroundColor = UIColor.black
            _view.alpha = 0.85
            _view.transform = CGAffineTransform(translationX: 0, y: viewH + gap)
            _view.layer.cornerRadius = 8.0
            taget.view.addSubview(_view)
            let label = UILabel(frame: CGRect(x: gap * 2, y: frameH - labelH - gap * 2, width: frameW - gap * 4, height: labelH))
            label.text = message
            label.textColor = UIColor.white
            label.textAlignment = .center
            label.transform = CGAffineTransform(translationX: 0, y: labelH + gap * 2)
            taget.view.addSubview(label)
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: { 
                _view.transform = CGAffineTransform.identity
                label.transform = CGAffineTransform.identity
            }, completion: { (isFinish) in
                UIView.animate(withDuration: length.rawValue, animations: {
                    _view.alpha = 0.0
                    label.alpha = 0.0
                }, completion: { (isFinish) in
                    _view.removeFromSuperview()
                    label.removeFromSuperview()
                })
            })
        }
    }
    
}

extension Utilities {
    
    class Device {
        var uuid: String {
            return (UIDevice.current.identifierForVendor?.uuidString)!
        }
        
        var systemName: String {
            return UIDevice.current.systemName
        }
        
        var systemVersion: String {
            return UIDevice.current.systemVersion
        }
        var name: String {
            return UIDevice.current.name
        }
        
        var orientation: String {
            switch UIDevice.current.orientation {
            case .faceUp:
                return "faceUp"
            case .faceDown:
                return "faceDown"
            case .portrait:
                return "portrait"
            case .portraitUpsideDown:
                return "portraitUpsideDown"
            case .landscapeLeft:
                return "landscapeLeft"
            case .landscapeRight:
                return "landscapeRight"
            case .unknown:
                return "unknown"
            }
        }
        
        var userInterfaceIdiom: String {
            switch UIDevice.current.userInterfaceIdiom {
            case .unspecified:
                return "unspecified"
            case .phone:
                return "phone"
            case .pad:
                return "pad"
            case .tv:
                return "tv"
            case .carPlay:
                return "carPlay"
            }
        }
        
        var multitaskingSupported: Bool {
            return UIDevice.current.isMultitaskingSupported
        }
        var batteryState: String {
            if UIDevice.current.isBatteryMonitoringEnabled == false {
                return "Battery monitoring is not enable!"
                }
            switch UIDevice.current.batteryState {
            case .unplugged:
                return "unplugged"
            case .full:
                return "full"
            case .charging:
                return "charging"
            case .unknown:
                return "unknown"
            }

        }
        var batteryLevel: String {
            if UIDevice.current.isBatteryMonitoringEnabled == false {
                return "Battery monitoring is not enable!"
            }
            return String(UIDevice.current.batteryLevel)
        }
    }
    
}
