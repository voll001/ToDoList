//
//  Profile.swift
//  LearnToDoList
//
//  Created by Оля on 08.02.2021.
//

struct Profile {
    enum Sex {
        case male
        case female
    }
    
    var username: String
    var password: String
    var age: String?
    var profileImage: String?
    var sex: Sex?
    
}
