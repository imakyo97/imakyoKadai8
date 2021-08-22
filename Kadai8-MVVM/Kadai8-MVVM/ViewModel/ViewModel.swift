//
//  ViewModel.swift
//  Kadai8-MVVM
//
//  Created by 今村京平 on 2021/08/22.
//

import RxSwift
import RxCocoa

protocol ViewModelInput {
    func sliderValueDidChanged(value: Float)
    func viewWillAppear()
}

protocol ViewModelOutput {
    var event: Driver<ViewModel.Event> { get }
    var numbetText: Driver<String> { get }
}

protocol ViewModelType {
    var inputs: ViewModelInput { get }
    var outputs: ViewModelOutput { get }
}

final class ViewModel: ViewModelInput, ViewModelOutput {

    enum Event {
        case changeSliderValue(Float)
    }

    let valueUseCase: ValueUseCaseProtocol

    init(valueUseCase: ValueUseCaseProtocol) {
        self.valueUseCase = valueUseCase
        setupBinding()
    }

    private let eventRelay = PublishRelay<Event>()

    var event: Driver<Event> {
        eventRelay.asDriver(onErrorDriveWith: .empty())
    }

    var numbetText: Driver<String> {
        valueUseCase.value
            .map { String($0) }
            .asDriver(onErrorDriveWith: .empty())
    }

    private let disposeBag = DisposeBag()
    private let viewWillAppearTrigger = PublishRelay<Void>()

    func setupBinding() {
        viewWillAppearTrigger
            .withLatestFrom(valueUseCase.value)
            .map(Event.changeSliderValue)
            .bind(to: eventRelay)
            .disposed(by: disposeBag)
    }

    func sliderValueDidChanged(value: Float) {
        valueUseCase.updateValue(value: value)
    }

    func viewWillAppear() {
        viewWillAppearTrigger.accept(())
    }
}

extension ViewModel: ViewModelType {
    var inputs: ViewModelInput {
        return self
    }

    var outputs: ViewModelOutput {
        return self
    }
}
