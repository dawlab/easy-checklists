//
//  AddListViewController.swift
//  EasyChecklists
//
//  Created by Dawid Łabno on 28/12/2022.
//

import UIKit
import SnapKit
import RealmSwift

class AddListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {
    
    var onViewWillDisappear: (() -> ())?
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            onViewWillDisappear?()
        }
   
    private var collectionView: UICollectionView?
    let colorArray = [
        "red",
        "orange",
        "yellow",
        "green",
        "mint",
        "teal",
        "cyan",
        "blue",
        "indigo",
        "purple",
        "pink",
        "brown"
    ]
    // swiftlint:disable:next force_try
    let realm = try! Realm()
    var checklists: Results<Checklist>!
    var color = "blue"
    var categoryName = "Default"
    
    private lazy var box: UIView = {
        let box = UIView()
        return box
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "e.g. Shopping list"
        textField.delegate = self
        return textField
    }()
    
    private lazy var colorLabel: UIButton = {
        let colorLabel = UIButton(type: .system)
        colorLabel.setTitle("Pick a category color", for: .normal)
        return colorLabel
    }()
    
    private lazy var iconLabel: UIButton = {
        let iconLabel = UIButton(type: .system)
        iconLabel.setTitle("Pick a category icon", for: .normal)
        return iconLabel
    }()
    
    private func layout() {
        view.addSubview(box)
        
        box.snp.makeConstraints { make in
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        view.addSubview(textField)
        textField.snp.makeConstraints { make -> Void in
            make.top.equalTo(box.snp.top).offset(40)
        }
        
        view.addSubview(colorLabel)
        colorLabel.snp.makeConstraints { make -> Void in
            make.top.equalTo(textField.snp.bottom).offset(10)
        }
        
        view.addSubview(collectionView!)
        
        collectionView!.snp.makeConstraints { make in
            make.top.equalTo(colorLabel.snp.bottom).offset(10)
            make.width.equalTo(250)
            make.height.equalTo(200)
        }
        
        view.addSubview(iconLabel)
        iconLabel.snp.makeConstraints { make -> Void in
            make.top.equalTo(collectionView!.snp.bottom).offset(10)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let lt = UICollectionViewFlowLayout()
        lt.scrollDirection = .vertical
        lt.itemSize = CGSize(width: 30, height: 30)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: lt)
        guard let collectionView = collectionView else {
            return
        }
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        navigationItem.title = "Add new checklist"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(tapToDismiss(sender: )))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(tapToAddCategory(sender: )))
        layout()
    }
    
    @objc func tapToDismiss(sender: UIButton!) {
        dismiss(animated: true)
    }
    
    @objc func tapToAddCategory(sender: UIButton!) {
        let newCategory = Checklist()
        newCategory.name = textField.text!
        newCategory.color = color
        print(newCategory.color)
        self.save(category: newCategory)
        dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
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
        let name = colorArray[indexPath.row]
        let color = colors[name]
        cell.backgroundColor = color
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        color = colorArray[indexPath.row]
        print(color)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool { true }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text != "" {
            categoryName = textField.text!
        }
        textField.text = ""
    }
    
    func save(category: Checklist) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving context, \(error)")
        }
    }
}
