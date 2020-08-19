//
//  CircleButton.swift
//  TodoList
//
//  Created by tamires.p.silva on 19/08/20.
//  Copyright © 2020 Tamires. All rights reserved.
//

import UIKit

final class CircleButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = frame.size.height / 2
    }
}
