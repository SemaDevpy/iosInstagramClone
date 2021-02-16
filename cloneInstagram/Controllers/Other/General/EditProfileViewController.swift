//
//  EditProfileViewController.swift
//  cloneInstagram
//
//  Created by Syimyk on 1/31/21.
//  Copyright © 2021 Syimyk. All rights reserved.
//

import UIKit


struct EditProfileFormModel {
    let label : String
    let placeholder : String
    var value : String?
}




final class EditProfileViewController: UIViewController, UITableViewDataSource{
    
    
    
    
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.identifier)
        
        return tableView
    }()
    
    
    private var models = [[EditProfileFormModel]]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.tableHeaderView = createTableHeaderView()
        tableView.dataSource = self
        
        configureModels()
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain , target: self, action: #selector(didTapCancel))
    }
    
    
    
    private func configureModels(){
        //name, username , website, and bio
        let section1Labels = ["Name","Username","Bio"]
        var section1 = [EditProfileFormModel]()
        for label in section1Labels{
            let model = EditProfileFormModel(label: label, placeholder: "Enter \(label)", value: nil)
            section1.append(model)
        }
        models.append(section1)
        //email, phone, gender
        let section2Labels = ["Email","Phone","Gender"]
        var section2 = [EditProfileFormModel]()
        for label in section2Labels{
            let model = EditProfileFormModel(label: label, placeholder: "Enter \(label)", value: nil)
            section2.append(model)
        }
        models.append(section2)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    //MARK: - ACtion
    @objc func didTapSave(){
        
     dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapChangeProfilePicture(){
        let actionSheet = UIAlertController(title:  "Profile Picture", message: "Change profile picture", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style:  .default, handler:{ _ in
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Choose from Library", style:  .default, handler:{ _ in
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style:  .cancel, handler: nil ))
        
        present(actionSheet, animated: true)
    }
    
    
    
    
    //MARK: - TableView
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        guard section == 0 else {
            return nil
        }
        return "Private Information"
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier, for: indexPath) as! FormTableViewCell
        cell.configure(with: model)
        cell.delegate = self
        return cell
    }
    
    func createTableHeaderView() -> UIView{
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width ,height: (view.height / 4)))
        
        let profilePhotoButton = UIButton(frame: CGRect(x: (view.width - (header.height/1.5))/2, y: (header.height -  header.height/1.5)/2, width: header.height/1.5, height: header.height/1.5))
        profilePhotoButton.layer.cornerRadius = (header.height/1.5) / 2.0
        profilePhotoButton.layer.masksToBounds = true
        profilePhotoButton.addTarget(self, action: #selector(didTapProfilePhotoButton), for: .touchUpInside)
        profilePhotoButton.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        profilePhotoButton.layer.borderWidth = 1
        profilePhotoButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        profilePhotoButton.tintColor = .label
        
        
        header.addSubview(profilePhotoButton)
        return header
    }
    
    @objc private func didTapProfilePhotoButton(){
        
    }
    
    
    
}


extension EditProfileViewController : FormTableViewCellDelegate{
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updatedModel: EditProfileFormModel) {
        print("\(updatedModel.value ?? "nil")")
    }
}
