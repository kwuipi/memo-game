//
//  Array+Shuffle.swift
//  memo
//
//  Created by Евгений Таран on 1/8/18.
//  Copyright © 2018 Artsiom Sadyryn. All rights reserved.
//

import Foundation

extension Array {
    func shuffle() -> Array {
        var newArr = self
        for i in 0..<self.count {
            let randomIndex = arc4random_uniform(UInt32(self.count - 1))
            newArr.swapAt(i, Array.Index(randomIndex))
        }
        return newArr
    }
}
