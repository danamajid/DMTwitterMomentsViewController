//
//  WrappedStruct.swift
//  Stories
//
//  Created by Dana Majid on 18/10/15.
//  Copyright © 2015 Dana Majid. All rights reserved.
//

import Foundation

class WrappedStruct<T> {
    let wrappedValue: T
    
    init(theValue: T) {
        wrappedValue = theValue
    }
    
    func getValue() -> T {
        return wrappedValue
    }
}

struct aStruct {
    var aValue: String
}