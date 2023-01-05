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
    
    private var collectionViewA: UICollectionView?
    private var collectionViewB: UICollectionView?
    let collectionViewAIdentifier = "CollectionViewACell"
    
    let mediumConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .bold, scale: .medium)
   
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
    
    let iconArray = [
        "book",
        "film",
        "cart",
        "doc",
        "music.note.list",
        "house",
        "swift",
        "square.and.pencil",
        "link",
        "calendar"
    ]
    // swiftlint:disable:next force_try
    let realm = try! Realm()
    var checklists: Results<Checklist>!
    var color = "blue"
    var icon = "doc"
    var categoryName = "Default"
    
    private lazy var box: UIView = {
        let box = UIView()
        box.backgroundColor = .systemGray6
        return box
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "e.g. Shopping list"
        textField.delegate = self
        return textField
    }()
    
    var preview: UIView = {
        var preview = UIView()
        preview.layer.cornerRadius = 5
        preview.backgroundColor = UIColor.systemBlue
        return preview
    }()
    
    let imgView: UIImageView = {
        let imgView = UIImageView()
        imgView.tintColor = .systemGray6
        imgView.image = UIImage(systemName: "doc")
        return imgView
    }()
    
    private lazy var colorLabel: UILabel = {
        let colorLabel = UILabel()
        colorLabel.text = "Pick a checklist color"
        colorLabel.textColor = .systemBlue
        return colorLabel
    }()
    
    private lazy var iconLabel: UILabel = {
        let iconLabel = UILabel()
        iconLabel.text = "Pick a checklist icon"
        iconLabel.textColor = .systemBlue
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
        textField.snp.makeConstraints { make in
            make.top.equalTo(box.snp.top).offset(28)
            make.right.equalTo(box.snp.right).offset(-20)
            make.width.equalTo(320)
        }
        
        view.addSubview(preview)
        preview.snp.makeConstraints { make in
            make.top.equalTo(box.snp.top).offset(20)
            make.left.equalTo(box.snp.left).offset(20)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        
        view.addSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.top.equalTo(box.snp.top).offset(27)
            make.left.equalTo(box.snp.left).offset(28)
            make.height.equalTo(25)
            make.width.equalTo(25)
        }
        
        view.addSubview(colorLabel)
        colorLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(30)
            make.left.equalTo(box.snp.left).offset(20)
        }
        
        view.addSubview(collectionViewA!)
        
        collectionViewA!.snp.makeConstraints { make in
            make.top.equalTo(colorLabel.snp.bottom).offset(10)
            make.width.equalTo(450)
            make.height.equalTo(100)
            make.left.equalTo(box.snp.left).offset(20)
            make.right.equalTo(box.snp.right).offset(-20)
        }
        
        view.addSubview(iconLabel)
        iconLabel.snp.makeConstraints { make -> Void in
            make.top.equalTo(collectionViewA!.snp.bottom).offset(10)
            make.left.equalTo(box.snp.left).offset(20)
        }
        
        view.addSubview(collectionViewB!)
        
        collectionViewB!.snp.makeConstraints { make in
            make.top.equalTo(iconLabel.snp.bottom).offset(10)
            make.width.equalTo(450)
            make.height.equalTo(100)
            make.left.equalTo(box.snp.left).offset(20)
            make.right.equalTo(box.snp.right).offset(-20)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        
        let lt = UICollectionViewFlowLayout()
        lt.scrollDirection = .vertical
        lt.itemSize = CGSize(width: 40, height: 40)
        collectionViewA = UICollectionView(frame: .zero, collectionViewLayout: lt)
        
        collectionViewA?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionViewAIdentifier)
        collectionViewA?.dataSource = self
        collectionViewA?.delegate = self
        collectionViewA?.backgroundColor = .systemGray6
        
        let lt2 = UICollectionViewFlowLayout()
        lt2.scrollDirection = .vertical
        lt2.itemSize = CGSize(width: 40, height: 40)
        collectionViewB = UICollectionView(frame: .zero, collectionViewLayout: lt2)
        
        collectionViewB?.register(IconsCollectionViewCell.self, forCellWithReuseIdentifier: IconsCollectionViewCell.identifier)
        collectionViewB?.dataSource = self
        collectionViewB?.delegate = self
        collectionViewB?.backgroundColor = .systemGray6
        
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
        newCategory.icon = icon
        if textField.text != "" {
            self.save(category: newCategory)
            dismiss(animated: true, completion: nil)
        } else {
            print("Please type a task name")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionViewA {
            return colorArray.count
        } else {
            return iconArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionViewA {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewAIdentifier, for: indexPath)
        
            let name = colorArray[indexPath.row]
            let color = colors[name]
            cell.backgroundColor = color
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IconsCollectionViewCell.identifier, for: indexPath) as? IconsCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.imgView.image = UIImage(systemName: iconArray[indexPath.row], withConfiguration: mediumConfig)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionViewA {
            color = colorArray[indexPath.row]
            preview.backgroundColor = colors[color]
        } else {
            icon = iconArray[indexPath.row]
            imgView.image = UIImage(systemName: icon)
        }
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
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let MAX_LENGTH = 48
        let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        return updatedString.count <= MAX_LENGTH
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
