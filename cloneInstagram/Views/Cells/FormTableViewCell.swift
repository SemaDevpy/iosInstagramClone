//
//  FormTableViewCell.swift
//  cloneInstagram
//
//  Created by Syimyk on 2/14/21.
//  Copyright © 2021 Syimyk. All rights reserved.
//

import UIKit


protocol FormTableViewCellDelegate  : AnyObject{
    func formTableViewCell(_ cell : FormTableViewCell, didUpdateField updatedModel: EditProfileFormModel)
}

class FormTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    
    public weak var delegate : FormTableViewCellDelegate?
    
    static let identifier = "identifier"
    
    private var model : EditProfileFormModel?
    
    private let formLabel : UILabel = {
        let formLabel = UILabel()
        formLabel.textColor = .label
        formLabel.numberOfLines = 1
        
        return formLabel
    }()
    
    private let field : UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        
        return field
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.clipsToBounds = true
        contentView.addSubview(formLabel)
        contentView.addSubview(field)
        selectionStyle = .none
        field.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model : EditProfileFormModel){
        self.model = model
        formLabel.text = model.label
        field.placeholder = model.placeholder
        field.text = model.value
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        formLabel.text = nil
        field.placeholder = nil
        field.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        formLabel.frame = CGRect(x: 5, y: 0, width: contentView.width/3 , height: contentView.height)
        field.frame = CGRect(x: formLabel.right+5, y: 0, width: contentView.width - 10 - formLabel.width, height: contentView.height)
        
    }
    
    //MARK: - Field
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        model?.value = textField.text
        guard let model = model else {
            return true
        }
        delegate?.formTableViewCell(self, didUpdateField: model)
        return true
    }
    
}
