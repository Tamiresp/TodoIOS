//
//  ListViewController.swift
//  TodoList
//
//  Created by tamires.p.silva on 18/08/20.
//  Copyright © 2020 Tamires. All rights reserved.
//

import UIKit

struct Types {
    var title: String
    var color: UIColor
}

final class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var fabButton: CircleButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var label = UILabel()
    
    let data = [Types(title: "ONPRIORITY", color: UIColor(named: "on_priority_color")!), Types(title: "DAILY", color: UIColor(named: "daily_color")!), Types(title: "HOME", color: UIColor(named: "home_color")!)]
    
    var isLandscape: Bool = false {
        didSet {
            animatedView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confNavigationBar()
        configureTableView()
        configureCollectionView()
        
        label.text = "Adicione uma nova atividade"
        label.textAlignment = .center
        
        fabButton.isHidden = traitCollection.verticalSizeClass == .compact
        isLandscape = traitCollection.verticalSizeClass == .compact
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        isLandscape = newCollection.verticalSizeClass == .compact
        fabButton.isHidden = isLandscape
        configureCollectionView(willTransition: true)
        collectionView.reloadData()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        collectionView.reloadData()
    }
    
    private func confNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
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
    
    private func configureCollectionView(willTransition: Bool = false) {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.layer.cornerRadius = 10
        
        var width = UIScreen.main.bounds.size.width
        var height = UIScreen.main.bounds.size.height
        
        if willTransition {
            width = UIScreen.main.bounds.size.height
            height = UIScreen.main.bounds.size.width
            
        }
        
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: ((width - 128) / 3), height: height * 0.7)
        collectionView.collectionViewLayout = layout
        
        let nib = UINib(nibName: "ListCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "ListCollectionViewCellID")
    }
    
    private func animatedView() {
        UIView.animate(withDuration: 0.3) {
            self.tableView.isHidden = self.isLandscape
            self.collectionView.isHidden = !self.isLandscape
        }
    }
    
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundView = TodoDataSource.share.todos.count == 0 ? label : nil
        return TodoDataSource.share.todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListTableViewCellID") as? ListTableViewCell
            else{
                return UITableViewCell()
        }
        cell.configure(with: TodoDataSource.share.todos[indexPath.row])
            
        cell.actionBlock = {
           guard let viewController = UIStoryboard(name: "Insert", bundle: nil).instantiateInitialViewController() else { return }
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            TodoDataSource.share.todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if TodoDataSource.share.todos.count == 0 {
            self.collectionView.setEmptyMessage("Adicione uma nova atividade")
            return 0
        } else {
            self.collectionView.backgroundView = nil
            return Tasks.ModelType.types.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCollectionViewCellID", for: indexPath) as? ListCollectionViewCell
            else{
                return UICollectionViewCell()
        }
        
        cell.data = self.data[indexPath.row]
        
        if TodoDataSource.share.todos.count > indexPath.row {
            cell.configure(with: TodoDataSource.share.todos[indexPath.row])
        } else {
           cell.configure2()
        }
       
        return cell
    }
}

extension ListViewController {
    @IBAction func insertButtonAction(_ sender: Any) {
        guard let viewController = UIStoryboard(name: "Insert", bundle: nil).instantiateInitialViewController() else { return }
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}

extension UICollectionView {
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textAlignment = .center;
        
        self.backgroundView = messageLabel;
    }
}
