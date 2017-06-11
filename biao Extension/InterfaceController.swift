//
//  InterfaceController.swift
//  biao Extension
//
//  Created by 张金林 on 2017/3/27.
//  Copyright © 2017年 Nathan Gitter. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        //updateDisplayViews(animated: false)
        
        
    }
    
    private let pets: [PetType: Pet] = [
        .dog: Pet(type: .dog),
        .cat: Pet(type: .cat),
        .bird: Pet(type: .bird),
        .bunny: Pet(type: .bunny),
        .fish: Pet(type: .fish)
    ]
    
    private var currentPet: Pet! {
        didSet {
            
            petImageView.setImageNamed("dog")
        
        }
    }
    
    
    @IBOutlet var fed: WKInterfaceLabel!

    @IBOutlet var petImageView: WKInterfaceImage!

    @IBOutlet var happy: WKInterfaceLabel!
    
    @IBAction func feed() {
        currentPet.feed()
        updateStats()
    }

    @IBAction func play() {
        currentPet.play()
        updateStats()
    }
    
    @IBAction func switchPet(_ sender: Any) {
        if(currentPet.image == #imageLiteral(resourceName: "dog")){
            currentPet = pets[.bird]
            petImageView.setImageNamed("bird")
            updateStats()
            
        }else if(currentPet.image == #imageLiteral(resourceName: "bird")){
            currentPet = pets[.cat]
            petImageView.setImageNamed("cat")
            updateStats()
        }else if(currentPet.image == #imageLiteral(resourceName: "cat")){
            currentPet = pets[.bunny]
            petImageView.setImageNamed("bunny")
            updateStats()
        }else if(currentPet.image == #imageLiteral(resourceName: "bunny")){
            currentPet = pets[.fish]
            petImageView.setImageNamed("fish")
            updateStats()
        }else if(currentPet.image == #imageLiteral(resourceName: "fish")){
            currentPet = pets[.dog]
            petImageView.setImageNamed("dog")
            updateStats()
        }
        
    }
    
    @IBAction func swipeL(_ sender: Any) {
        if(currentPet.image == #imageLiteral(resourceName: "dog")){
            currentPet = pets[.fish]
            petImageView.setImageNamed("fish")
            updateStats()
        }else if(currentPet.image == #imageLiteral(resourceName: "fish")){
            currentPet = pets[.bunny]
            petImageView.setImageNamed("bunny")
            updateStats()
        }else if(currentPet.image == #imageLiteral(resourceName: "bunny")){
            currentPet = pets[.cat]
            petImageView.setImageNamed("cat")
            updateStats()
        }else if(currentPet.image == #imageLiteral(resourceName: "cat")){
            currentPet = pets[.bird]
            petImageView.setImageNamed("bird")
            updateStats()
        }else if(currentPet.image == #imageLiteral(resourceName: "bird")){
            currentPet = pets[.dog]
            petImageView.setImageNamed("dog")
            updateStats()
        }
    }

    
    private func updateStats() {
        fed.setText(String(currentPet.feedings))
        happy.setText(String(currentPet.playSessions))
        if(currentPet.feedings == 0){
            fed.setText("I'm hungry")
        }
        if(currentPet.playSessions == 0){
            happy.setText("Play with me")
        }
    }

    
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        currentPet = pets[.dog]

        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }


}
