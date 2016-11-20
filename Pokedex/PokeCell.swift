//
//  PokeCell.swift
//  Pokedex
//
//  Created by Fahad Rehman on 11/19/16.
//  Copyright © 2016 Codecture. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImage: UIImageView!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon : Pokemon!
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 6.0
    }
    
    func configurecell (_ pokemon: Pokemon) {
        
        self.pokemon = pokemon
        
        nameLbl.text = pokemon.name.capitalized
        thumbImage.image = UIImage(named: "\(pokemon.pokedexId)")
        
    }
    
}
