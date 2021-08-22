//
//  RedViewController.swift
//  Kadai8-MVVM
//
//  Created by 今村京平 on 2021/08/21.
//

import UIKit
import RxSwift
import RxCocoa

final class RedViewController: UIViewController {

    @IBOutlet private weak var numberLabel: UILabel!
    @IBOutlet private weak var slider: UISlider!

    let model: SliderModel = Slider()
    private lazy var viewModel: RedViewModelType = RedViewModel(model: model)
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
    }

    private func setupBinding() {
        slider.rx.value
            .subscribe(onNext: { [weak self] value in
                self?.viewModel.input.changedNum(num: value)
            })
            .disposed(by: disposeBag)

        viewModel.output.driver
            .drive(onNext: { [weak self] num in
                let stringNum = String(num)
                self?.numberLabel.text = stringNum
            })
            .disposed(by: disposeBag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        numberLabel.text = String(viewModel.output.num)
        slider.value = viewModel.output.num
    }
}
