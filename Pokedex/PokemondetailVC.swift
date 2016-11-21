//
//  PokemondetailVC.swift
//  Pokedex
//
//  Created by Fahad Rehman on 11/22/16.
//  Copyright © 2016 Codecture. All rights reserved.
//

import UIKit

class PokemondetailVC: UIViewController {
    
    var pokemon1 : Pokemon!

    @IBOutlet weak var nameLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

    nameLbl.text = pokemon1.name
    
    }

   


}
