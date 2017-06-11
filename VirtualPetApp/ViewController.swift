//
//  ViewController.swift
//  VirtualPetApp
//
//  Created by Nathan Gitter on 11/8/16.
//  Copyright © 2016 Nathan Gitter. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    private let pets: [PetType: Pet] = [
        .dog: Pet(type: .dog),
        .cat: Pet(type: .cat),
        .bird: Pet(type: .bird),
        .bunny: Pet(type: .bunny),
        .fish: Pet(type: .fish)
        
    ]
    
    private var currentPet: Pet! {
        didSet {
            
            petImageView.image = currentPet.image
            petView.backgroundColor = currentPet.color
            happinessDisplayView.color = currentPet.color
            hungrinessDisplayView.color = currentPet.color
            updateDisplayViews(animated: false)
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        petImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        dismiss(animated: true, completion: nil)
    }
    
    var theSound: SystemSoundID!
    @IBOutlet weak var petView: UIView!
    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var happinessLabel: UILabel!
    @IBOutlet weak var hungrinessLabel: UILabel!
    @IBAction func changepics(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil) 
    }
    
    @IBAction func filter(_ sender: Any) {
        guard let image = self.petImageView.image?.cgImage else {return}
        let openGLContext = EAGLContext(api: .openGLES3)
        let context = CIContext(eaglContext: openGLContext!)
        let ciImage = CIImage(cgImage: image)
        let filter = CIFilter(name: "CIMaximumComponent")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        //filter?.setValue(1, forKey: kCIInputIntensityKey)
        if let output = filter?.value(forKey: kCIOutputImageKey) as? CIImage {
            self.petImageView?.image = UIImage (cgImage: context.createCGImage(output, from: output.extent)!)
        }
    }
    
    

    @IBAction func filter2(_ sender: Any) {
        guard let image = self.petImageView.image?.cgImage else {return}
        let openGLContext = EAGLContext(api: .openGLES3)
        let context = CIContext(eaglContext: openGLContext!)
        let ciImage = CIImage(cgImage: image)
        let filter = CIFilter(name: "CIColorCube")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        //filter?.setValue(1, forKey: kCIInputIntensityKey)
        if let output = filter?.value(forKey: kCIOutputImageKey) as? CIImage {
            self.petImageView?.image = UIImage (cgImage: context.createCGImage(output, from: output.extent)!)
        }
    }
    
    
    @IBAction func flitttter(_ sender: Any) {
        guard let image = self.petImageView.image?.cgImage else {return}
        let openGLContext = EAGLContext(api: .openGLES3)
        let context = CIContext(eaglContext: openGLContext!)
        let ciImage = CIImage(cgImage: image)
        let filter = CIFilter(name: "CIPhotoEffectChrome")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        //filter?.setValue(1, forKey: kCIInputIntensityKey)
        if let output = filter?.value(forKey: kCIOutputImageKey) as? CIImage {
            self.petImageView?.image = UIImage (cgImage: context.createCGImage(output, from: output.extent)!)
        }
    }
    
    
    @IBOutlet weak var happinessDisplayView: DisplayView!
    @IBOutlet weak var hungrinessDisplayView: DisplayView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPet = pets[.dog]
        updateDisplayViews(animated: false)
        theSound = createSound()
    }
    
    func createSound() -> SystemSoundID {
        var soundID: SystemSoundID = 0
        let soundURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), "twang" as CFString!, "caff" as CFString!, nil)
        AudioServicesCreateSystemSoundID(soundURL!, &soundID)
        return soundID
    }
    
    private func updateDisplayViews(animated: Bool) {
        let happinessDisplayValue = CGFloat(currentPet.happiness) / 10
        let hungrinessDisplayValue = CGFloat(currentPet.foodLevel) / 10
        if animated {
            happinessDisplayView.animateValue(to: happinessDisplayValue)
            hungrinessDisplayView.animateValue(to: hungrinessDisplayValue)
            
        } else {
            happinessDisplayView.value = happinessDisplayValue
            hungrinessDisplayView.value = hungrinessDisplayValue
        }
        happinessLabel.text = "played: \(currentPet.playSessions)"
        hungrinessLabel.text = "fed: \(currentPet.feedings)"
        
        
    }
    
    // MARK: Interaction Button Actions

    @IBAction func feedButtonPressed(_ sender: UIButton) {
        currentPet.feed()
        updateDisplayViews(animated: true)
        AudioServicesPlaySystemSound(theSound)
    }
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        currentPet.play()
        updateDisplayViews(animated: true)
        AudioServicesPlaySystemSound(theSound)
    }
    
    // MARK: Animal Button Actions
    
    @IBAction func dogButtonPressed(_ sender: UIButton) {
        currentPet = pets[.dog]
        AudioServicesPlaySystemSound(theSound)
    }
    
    @IBAction func catButtonPressed(_ sender: UIButton) {
        currentPet = pets[.cat]
        AudioServicesPlaySystemSound(theSound)
    }
    
    @IBAction func birdButtonPressed(_ sender: UIButton) {
        AudioServicesPlaySystemSound(theSound)
        currentPet = pets[.bird]
    }
    
    @IBAction func guineaPigButtonPressed(_ sender: UIButton) {
        currentPet = pets[.bunny]
        AudioServicesPlaySystemSound(theSound)
        
    }
    
    @IBAction func fishButtonPressed(_ sender: UIButton) {
        currentPet = pets[.fish]
        AudioServicesPlaySystemSound(theSound)
        
    }

}
