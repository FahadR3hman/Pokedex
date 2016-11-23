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

    @IBAction func backPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
        
    }
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var mainImg: UIImageView!
    
    @IBOutlet weak var descriptionLbl: UILabel!
    
    @IBOutlet weak var typeLbl: UILabel!
    
    @IBOutlet weak var defenseLbl: UILabel!
    
    @IBOutlet weak var heightLbl: UILabel!
    
    @IBOutlet weak var pokedexIdLbl: UILabel!
    
    @IBOutlet weak var weightLbl: UILabel!
    
    @IBOutlet weak var baseattackLbl: UILabel!
    
    @IBOutlet weak var nextEvoLbl: UILabel!
    
    @IBOutlet weak var currentEvoImg: UIImageView!
    
    @IBOutlet weak var nextEvoImg: UIImageView!
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

    nameLbl.text = pokemon1.name
     let img = UIImage(named: "\(pokemon1.pokedexId)")
        mainImg.image = img
        currentEvoImg.image = img
        
        pokemon1.DownloadPokemonDetail {
            self.updateUI()
        }
    
    }

    func updateUI() {
        
        defenseLbl.text = pokemon1.defense
        baseattackLbl.text = pokemon1.attack
        heightLbl.text = pokemon1.height
        weightLbl.text = pokemon1.weight
        pokedexIdLbl.text = "\(pokemon1.pokedexId)"
        typeLbl.text = pokemon1.type
        descriptionLbl.text = pokemon1.description
        
        if pokemon1.nextEvoID == "" {
            nextEvoLbl.text = "No Eavalution"
            nextEvoImg.isHidden = true
        } else {
            
            nextEvoImg.isHidden = false
            nextEvoImg.image = UIImage(named: "\(pokemon1.nextEvoID)")
             let str = "Next Evalution: \(pokemon1.nextEvoName) - Level \(pokemon1.nextEvoLvl)"
            
            nextEvoLbl.text = str 
            
            
        }
        
        
        
        
    }
   


}
