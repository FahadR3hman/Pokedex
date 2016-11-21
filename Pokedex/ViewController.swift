//
//  ViewController.swift
//  Pokedex
//
//  Created by Fahad Rehman on 11/19/16.
//  Copyright © 2016 Codecture. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout , UICollectionViewDataSource {

    @IBOutlet weak var collection: UICollectionView!
    
    @IBAction func musicbtnpressed(_ sender: UIButton!) {
        
        if player.isPlaying {
            player.pause()
            sender.alpha = 0.5
        }
        else {
            player.play()
            sender.alpha = 1.0
        }
        
    }
    
    
    var pokemon = [Pokemon]()
    
    var player : AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    collection.dataSource = self
        collection.delegate = self
        
        parseTocsv()
        audioinit()
    
    }
    
    func audioinit() {
        
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        
        do {
            
            player = try AVAudioPlayer(contentsOf: URL(string: path)!)
            player.prepareToPlay()
            player.numberOfLoops = -1
            
            player.play()
            
        } catch {
            print (error)
        }
        
        
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

