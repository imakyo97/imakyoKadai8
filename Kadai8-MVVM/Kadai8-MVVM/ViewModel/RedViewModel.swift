//
//  RedViewModel.swift
//  Kadai8-MVVM
//
//  Created by 今村京平 on 2021/08/21.
//

import RxSwift
import RxCocoa

protocol RedViewModelInput {
    func changedNum(num: Float)
}

protocol RedViewModelOutput {
    var num: Float { get }
    var driver: Driver<Float> { get }
}

protocol RedViewModelType {
    var input: RedViewModelInput { get }
    var output: RedViewModelOutput { get }
}

final class RedViewModel: RedViewModelOutput, RedViewModelInput {

    private let model: SliderModel
    var num: Float { model.num }

    init(model: SliderModel) {
        self.model = model
    }

    private var relay = PublishRelay<Float>()
    var driver: Driver<Float> {
        return relay.asDriver(onErrorDriveWith: .empty())
    }

    func changedNum(num: Float) {
        model.changedNum(num: num)
        relay.accept(self.num)
    }
}

extension RedViewModel: RedViewModelType {
    var input: RedViewModelInput {
        return self
    }

    var output: RedViewModelOutput {
        return self
    }
}
