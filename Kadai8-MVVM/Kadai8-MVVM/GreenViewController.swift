//
//  GreenViewController.swift
//  Kadai8-MVVM
//
//  Created by 今村京平 on 2021/08/21.
//

import UIKit
import RxSwift
import RxCocoa

final class GreenViewController: UIViewController {

    @IBOutlet private weak var numberLabel: UILabel!
    @IBOutlet private weak var slider: UISlider!

    private let viewModel: ViewModelType = ViewModel(valueUseCase: ModelLocator.shared.valueUseCase)
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
    }

    private func setupBinding() {
        slider.rx.value
            .subscribe(onNext: { [weak self] value in
                self?.viewModel.inputs.sliderValueDidChanged(value: value)
            })
            .disposed(by: disposeBag)

        viewModel.outputs.event
            .drive(onNext: { [weak self] event in
                switch event {
                case .changeSliderValue(let value):
                    self?.slider.value = value
                }
            })
            .disposed(by: disposeBag)

        viewModel.outputs.numbetText
            .drive(numberLabel.rx.text)
            .disposed(by: disposeBag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.inputs.viewWillAppear()
    }
}
