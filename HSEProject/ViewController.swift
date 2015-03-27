//
//  ViewController.swift
//  HSEProject
//
//  Created by Sergey Pronin on 2/24/15.
//  Copyright (c) 2015 Sergey Pronin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var buttonMenu: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //здесь все @IBOutlet уже подгружены
        //можно настроить отображение до показа
    }
    
    ///вызывается каждый раз перед показом
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    ///вызывается сразу после появления
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    ///сейчас исчезнет
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    ///только что исчез
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    @IBAction func tapMenu(sender: UIButton) {
        buttonMenu.setTitle("Hello", forState: .Normal)
    }
    
}

