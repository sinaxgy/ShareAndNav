//
//  UniversalTableViewCell.swift
//  ShareAndNav
//
//  Created by 徐成 on 15/10/28.
//  Copyright © 2015年 徐成. All rights reserved.
//

import UIKit

enum UniversalCellStyle {
    case RightButton,RightLabel,RightSwitch,LeftILRightL,TextField//,RightObject
}
enum XuTextFieldInputType {
    case Date,CityAndArea
}

@objc protocol UniversalTableViewCellDelegate {
    func rightSwitchChanged(cell:UITableViewCell,boolValue:Bool)
}

class UniversalTableViewCell: UITableViewCell ,XuPickerViewDelegate{
    
    var delegate:UniversalTableViewCellDelegate?
    
    private var leftImageView:UIImageView?
    private var leftLabel:UILabel?
    private var rLabel:UILabel?
    private var rSwitch:UISwitch?
    private var rButton:UIButton?
    var textField:HoshiTextField?
    //var textF:HoshiTextField?
    var rightObject:NSObject?
    var leftShift:CGFloat = 0 {
        didSet{
            guard leftLabel != nil else {return}
            leftLabel?.center.x += leftShift
        }
    }
    
    var leftImage:UIImage? {
        didSet{
            guard leftImageView != nil else {return}
            leftImageView?.frame = CGRectMake(0, 0, 30, 30 * leftImage!.size.height / leftImage!.size.width)
            leftImageView?.image = leftImage
            leftImageView?.center = CGPointMake(35, XuCellHeight / 2)
            guard leftLabel != nil else {return}
            leftLabel?.center.x += 40
        }
    }
    
    var rSwitchState:Bool = false {
        didSet{
            guard rSwitch != nil else {return}
            rSwitch?.on = rSwitchState
        }
    }
    
    var leftLabelText:String? {
        didSet{
            guard leftLabel != nil else {return}
            let width = XuTextSizeMiddle * CGFloat(NSString(string: leftLabelText!).length)
            leftLabel?.frame.size = CGSizeMake(width + 10, XuTextSizeMiddle + 5)
            leftLabel?.text = leftLabelText
            leftLabel?.center = CGPointMake(25 + width / 2, XuCellHeight / 2)
        }
    }
    
    var rightLabelText:String? {
        didSet{
            guard rLabel != nil else {return}
            let width = XuTextSizeMiddle * CGFloat(NSString(string: rightLabelText!).length)
            rLabel?.frame.size = CGSizeMake(width + 10, XuTextSizeMiddle + 5)
            rLabel?.text = rightLabelText
            rLabel?.center = CGPointMake(XuWidth - width / 2 - 35, XuCellHeight / 2)
        }
    }
    
    var rightButtonTitle:String? {
        didSet{
            guard rButton != nil else {return}
            rButton?.setTitle(rightButtonTitle, forState: UIControlState.Normal)
            let width = XuTextSizeMiddle * CGFloat(NSString(string: rightButtonTitle!).length) + 5
            rButton?.frame.size = CGSizeMake(width + 10, XuTextSizeMiddle + 5)
            rButton?.center = CGPointMake(XuWidth - width / 2 - 35, XuCellHeight / 2)
        }
    }
    
    var textPlaceholder:String? {
        didSet{
            guard textField != nil else {return}
            textField?.placeholder = textPlaceholder
        }
    }
    
    var textFieldText:String? {
        didSet{
            guard textField != nil else {return}
            textField?.text = textFieldText
        }
    }
    
    var textInputType:XuTextFieldInputType? {
        didSet{
            guard textField != nil else {return}
            switch textInputType! {
            case .Date:
                let pickerView = XuPickerView(style: XuPickerStyle.Date)
                textField?.inputView = pickerView
                pickerView.delegate = self
            case .CityAndArea:
                let pickerView = XuPickerView(style: XuPickerStyle.CityAndArea)
                textField?.inputView = pickerView
                pickerView.delegate = self
            //default:break
            }
        }
    }
    
