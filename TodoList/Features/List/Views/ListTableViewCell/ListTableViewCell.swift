//
//  ListTableViewCell.swift
//  TodoList
//
//  Created by tamires.p.silva on 18/08/20.
//  Copyright © 2020 Tamires. All rights reserved.
//

import UIKit

final class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var tagView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var todoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}

extension ListTableViewCell {
    func configure(with model: Tasks) {
        tagView.backgroundColor = model.type.typeColor
        titleLabel.text = model.type.typeDescription
        todoLabel.text = model.descTask
        titleLabel.textColor = model.type.typeColor
        dateLabel.text = formatDate(model.date)
    }
    
    private func formatDate(_ date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm a"
        
        return "at \(formatter.string(from: date))"
    }
}
