//
//  ListsViewController.swift
//  EasyChecklists
//
//  Created by Dawid Łabno on 13/12/2022.
//

import UIKit
import SnapKit
import RealmSwift
import L10n_swift

final class CategoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    // swiftlint:disable:next force_try
    let realm = try! Realm()
    var checklists: Results<Checklist>?

    let largeConfig = UIImage.SymbolConfiguration(pointSize: 25,
                                                  weight: .bold,
                                                  scale: .large)
    private var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: 180,
                                     height: 140)
        
        return UICollectionView(frame: .zero,
                                collectionViewLayout: flowLayout)
    }()
    
    private lazy var box: UIView = {
        let box = UIView()
        
        box.backgroundColor = .systemGray6
        
        return box
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    
        collectionView.register(CollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemGray6
        
        view.backgroundColor = .systemGray6
        navigationItem.title = L10n.allListsViewTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: L10n.addListIcon),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(tapAddListButton(sender: )))
        navigationController?.navigationBar.tintColor = traitCollection.userInterfaceStyle == .light ? .black : .white
        
        setupLayout()
    }
    
    @objc func tapAddListButton(sender: UIButton) {
        let addVC = AddListViewController()
        
        addVC.onViewWillDisappear = { [weak self] in
            self?.collectionView.reloadData()
        }
        
        let navigationController = UINavigationController(rootViewController: addVC)
        present(navigationController,
                animated: true)
    }
    
    private func setupLayout() {
        view.addSubview(box)
        
        box.snp.makeConstraints { make -> Void in
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(12)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(10)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-10)
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return checklists?.count ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell: CollectionViewCell = collectionView.dequeue(cellForItemAt: indexPath) else {
            return UICollectionViewCell()
        }
        cell.categoryName.text = checklists?[indexPath.row].name
        
        if let name = checklists?[indexPath.row].color {
            if let color = Color().colors[name] {
                cell.rectangle.backgroundColor = color
            }
        }
        
        cell.imgView.image = UIImage(systemName: checklists?[indexPath.row].icon ?? L10n.categoryDefaultIcon, withConfiguration: largeConfig)
        
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
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
        collectionView.reloadData()
    }
}