    init(universalStyle:UniversalCellStyle,reuseIdentifier:String) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        switch universalStyle {
        case .RightButton:
            self.initLeftLabel()
            self.initRightButton()
        case .RightSwitch:
            self.initLeftLabel()
            self.initRightSwitch()
        case .RightLabel:
            self.initLeftLabel()
            self.initRightLabel()
        case .LeftILRightL:
            self.initLeftLabel()
            self.initLeftImageView()
            self.initRightLabel()
        case .TextField:
            self.initRightTextField()
        //default:break
        }
    }
    
    init(rightObject:NSObject?,reuseIdentifier:String) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clearColor()
        self.initLeftLabel()
        switch rightObject {
        case nil:
            break
        case is UIView:
            self.rightObject = rightObject
            (rightObject as! UIView).center = CGPointMake(XuWidth - CGRectGetWidth((rightObject as! UIView).frame) / 2 - 30, XuCellHeight / 2)
            self.addSubview(rightObject as! UIView)
        default:break
        }
    }
    
    //MARK: -- init
    func initLeftLabel() {
        leftLabel = UILabel(frame: CGRectMake(15, 0, 0, 20))
        leftLabel?.font = UIFont.systemFontOfSize(XuTextSizeMiddle)
        leftLabel?.center.y = XuCellHeight / 2
        self.addSubview(leftLabel!)
    }
    
    func initLeftImageView() {
        leftImageView = UIImageView()
        self.addSubview(leftImageView!)
    }
    
    func initRightButton() {
        rButton = UIButton(type: UIButtonType.Custom)
        rButton?.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        rButton?.titleLabel?.font = UIFont.systemFontOfSize(XuTextSizeMiddle)
        rButton?.backgroundColor = XuColorBlue
        rButton?.frame = CGRectZero
        rButton?.layer.cornerRadius = XuCornerRadius
        self.addSubview(rButton!)
    }
    
    func initRightSwitch() {
        rSwitch = UISwitch(frame: CGRectZero)
        rSwitch?.addTarget(self, action: "rightSwitchAction:", forControlEvents: UIControlEvents.ValueChanged)
        rSwitch?.transform = CGAffineTransformMakeScale(0.7, 0.7)
        rSwitch?.center = CGPointMake(XuWidth - 45, XuCellHeight / 2)
        contentView.addSubview(rSwitch!)
    }
    
    func initRightLabel() {
        rLabel = UILabel(frame: CGRectMake(15, 0, 0, 20))
        rLabel?.font = UIFont.systemFontOfSize(XuTextSizeMiddle)
        rLabel?.center.y = XuCellHeight / 2
        rLabel?.textAlignment = NSTextAlignment.Right
        self.addSubview(rLabel!)
    }
    
    func initRightTextField() {
        textField = HoshiTextField(frame: CGRectMake(20,0,XuWidth,self.frame.height - 0))
        textField?.font = UIFont.systemFontOfSize(XuTextSizeMiddle)
        textField?.setValue(UIFont.systemFontOfSize(XuTextSizeMiddle), forKeyPath: "_placeholderLabel.font")
        textField?.autocorrectionType = UITextAutocorrectionType.No
        //rTextField?.textAlignment = NSTextAlignment.Right
        textField?.center.y = XuCellHeight / 2
        self.addSubview(textField!)
    }
    
    func setupLeft(image:UIImage,andLabel labelText:String) {
        self.leftLabelText = labelText
        self.leftImage = image
    }
    
    //MARK: --control event
    func rightButtonAction(sender:UIButton) {
        
    }
    
    func rightSwitchAction(sender:UISwitch) {
        delegate?.rightSwitchChanged(self, boolValue: sender.on)
    }
    
    //MARK: --XuPickerViewDelegate
    func XuPickerViewDidCancel() {
        textField?.resignFirstResponder()
    }
    
    func XuPickerViewDidSelected(pickerString: String) {
        textField?.text = pickerString
        print(pickerString)
        textField?.resignFirstResponder()
    }
    
    func XupickerViewDidChanged(pickerString: String) {
        textField?.text = pickerString
        print(pickerString)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
