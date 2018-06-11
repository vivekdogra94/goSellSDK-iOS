//
//  Measurement+Additions.swift
//  goSellSDKExample
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import enum goSellSDK.Measurement

internal extension Measurement {
    
    internal static var allCategoriesWithDefaultUnitsOfMeasurement: [Measurement] {
        
        return [
        
            .area(.squareMeters),
            .duration(.seconds),
            .length(.meters),
            .mass(.kilograms),
            .units
        ]
    }
}