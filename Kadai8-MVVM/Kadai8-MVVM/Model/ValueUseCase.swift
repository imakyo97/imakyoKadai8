//
//  ValueUseCase.swift
//  Kadai8-MVVM
//
//  Created by 今村京平 on 2021/08/22.
//

import RxSwift
import RxRelay

protocol ValueUseCaseProtocol {
    var value: Observable<Float> { get }
    func updateValue(value: Float)
}

final class ValueUseCase : ValueUseCaseProtocol {

    private var valueRelay = BehaviorRelay<Float>(value: 0)

    var value: Observable<Float> {
        valueRelay.asObservable()
    }

    func updateValue(value: Float) {
        valueRelay.accept(value)
    }
}
