//
//  Exercise.swift
//  FlexX
//
//  Created by Dhaarani M on 17/08/26.
//

import Foundation

struct Exercise: Codable {

    let exerciseId: String
    let name: String
    let gifUrl: String
    let bodyParts: [String]
    let equipments: [String]
    let targetMuscles: [String]
    let secondaryMuscles: [String]
    let instructions: [String]
}
