//
//  ListViewController.swift
//  TodoList
//
//  Created by tamires.p.silva on 18/08/20.
//  Copyright © 2020 Tamires. All rights reserved.
//

import UIKit

final class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var fabButton: CircleButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fabButton.isHidden = traitCollection.verticalSizeClass == .compact
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        fabButton.isHidden = newCollection.verticalSizeClass == .compact
    }
}

//MARK: Configuration methods extension
extension ListViewController{
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "ListTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ToDoListTableViewCellID")
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TodoDataSource.share.todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListTableViewCellID") as? ListTableViewCell
        else{
            return UITableViewCell()
        }
        cell.configure(with: TodoDataSource.share.todos[indexPath.row])
        return cell
    }
    
}
