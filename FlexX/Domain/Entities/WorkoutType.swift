//
//  WorkoutType.swift
//  FlexX
//
//  Created by Dhaarani M on 17/08/26.
//

import UIKit

struct WorkoutType {

    let title: String
    let subtitle: String
    let iconName: String
}

let workoutTypes = [
    WorkoutType(
        title: "Cardio",
        subtitle: "Improve endurance",
        iconName: "heart.fill"
        
    ),

    WorkoutType(
        title: "Strength Training",
        subtitle: "Build strength & muscle",
        iconName: "figure.strengthtraining.traditional"
    ),

    WorkoutType(
        title: "Flexibility",
        subtitle: "Improve mobility",
        iconName: "figure.flexibility"
    )
]
