//
//  ViewController.swift
//  Pokedex
//
//  Created by Fahad Rehman on 11/19/16.
//  Copyright © 2016 Codecture. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout , UICollectionViewDataSource {

    @IBOutlet weak var collection: UICollectionView!
    
    var pokemon = [Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    collection.dataSource = self
        collection.delegate = self
        
        parseTocsv()
    
    }
    
    func parseTocsv() {
        
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            print(rows)
            
            for row in rows {
                
                let pokeID = Int(row["id"]!)!
                let name = row["identifier"]!
                
                //print(pokeID , name)
                
                let poke = Pokemon(name: name, pokedexId: pokeID)
                pokemon.append(poke)
            }
            
            
        } catch {
            print(error)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            let pokemon = self.pokemon[indexPath.row]
            cell.configurecell(pokemon)
            return cell
        }
        else {
            
            return UICollectionViewCell()
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemon.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 112, height: 112)
    }


}

