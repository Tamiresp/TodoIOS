//
//  ListCollectionViewCell.swift
//  TodoList
//
//  Created by tamires.p.silva on 19/08/20.
//  Copyright © 2020 Tamires. All rights reserved.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var firstTaskLabel: UILabel!
    @IBOutlet weak var thirdTaskLabel: UILabel!
    @IBOutlet weak var collectionViewCell: UIView!
    @IBOutlet weak var secondTaskLabel: UILabel!
    @IBOutlet weak var checkFirst: UIButton!
    @IBOutlet weak var checkSecond: UIButton!
    @IBOutlet weak var checkThird: UIButton!
    
    
    var home: [String] = []
    var onPriority: [String] = []
    var daily: [String] = []
    
    var data: Types? {
        didSet {
            guard let data = data else {return}
            typeLabel.text = data.title
            collectionViewCell.backgroundColor = data.color
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewCell.backgroundColor = UIColor.lightGray
        configureCheck()
        checkThird.isHidden = true
        checkSecond.isHidden = true
        checkFirst.isHidden = true
    }
    
    func configure(with model: Tasks) {
        firstTaskLabel.text = "No tasks"
        secondTaskLabel.text = "No tasks"
        thirdTaskLabel.text = "No tasks"
        
        for i in TodoDataSource.share.todos {
            if i.type == .daily {
                daily.append(i.descTask)
            }
            if i.type == .onPriority {
                onPriority.append(i.descTask)
            }
            if i.type == .home {
                home.append(i.descTask)
            }
        }
        
        if data?.title == "DAILY" {
           labelsDesc(list: daily)
        }
        
        if data?.title == "ONPRIORITY" {
            labelsDesc(list: onPriority)
        }
        
        if data?.title == "HOME" {
            labelsDesc(list: home)
        }
    }
    
    private func labelsDesc(list: [String]) {
        if list.count == 1 {
            firstTaskLabel.text = list[0].description
            checkFirst.isHidden = false
        } else if list.count == 2{
            firstTaskLabel.text = list[1].description
            secondTaskLabel.text = list[0].description
            checkFirst.isHidden = false
            checkSecond.isHidden = false
        } else if list.count > 2{
            firstTaskLabel.text = list[2].description
            secondTaskLabel.text = list[1].description
            thirdTaskLabel.text = list[0].description
            checkThird.isHidden = false
            checkSecond.isHidden = false
            checkFirst.isHidden = false
        }
    }
    
    private func configureCheck() {
        checkFirst.layer.borderWidth = 1
        checkFirst.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        checkFirst.layer.cornerRadius = 5
        
        checkSecond.layer.borderWidth = 1
        checkSecond.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        checkSecond.layer.cornerRadius = 5
        
        checkThird.layer.borderWidth = 1
        checkThird.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        checkThird.layer.cornerRadius = 5
    }
    
    @IBAction func isSelected(_ sender: Any) {
        checkText(label: firstTaskLabel)
        checkFirst.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    @IBAction func isSelectedSecond(_ sender: Any) {
        checkText(label: secondTaskLabel)
        checkSecond.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    @IBAction func isSelectedThird(_ sender: Any) {
        checkText(label: thirdTaskLabel)
        checkThird.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    
    private func checkText(label: UILabel) {
        let string: NSMutableAttributedString =  NSMutableAttributedString(string: label.text!)
        string.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, string.length))
        label.attributedText = string
    }
    
    
    func configure2() {
        firstTaskLabel.text = "No tasks"
        secondTaskLabel.text = "No tasks"
        thirdTaskLabel.text = "No tasks"
    }
}
