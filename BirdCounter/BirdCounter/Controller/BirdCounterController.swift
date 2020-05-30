//
//  ViewController.swift
//  BirdCounter
//
//  Created by Zvonimir Pavlović on 29/04/2020.
//  Copyright © 2020 Zvonimir Pavlović. All rights reserved.
//

import UIKit

class BirdCounterController: UIViewController {
    
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var fourthButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var firstButton: UIButton!
    
    lazy var viewModel: BirdCounterViewModel = BirdCounterViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        NotificationCenter.default.addObserver(self, selector: #selector(updateCounter(_:)), name: NSNotification.Name("counterAdd"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resetView(_:)), name: NSNotification.Name("reset"), object: nil)
    }
    
    @objc func updateCounter(_ notification: NSNotification){
        if let counter = notification.userInfo?["counter"] as? Int, let color = notification.userInfo?["color"] as? Int{
            counterLabel.text = String(counter)
            view.backgroundColor = Helper.intToColor(number: color)
        }
    }
    
    func setUI(){
        counterLabel.text = String(viewModel.getBirdCounter())
        view.backgroundColor = viewModel.getBackgroundColor()
    }

    @IBAction func plusClicked(_ sender: UIButton) {
        viewModel.onPlusClicked(tag: sender.tag)
    }
    
    @IBAction func resetClicked(_ sender: Any) {
        viewModel.onResetClicked()
    }
    
    
    @objc func resetView(_ notification: NSNotification){
        counterLabel.text = "0"
        view.backgroundColor = UIColor.white
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
}

