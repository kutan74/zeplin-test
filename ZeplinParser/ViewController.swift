//
//  ViewController.swift
//  ZeplinParser
//
//  Created by KUTAN ÇINGISIZ on 11.03.2020.
//  Copyright © 2020 KUTAN ÇINGISIZ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        readJson()
    }
    
}

extension ViewController {
    func readJson() {
        if let path = Bundle.main.path(forResource: "zeplin", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let components = try JSONDecoder().decode(ZeplinScreenComponents.self, from: data)
                self.parseComponents(component: components)
              } catch {
                   // handle error
                print(error.localizedDescription)
              }
        }
    }
}

extension ViewController {
    /// Parents
    func parseComponents(component: ZeplinScreenComponents) {
        let componentLayers = component.layers
        
        componentLayers.forEach {
            if let layers = $0.layers {
                handleMultipleLayer(forLayer: layers, withParent: $0)
            } else {
                handleSingleLayer(forLayer: $0)
            }
        }
    }
}

extension ViewController {
    func handleMultipleLayer(forLayer layers: [ZeplinLayer], withParent: ZeplinLayer) {
        layers.forEach {
            if let layers = $0.layers {
                handleMultipleLayer(forLayer: layers, withParent: withParent)
            } else {
                handleSingleLayer(forLayer: $0)
            }
        }
    }
    
    func handleSingleLayer(forLayer layer: ZeplinLayer) {
        print(layer.name)
    }
}


struct NestedComponent {
    var parent: String
    
}
