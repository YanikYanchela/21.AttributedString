//
//  ViewController.swift
//  AttributedString
//
//  Created by Дмитрий Яновский on 4.02.24.
//

import UIKit

class ViewController: UIViewController {
    
    let label = UILabel()
    let button = UIButton()
    let button2 = UIButton()
    var colorsSegmentedControl = UISegmentedControl()
    var styleSegmentedControl = UISegmentedControl()
    var sizeSegmentedControl = UISegmentedControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        
        label.text = "Mm, she the devil She a bad lil' bitch, she a rebel\nShe put her foot to the pedal It'll take a whole lot for me to settle \nMm, she the devil She a bad lil' bitch, she a rebel\nShe put her foot to the pedal It'll take a whole lot for me to settle"

        setupLabel()
        setupButton()
        setupButton2()
        setupColorsSegmentedControls()
        setupStyleSegmentedControls()
        setupSizeSegmentedControls()
    }

    func setupLabel(){
        
        let attributedText = NSMutableAttributedString(string: label.text!)
        attributedText.addAttribute(.foregroundColor, value: UIColor.blue, range: NSRange(location: 100, length: 21))
        attributedText.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 30), range: NSRange(location: 130, length: 10))
        attributedText.addAttribute(.backgroundColor, value: UIColor.black, range: NSRange(location: 163, length: 12))

        label.attributedText = attributedText
        label.textAlignment = .center
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.heightAnchor.constraint(equalToConstant: 500)])
       
    }
    
    func customButton(button: UIButton, tittle: String, color: UIColor){
        
        button.setTitle(tittle, for: .normal)
        button.backgroundColor = color
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.black.cgColor
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 4.0
        
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
    }
    func setupButton(){
        customButton(button: button, tittle: "add Atributed", color: .orange)
       
        button.addTarget(self, action: #selector(buttonAnimation(_:)), for: .touchUpInside)
        button.addTarget(self, action: #selector(setAttributedString(_:)), for: .touchUpInside)
//        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -110),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: 130),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
           ])
    }
    
    func setupButton2(){
        customButton(button: button2, tittle: "Cancel", color: .red)
        
        button2.addTarget(self, action: #selector(buttonAnimation(_:)), for: .touchUpInside)
        button2.addTarget(self, action: #selector(resetAttributedString(_:)), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button2.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -50),
            button2.heightAnchor.constraint(equalToConstant: 50),
            button2.widthAnchor.constraint(equalToConstant: 130),
            button2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
           ])
    }
    
    func setupColorsSegmentedControls(){
        let items = ["Orange", "Purple", "Red"]
        colorsSegmentedControl = UISegmentedControl(items: items)
        colorsSegmentedControl.selectedSegmentIndex = 0
        colorsSegmentedControl.addTarget(self, action: #selector(changeColor(_:)), for: .valueChanged)
        view.addSubview(colorsSegmentedControl)
        colorsSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            colorsSegmentedControl.topAnchor.constraint(equalTo: button.topAnchor),
            colorsSegmentedControl.leadingAnchor.constraint(equalTo: button.trailingAnchor, constant: 20),
            colorsSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)])
    }
    
    func setupStyleSegmentedControls(){
        let items = ["Regular", "Bold", "Italic"]
        styleSegmentedControl = UISegmentedControl(items: items)
        styleSegmentedControl.selectedSegmentIndex = 0
        styleSegmentedControl.addTarget(self, action: #selector(changeStyle(_:)), for: .valueChanged)
        view.addSubview(styleSegmentedControl)
        styleSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            styleSegmentedControl.topAnchor.constraint(equalTo: colorsSegmentedControl.bottomAnchor, constant: 5),
            styleSegmentedControl.leadingAnchor.constraint(equalTo: button.trailingAnchor, constant: 20),
            styleSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)])
    }
    
    func setupSizeSegmentedControls(){
        let items = ["Regular", "Bold", "Italic"]
        sizeSegmentedControl = UISegmentedControl(items: items)
        sizeSegmentedControl.selectedSegmentIndex = 0
        sizeSegmentedControl.addTarget(self, action: #selector(changeSize(_:)), for: .valueChanged)
        view.addSubview(sizeSegmentedControl)
        sizeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sizeSegmentedControl.topAnchor.constraint(equalTo: styleSegmentedControl.bottomAnchor, constant: 5),
            sizeSegmentedControl.leadingAnchor.constraint(equalTo: button.trailingAnchor, constant: 20),
            sizeSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            sizeSegmentedControl.bottomAnchor.constraint(equalTo: button2.bottomAnchor)])
    }
    
    @objc func changeColor(_ sender: UISegmentedControl) {
        let color = getCurrentColor()

        guard let currentText = label.attributedText?.mutableCopy() as? NSMutableAttributedString else {
            return
        }

        currentText.addAttribute(.foregroundColor, value: color, range: NSRange(location: 0, length: currentText.length))
        label.attributedText = currentText

        animateColorChange()
    }


    @objc func changeStyle(_ sender: UISegmentedControl) {
        let font: UIFont
        switch sender.selectedSegmentIndex {
        case 0:
            font = UIFont.systemFont(ofSize: 25)
        case 1:
            font = UIFont.boldSystemFont(ofSize: 25)
        case 2:
            font = UIFont.italicSystemFont(ofSize: 25)
        default:
            font = UIFont.systemFont(ofSize: 25)
        }
        
        guard let currentText = label.attributedText?.mutableCopy() as? NSMutableAttributedString else {
            return
        }
        
        currentText.addAttribute(.font, value: font, range: NSRange(location: 0, length: currentText.length))
        label.attributedText = currentText
    }

    @objc func changeSize(_ sender: UISegmentedControl) {
        let fontSize: CGFloat
        switch sender.selectedSegmentIndex {
        case 0:
            fontSize = 20
        case 1:
            fontSize = 25
        case 2:
            fontSize = 30
        default:
            fontSize = 25
        }
        
        guard let currentText = label.attributedText?.mutableCopy() as? NSMutableAttributedString else {
            return
        }
        
        currentText.addAttribute(.font, value: UIFont.systemFont(ofSize: fontSize), range: NSRange(location: 0, length: currentText.length))
        label.attributedText = currentText
    }
    
    @objc func setAttributedString(_ sender: UIButton){
        let newAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,

        ]

        guard let currentText = label.attributedText?.mutableCopy() as? NSMutableAttributedString else {
            return
        }

        currentText.addAttributes(newAttributes, range: NSRange(location: 0, length: currentText.length))
        
        currentText.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 0, length: 3))
        currentText.addAttribute(.foregroundColor, value: UIColor.green, range: NSRange(location: 4, length: 14))
        currentText.addAttribute(.foregroundColor, value: UIColor.blue, range: NSRange(location: 21, length: 6))
        currentText.addAttribute(.foregroundColor, value: UIColor.orange, range: NSRange(location: 27, length: 25))

        currentText.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 25), range: NSRange(location: 4, length: 15))
        currentText.addAttribute(.font, value: UIFont.systemFont(ofSize: 25), range: NSRange(location: 21, length: 30))

        currentText.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 50, length: 31))

      
        label.attributedText = currentText
    }
    
    @objc func resetAttributedString(_ sender: UIButton){
        label.text = label.text
    }
    
    @objc func buttonAnimation(_ sender: UIButton) {
            UIView.animate(withDuration: 0.1, animations: {
                sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }) { finished in
                UIView.animate(withDuration: 0.1) {
                    sender.transform = .identity
                }
            }
        }
    
    func animateColorChange() {
        UIView.transition(with: label, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.label.textColor = self.getCurrentColor()
        }, completion: nil)
    }
    
    func getCurrentColor() -> UIColor {
        let selectedColorIndex = colorsSegmentedControl.selectedSegmentIndex
        switch selectedColorIndex {
        case 0:
            return .orange
        case 1:
            return .purple
        case 2:
            return .red
        default:
            return .black
        }
    }
}






    
 




