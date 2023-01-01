//
//  ListsViewController.swift
//  EasyChecklists
//
//  Created by Dawid Łabno on 13/12/2022.
//

import UIKit
import SnapKit
import CoreData

class CategoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let largeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .bold, scale: .large)
    
    private var collectionView: UICollectionView?
    
    private lazy var box: UIView = {
        let box = UIView()
        return box
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
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
        view.backgroundColor = .white
        navigationItem.title = "My checklists"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(tapAddListButton(sender: )))

        layout()
        loadItems()
    }
    
    @objc func tapAddListButton(sender: UIButton) {
        present(AddListViewController(), animated: true)
//        let alert = UIAlertController(title: "Add new list", message: "Add list", preferredStyle: .alert)
//        var textField = UITextField()
//
//        alert.addTextField { field in
//            textField = field
//            textField.placeholder = "Please type list title"
//        }
//
//        alert.addAction(UIAlertAction(title: "Add",
//                                      style: UIAlertAction.Style.default,
//                                      handler: {_ in
//            if textField.text != "" {
//                let newCategory = Category(context: self.context)
//                newCategory.name = textField.text
//                self.categories.append(newCategory)
//                self.saveItems()
//                }
//            }))
//
//        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
//        self.present(alert, animated: true, completion: nil)
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
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(10)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-10)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.categoryName.text = categories[indexPath.row].name
        cell.imgView.image = UIImage(systemName: "book", withConfiguration: largeConfig)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destinationVC = ItemsViewController()

        let cat = categories[indexPath.row]
        destinationVC.selectedCategory = cat
        navigationController?.pushViewController(destinationVC, animated: true)
    }

    func saveItems() {
        do {
            try context.save()
        } catch {
            print("Error saving context, \(error)")
        }
        collectionView!.reloadData()
    }

    func loadItems() {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        do {
          categories = try context.fetch(request)
        } catch {
            print("Error fetching data from context, \(error)")
        }
    }
}
