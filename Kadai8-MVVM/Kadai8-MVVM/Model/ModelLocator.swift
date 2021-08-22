//
//  ModelLocator.swift
//  Kadai8-MVVM
//
//  Created by 今村京平 on 2021/08/22.
//

import Foundation

final class ModelLocator {
    static let shared = ModelLocator()
    let valueUseCase = ValueUseCase()
    private init() {}
}
