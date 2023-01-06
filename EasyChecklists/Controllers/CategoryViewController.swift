//
//  ListsViewController.swift
//  EasyChecklists
//
//  Created by Dawid Łabno on 13/12/2022.
//

import UIKit
import SnapKit
import RealmSwift

class CategoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    // swiftlint:disable:next force_try
    let realm = try! Realm()
    var checklists: Results<Checklist>?

    let largeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .bold, scale: .large)
    
    private var collectionView: UICollectionView?
    
    private lazy var box: UIView = {
        let box = UIView()
        box.backgroundColor = .systemGray6
        return box
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    
        let lt = UICollectionViewFlowLayout()
        lt.scrollDirection = .vertical
        lt.itemSize = CGSize(width: 180, height: 140)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: lt)
        guard let collectionView = collectionView else {
            return
        }
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemGray6
        view.backgroundColor = .systemGray6
        navigationItem.title = "My checklists"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(tapAddListButton(sender: )))
        
        if traitCollection.userInterfaceStyle == .light {
            navigationController?.navigationBar.tintColor = .black
        } else {
            navigationController?.navigationBar.tintColor = .white
        }
        layout()
    }
    
    @objc func tapAddListButton(sender: UIButton) {
        let addVC = AddListViewController()
                      addVC.onViewWillDisappear = {
                          self.collectionView?.reloadData()
                    }
                  let navigationController = UINavigationController(rootViewController: addVC)
        present(navigationController, animated: true)
    }
    
    private func layout() {
        view.addSubview(box)
        
        box.snp.makeConstraints { make -> Void in
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        view.addSubview(collectionView!)
        
        collectionView!.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(12)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(10)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-10)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return checklists?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.categoryName.text = checklists?[indexPath.row].name
        
        let colors: [String: UIColor] = [
            "red": .systemRed,
            "orange": .systemOrange,
            "yellow": .systemYellow,
            "green": .systemGreen,
            "mint": .systemMint,
            "teal": .systemTeal,
            "cyan": .systemCyan,
            "blue": .systemBlue,
            "indigo": .systemIndigo,
            "purple": .systemPurple,
            "pink": .systemPink,
            "brown": .systemBrown
        ]
        
        if let name = checklists?[indexPath.row].color {
            if let color = colors[name] {
                cell.rectangle.backgroundColor = color
            }
        }
        let icon = checklists?[indexPath.row].icon
        cell.imgView.image = UIImage(systemName: icon ?? "doc", withConfiguration: largeConfig)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destinationVC = ItemsViewController()

        let cat = checklists?[indexPath.row]
        destinationVC.selectedCategory = cat
        navigationController?.pushViewController(destinationVC, animated: true)
        navigationItem.backButtonDisplayMode = .minimal
    }

    func loadCategories() {
        checklists = realm.objects(Checklist.self)
    }
    
    func refreshView() {
        collectionView?.reloadData()
    }
}
