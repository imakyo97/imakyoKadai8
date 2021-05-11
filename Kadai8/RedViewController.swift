//
//  ViewController.swift
//  Kadai8
//
//  Created by 今村京平 on 2021/05/11.
//

import UIKit

class RedViewController: UIViewController {

    @IBOutlet private weak var redLabel: UILabel!
    @IBOutlet private weak var slider: UISlider!
    private let delegate = UIApplication.shared.delegate as! AppDelegate

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        redLabel.text = String(delegate.value)
        slider.value = delegate.value
    }

    @IBAction private func sliderAction(_ sender: UISlider) {
        delegate.value = sender.value
        redLabel.text = String(delegate.value)
    }
}

