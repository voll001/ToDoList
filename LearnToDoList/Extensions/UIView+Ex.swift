//
//  UIView+Ex.swift
//  LearnToDoList
//
//  Created by Оля on 08.02.2021.
//

import UIKit


extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach {
            self.addSubview($0)
        }
    }
}
