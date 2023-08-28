//
//  ViewController.swift
//  BorderGradient
//
//  Created by Egor Laba on 27.08.23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gradientView: AnimatedGradientBorderedView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradientView.doAnimate()
    }
}

