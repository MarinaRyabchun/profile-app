//
//  ProfileViewModel.swift
//  profile-app
//
//  Created by Марина Рябчун on 01.08.2023.
//

import UIKit

protocol ProfileViewModelProtocol {
    var skills: Observable<[String]> { get }
    func addSkill(_ skill: String)
    func deleteSkill(_ index: Int)
}

struct ProfileViewModel: ProfileViewModelProtocol {
    
    var skills: Observable<[String]> = Observable([])
    var mockModel = Person.example
    
    func addSkill(_ skill: String) {
        skills.value?.append(skill)
    }
    
    func deleteSkill(_ index: Int) {
        skills.value?.remove(at: index)
    }
    
}

class Observable<T> {
    var value: T? {
        didSet {
            listener?(value)
        }
    }
    init(_ value: T?) {
        self.value = value
    }
    private var listener: ((T?) -> Void)?
    func bind(_ listener: @escaping (T?) -> Void) {
        listener(value)
        self.listener = listener
    }
}

