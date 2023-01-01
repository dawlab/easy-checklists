//
//  AddListViewController.swift
//  EasyChecklists
//
//  Created by Dawid Łabno on 28/12/2022.
//

import UIKit
import SnapKit
import CoreData

class AddListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {
    
    private var collectionView: UICollectionView?
    let colorArray = [UIColor.red, UIColor.green, UIColor.blue]
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var color = UIColor.systemBlue
    var categoryName = "Default"
    let itemsVC = ItemsViewController()
    
    private lazy var box: UIView = {
        let box = UIView()
        return box
    }()
    
    private lazy var cancelButton: UIButton = {
        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.titleLabel?.tintColor = .systemBlue
        cancelButton.titleLabel?.font = .systemFont(ofSize: 16)
        cancelButton.addTarget(self, action: #selector(tapToDismiss), for: .touchUpInside)
        return cancelButton
    }()
    
    private lazy var doneButton: UIButton = {
        let doneButton = UIButton(type: .system)
        doneButton.setTitle("Done", for: .normal)
        doneButton.titleLabel?.tintColor = .systemBlue
        doneButton.titleLabel?.font = .systemFont(ofSize: 16)
        doneButton.addTarget(self, action: #selector(tapToAddCategory), for: .touchUpInside)
        return doneButton
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
        
        view.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.left.equalTo(box).offset(10)
            make.top.equalTo(box.snp.top).offset(10)
        }
        
        view.addSubview(doneButton)
        doneButton.snp.makeConstraints { make -> Void in
            make.right.equalTo(box).offset(-10)
            make.top.equalTo(box.snp.top).offset(10)
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
            make.height.equalTo(40)
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
        lt.itemSize = CGSize(width: 40, height: 40)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: lt)
        guard let collectionView = collectionView else {
            return
        }
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        layout()
    }
    
    @objc func tapToDismiss(sender: UIButton!) {
      dismiss(animated: true)
    }
    
    @objc func tapToAddCategory(sender: UIButton!) {
        let newCategory = Category(context: context)
        newCategory.name = categoryName
        categories.append(newCategory)
        saveItems()
        itemsVC.reloadData()
        dismiss(animated: true, completion: nil)
//        newCategory.color = String(color)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = colorArray[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        color = colorArray[indexPath.row]
        
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
    
    func saveItems() {
        do {
            try context.save()
        } catch {
            print("Error saving context, \(error)")
        }
    }
}
