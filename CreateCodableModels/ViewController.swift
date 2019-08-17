//
//  ViewController.swift
//  CreateCodableModels
//
//  Created by Aftab Ahmed on 8/12/19.
//  Copyright © 2019 FAMCO. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var varTextView: NSTextView!
    @IBOutlet var outTextView: NSTextView!
    
    @IBOutlet weak var isCodable: NSButton!
    @IBOutlet weak var isClass: NSButton!
    @IBOutlet weak var classTextField: NSTextField!
    
    @IBAction func buildModel(_ sender: Any) {
        
        // : Codable
        let isCodableText = isCodable.state.rawValue == 1 ? ": Codable" : ""
        let isClassText = isClass.state.rawValue == 1 ? "class" : "struct"
        
        let className = classTextField.stringValue.isEmpty ? "Default" : classTextField.stringValue
        let classNameText = "\(isClassText) \(className)" + isCodableText + " {"
        let keyVals = varTextView.textStorage?.string
        
        guard var variables = keyVals?.components(separatedBy: "\n") else {
            return
        }
        
        variables = variables.compactMap{
            $0.components(separatedBy: ":")
                .first!
                .replacingOccurrences(of: " ", with: "")
                .replacingOccurrences(of: "\"", with: "")
        }
        
        var varList: [String] = []
        
        varList.append(classNameText)
        varList.append("\n")
        
        // Properties
        for variable in variables {
            let variable = "      var " + variable + ": String?"
            varList.append(variable)
        }
        varList.append("\n")
        
        // Empty initializer
        varList.append("init() {")
        varList.append("\n }")
        varList.append("\n")
        
        if isCodable.state.rawValue == 1 {
            //Coding Keys
            varList.append("enum CodingKeys: String, CodingKey {")
            for variable in variables {
                varList.append("      case \(variable)")
            }
            varList.append("}")
            varList.append("\n")
            
            // Decoder
            let req = isClass.state.rawValue == 1 ? "required " : ""
            varList.append("\(req) init(from decoder: Decoder) throws {")
            varList.append("      let container = try decoder.container(keyedBy: CodingKeys.self)")
            for variable in variables {
                varList.append("      self.\(variable) = try container.decodeIfPresent(String.self, forKey: .\(variable))")
            }
            varList.append("}")
            varList.append("\n")
            
            //Encoder
            varList.append("func encode(to encoder: Encoder) throws {")
            varList.append("      var container = encoder.container(keyedBy: CodingKeys.self)")
            for variable in variables {
                varList.append("      try container.encode(self.\(variable), forKey: .\(variable))")
            }
            varList.append("}")
            varList.append("\n")
        }
        
        varList.append("}")
        outTextView.string = varList.joined(separator: "\n")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

