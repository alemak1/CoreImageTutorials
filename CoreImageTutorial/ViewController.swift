//
//  ViewController.swift
//  CoreImageTutorial
//
//  Created by Aleksander Makedonski on 4/2/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController {

    let beforeFilterImageView = UIImageView()
    let afterFilterImageView = UIImageView()
    
    
    let filterGenerator: CIFilterGenerator = CIFilterGenerator.sharedInstance
    
    override func viewWillLayoutSubviews() {
        beforeFilterImageView.translatesAutoresizingMaskIntoConstraints = false
        afterFilterImageView.translatesAutoresizingMaskIntoConstraints = false
        
        /** For viewing side by side comparisons of the image before and after filtering
         
        view.addSubview(beforeFilterImageView)
        
       NSLayoutConstraint.activate([
            beforeFilterImageView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 20.0),
            afterFilterImageView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 20.0),
            beforeFilterImageView.widthAnchor.constraint(equalToConstant: 150),
            beforeFilterImageView.heightAnchor.constraint(equalToConstant: 200),
            afterFilterImageView.widthAnchor.constraint(equalTo: beforeFilterImageView.widthAnchor, multiplier: 1.0),
            afterFilterImageView.heightAnchor.constraint(equalTo: beforeFilterImageView.heightAnchor, multiplier: 1.0),
            beforeFilterImageView.leftAnchor.constraint(greaterThanOrEqualTo: view.leftAnchor, constant: 20.0),
            afterFilterImageView.leftAnchor.constraint(greaterThanOrEqualTo: beforeFilterImageView.rightAnchor, constant: 20.0)
            
        ])
        
        beforeFilterImageView.contentMode = .scaleAspectFill
        **/
        
        
        //For viewing a single image after applying filtering
        
        view.addSubview(afterFilterImageView)
        
        
        let imageViewWidth = view.bounds.width*0.90
        let imageViewHeight = view.bounds.height*0.90
        
        NSLayoutConstraint.activate([
            afterFilterImageView.widthAnchor.constraint(equalToConstant: imageViewWidth),
            afterFilterImageView.heightAnchor.constraint(equalToConstant: imageViewHeight),
            afterFilterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            afterFilterImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
       // afterFilterImageView.contentMode = .scaleAspectFill
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
    
        //Filters 1 and 2: Vignette Effect and Vignette
        /**
        let vignetteAttributes = [
            kCIInputImageKey: ciImage2,
            kCIInputIntensityKey: NSNumber(value: 10.30),
            kCIInputRadiusKey: NSNumber(value: 3.0)
        ]
        
        let vignetteFilterParameters = [
            kCIInputImageKey: ciImage1,
            kCIInputIntensityKey: NSNumber(value: 4.00),
            kCIInputRadiusKey: NSNumber(value: 1.00),
            kCIInputCenterKey: CIVector(cgPoint: CGPoint(x: 100, y: 100))
            
        ]
        
        let filter1 = CIFilter(name: "CIVignetteEffect", withInputParameters: vignetteFilterParameters)
        
        let filter2 = CIFilter(name: "CIVignette", withInputParameters: vignetteAttributes)
        
        //Filter 3: Color Invert
        let filter3Params = [
            kCIInputImageKey: ciImage3
        ]
        
        let filter3 = CIFilter(name: "CIColorInvert", withInputParameters: filter3Params)!
        
        **/
        
        //Category: Color Adjust
        
        
        
        //Filter 5: Tone Curve
        /**
        let toneCurveParams = [
            kCIInputImageKey: CIImage(cgImage: #imageLiteral(resourceName: "NationalPalace8").cgImage!)
            
        ]
        
        let toneCurveFilter = CIFilter(name: "CIToneCurve", withInputParameters: toneCurveParams)!
        
        toneCurveFilter.setDefaults()
        **/
      
        
        //Filter 6: Hue Adjust
        /**
        let filterAdjustParams = [
            kCIInputImageKey: CIImage(cgImage: #imageLiteral(resourceName: "NationalPalace8").cgImage!),
            kCIInputAngleKey: NSNumber(value: 90)
        ]
        
        let hueAdjustFilter = CIFilter(name: "CIHueAdjust", withInputParameters: filterAdjustParams)!
        
         **/
        
        
       
    
       // afterFilterImageView.image = UIImage(cgImage: cgImageRef!)
        
        
        //MARK: *********** Test for Different Generator Filters
        
        let color1 = CIColor(red: 0.50, green: 0.50, blue: 0.50)
        let color2 = CIColor(red: 0.50, green: 0.50, blue: 0.50)
        let cgRect = CGRect(x: 0, y: 0, width: 2000, height: 1500)
        let centerPoint = CIVector(x: 100, y: 50)
        
        //let cgImageRef = filterGenerator.generateStripedCGImage(withFirstStripeColorOf: color1, andSecondStripeColorOf: color2, width: 20.00, contrast: 20.00, cgRect: cgRect, centerPoint: centerPoint)!
        
        //let cgImageRef2 = filterGenerator.generateSunbeamCGImage(cgRect: cgRect, inputCenter: centerPoint, inputColor: color2, inputSunRadius: 20.0, inputMaxStriationRadius: 6.58, inputStriationStrength: 0.50, inputStriationContrast: 1.38, inputTime: 0.00)!
        
        //let cgImageRef3 = filterGenerator.generateLenticularHaloCGImage(cgRect: cgRect, inputCenter: centerPoint, inputColor: color1, inputHaloRadius: 15.00, inputHaloWidth: 27.00, inputHaloOverlap: 0.77, inputStriationStrength: 0.50, inputStriationContrast: 1.00, inputTime: 5.00)!
        
        //let cgImageRef4 = filterGenerator.generateCheckerboardCGImage(cgRect: cgRect, inputCenter: centerPoint, color1: color1, color2: color2, inputWidth: 20.00, inputSharpness: 1.00)!
        
        let cgImage = #imageLiteral(resourceName: "NationalPalaceFrontEntrance1").cgImage!
        let ciImage = CIImage(cgImage: cgImage)
        
        let cgImageRef5 = filterGenerator.generateBoxBlurCGImage(cgRect: cgRect, inputImage: ciImage, inputRadius: 30.0)!
     
        
        let vector = CIVector(x: 150, y: 150)
        let zoomBlurCIImage = BlurFilterGenerator.generateZoomBlurCIImage(inputImage: ciImage, inputCenter: vector, inputAmount: 10)!
        
        let motionBlurImage = BlurFilterGenerator.generateMotionBlurCIImage(inputImage: ciImage, inputRadius: 20.0, inputAngle: 20.0)!
        
    
        afterFilterImageView.image = UIImage(ciImage: motionBlurImage)
        
       
        
      
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


/**
 Optional(["CIAttributeFilterAvailable_iOS": 7, "CIAttributeFilterDisplayName": Vignette Effect, 
 
 "inputCenter": {
 CIAttributeClass = CIVector;
 CIAttributeDefault = "[150 150]";
 CIAttributeDescription = "The center of the effect as x and y coordinates.";
 CIAttributeDisplayName = Center;
 CIAttributeType = CIAttributeTypePosition;
 }, 
 
 "inputIntensity": {
 CIAttributeClass = NSNumber;
 CIAttributeDefault = 1;
 CIAttributeDescription = "The intensity of the effect.";
 CIAttributeDisplayName = Intensity;
 CIAttributeIdentity = 0;
 CIAttributeMax = 1;
 CIAttributeMin = "-1";
 CIAttributeSliderMax = 1;
 CIAttributeSliderMin = "-1";
 CIAttributeType = CIAttributeTypeScalar;
 }, 
 "inputImage": {
 CIAttributeClass = CIImage;
 CIAttributeDescription = "The image to use as an input image. For filters that also use a background image, this is the foreground image.";
 CIAttributeDisplayName = Image;
 CIAttributeType = CIAttributeTypeImage;
 }, "inputRadius": {
 CIAttributeClass = NSNumber;
 CIAttributeDefault = 150;
 CIAttributeDescription = "The distance from the center of the effect.";
 CIAttributeDisplayName = Radius;
 CIAttributeMin = 0;
 CIAttributeSliderMax = 2000;
 CIAttributeSliderMin = 0;
 CIAttributeType = CIAttributeTypeDistance;
 }, "inputFalloff": {
 CIAttributeClass = NSNumber;
 CIAttributeDefault = "0.5";
 CIAttributeDisplayName = Falloff;
 CIAttributeMax = 1;
 CIAttributeMin = 0;
 CIAttributeSliderMax = 1;
 CIAttributeSliderMin = 0;
 CIAttributeType = CIAttributeTypeScalar;
 }, "CIAttributeFilterAvailable_Mac": 10.9, "CIAttributeFilterName": CIVignetteEffect, "CIAttributeReferenceDocumentation": http://developer.apple.com/library/ios/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIVignetteEffect, "CIAttributeFilterCategories": <__NSArrayI 0x60000007e040>(
 CICategoryColorEffect,
 CICategoryVideo,
 CICategoryInterlaced,
 CICategoryStillImage,
 CICategoryBuiltIn
 )
 ])

 
 
 **/

