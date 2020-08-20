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
    @IBOutlet weak var collectionView: UICollectionView!
    
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
        
        fabButton.isHidden = traitCollection.verticalSizeClass == .compact
        isLandscape = traitCollection.verticalSizeClass == .compact
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        isLandscape = newCollection.verticalSizeClass == .compact
        fabButton.isHidden = isLandscape
        configureCollectionView(willTransition: true)
        collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
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

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Tasks.ModelType.types.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCollectionViewCellID", for: indexPath) as? ListCollectionViewCell
        else{
            return UICollectionViewCell()
        }
        //cell.configure(with: TodoDataSource.share.todos[indexPath.row])
        return cell
    }
    
    
}

extension ListViewController {
    @IBAction func insertButtonAction(_ sender: Any) {
        guard let viewController = UIStoryboard(name: "Insert", bundle: nil).instantiateInitialViewController() else { return }
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
