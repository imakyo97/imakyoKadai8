//
//  GreenViewController.swift
//  Kadai8
//
//  Created by 今村京平 on 2021/05/11.
//

import UIKit

class GreenViewController: UIViewController {
    
    @IBOutlet private weak var greenLabel: UILabel!
    @IBOutlet private weak var sender: UISlider!
    private let delegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        greenLabel.text = String(delegate.value)
        sender.value = delegate.value
    }
    
    @IBAction private func sliderAction(_ sender: UISlider) {
        delegate.value = sender.value
        greenLabel.text = String(delegate.value)
    }
}
