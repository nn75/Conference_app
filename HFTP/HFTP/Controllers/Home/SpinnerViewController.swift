//
//  SpinerViewController.swift
//  HFTP
//
//  Created by Kai Wang on 3/26/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit
var spinnerView: UIView?

extension UIViewController {
    
    func showSpinner() {
        spinnerView = UIView( frame: self.view.bounds)
        spinnerView?.backgroundColor = UIColor.white
        
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.center = spinnerView!.center
        spinner.startAnimating()
        spinnerView?.addSubview(spinner)
        
        self.view.addSubview(spinnerView!)
    }
    
    func stopSpinner() {
        
        spinnerView!.removeFromSuperview()
        spinnerView = nil
    }
    
}
