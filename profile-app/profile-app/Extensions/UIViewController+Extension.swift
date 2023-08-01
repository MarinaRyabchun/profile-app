//
//  UIViewController+Extension.swift
//  profile-app
//
//  Created by Марина Рябчун on 01.08.2023.
//

import UIKit

extension UIViewController {
    
    func showAlertAddSkills() {
        let alertController = UIAlertController(title: "Добавление навыка", message: "Введите название навыка, которым вы владеете", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .default, handler: nil)
        let addSkillAction = UIAlertAction(title: "Добавить", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(addSkillAction)
        present(alertController, animated: true, completion: nil)
    }
}
