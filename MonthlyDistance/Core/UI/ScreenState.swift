//
//  ScreenState.swift
//  MonthlyDistance
//
//  Created by tokizo on 2023/02/12.
//

enum ScreenState<Value, Error: Swift.Error> {
    case loading
    case failed(Error)
    case empty
    case loaded(Value)
}
