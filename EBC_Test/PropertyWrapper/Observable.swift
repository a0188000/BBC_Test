//
//  Observable.swift
//  EBC_Test
//
//  Created by 沈維庭 on 2021/7/9.
//

import Foundation

@propertyWrapper
class Observable<T> {
    
    typealias ValueChanged = ((T) -> Void)
    var _value: T { didSet { self.execute() } }
    
    private var _valueChanged: ValueChanged? { didSet { self.execute() } }
    
    private var _queue: DispatchQueue? = nil
    
    var projectedValue: Observable<T> { self }
    
    var wrappedValue: T {
        get { _value }
        set { _value = newValue }
    }
    
    init(wrappedValue: T, queue: DispatchQueue? = nil) {
        self._value = wrappedValue
        self._queue = queue
    }
    
    func binding(_ valueChanged: @escaping ValueChanged) {
        _valueChanged = valueChanged
    }
    
    public func callAsFunction(using block: @escaping ValueChanged) {
        binding(block)
    }
    
    func execute() {
        guard let valueChanged = _valueChanged else { return }
        let value = _value
        if let queue = _queue, (queue != DispatchQueue.main || Thread.isMainThread == false) {
            queue.async { valueChanged(value) }
        } else {
            valueChanged(value)
        }
    }
}
