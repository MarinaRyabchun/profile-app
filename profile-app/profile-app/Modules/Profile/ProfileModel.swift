//
//  ProfileModel.swift
//  profile-app
//
//  Created by Марина Рябчун on 01.08.2023.
//

import Foundation

struct Person: Decodable {
    var photo: String?
    var name: String?
    var description: String?
    var location: String?
    var resumeSummary: String?
}

struct Skill: Decodable {
    let name: String?
}

extension Person {
    static var example = Person(photo: Constants.Image.photoProfile,
                                name: "Иванов Иван",
                                description: "Middle iOS-разработчик, опыт более 2-х лет",
                                location: "Воронеж",
                                resumeSummary: "Experienced software engineer skilled in developing scalable and maintainable systems")
}
