//
//  GreenViewModel.swift
//  Kadai8-MVVM
//
//  Created by 今村京平 on 2021/08/21.
//

import RxSwift
import RxCocoa

protocol GreenViewModelInput {
    func changedNum(num: Float)
}

protocol GreenViewModelOutput {
    var num: Float { get }
    var driver: Driver<Float> { get }
}

protocol GreenViewModelType {
    var input: GreenViewModelInput { get }
    var output: GreenViewModelOutput { get }
}

final class GreenViewModel: GreenViewModelOutput, GreenViewModelInput {

    let model: SliderModel
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

extension GreenViewModel: GreenViewModelType {
    var input: GreenViewModelInput {
        return self
    }

    var output: GreenViewModelOutput {
        return self
    }
}
