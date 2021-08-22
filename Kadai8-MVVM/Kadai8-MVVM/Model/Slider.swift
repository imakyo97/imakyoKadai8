//
//  Slider.swift
//  Kadai8-MVVM
//
//  Created by 今村京平 on 2021/08/21.
//

import RxSwift
import RxCocoa

protocol SliderModel {
    var num: Float { get }
    func changedNum(num: Float)
}

final class Slider: SliderModel {
    var num: Float = 0

    func changedNum(num: Float) {
        self.num = num
    }
}
