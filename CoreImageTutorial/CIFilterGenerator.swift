//
//  CIFilterGenerator.swift
//  CoreImageTutorial
//
//  Created by Aleksander Makedonski on 4/2/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import CoreImage


class CIFilterGenerator{
    

    static let sharedInstance =  CIFilterGenerator()
    
    private var coreImageContext: CIContext!
    
    
    //MARK: *********** INITIALIZER FOR CICONTEXT
    private init(){
        coreImageContext = CIContext()
    }
    
    
    /**
    init(eagleContext: EAGLContext) {
        coreImageContext = CIContext(eaglContext: eagleContext)
    }
    
    init(eaglContext: EAGLContext, options: [String: Any]?) {
        coreImageContext = CIContext(eaglContext: eaglContext, options: options)
    }
    
    init(options: [String: Any]?) {
        coreImageContext = CIContext(options: options)
    }
     **/
    
    
    
    //MARK: ********** STRIPES FILTER
    
    func generateStripedCGImage(withFirstStripeColorOf color1: CIColor, andSecondStripeColorOf color2: CIColor, width: Double, contrast: Double, cgRect: CGRect, centerPoint: CIVector) -> CGImage?{
        
        guard let ciImage = generateStripedCIImage(color1: color1, color2: color2, width: width, contrast: contrast, centerPoint: centerPoint) else { return nil }
        
        return coreImageContext.createCGImage(ciImage, from: cgRect)
    }
    
    func generateStripedCIImage(color1: CIColor, color2: CIColor, width: Double, contrast: Double, centerPoint: CIVector) -> CIImage?{
        
        let inputParameters = [
            "inputColor0" : color1,
            "inputColor1" : color2,
            kCIInputWidthKey: NSNumber(value: width),
            kCIInputSharpnessKey: NSNumber(value: contrast),
            kCIInputCenterKey: centerPoint
        ]
        
        
        guard let stripesFilter = CIFilter(name: "CIStripesGenerator", withInputParameters: inputParameters) else { return nil }
        
        return stripesFilter.outputImage
        
        
    }
    
    //MARK: ********* SUNBEAMS FILTER
    
    func generateSunbeamCGImage(cgRect: CGRect, inputCenter: CIVector, inputColor: CIColor, inputSunRadius: Double = 40.0, inputMaxStriationRadius: Double = 2.58, inputStriationStrength: Double = 0.50, inputStriationContrast: Double = 1.38, inputTime: Double = 0.00) -> CGImage?{
        
        guard let ciImage = generateSunbeamCIImage(inputCenter: inputCenter, inputColor: inputColor, inputSunRadius: inputSunRadius, inputMaxStriationRadius: inputMaxStriationRadius, inputStriationStrength: inputStriationStrength, inputStriationContrast: inputStriationContrast, inputTime: inputTime) else { return nil }
        
        return coreImageContext.createCGImage(ciImage, from: cgRect)
    }
    
    func generateSunbeamCIImage(inputCenter: CIVector, inputColor: CIColor, inputSunRadius: Double = 40.0, inputMaxStriationRadius: Double = 2.58, inputStriationStrength: Double = 0.50, inputStriationContrast: Double = 1.38, inputTime: Double = 0.00) -> CIImage?{
        
        let inputParameters = [
            kCIInputCenterKey: inputCenter,
            kCIInputColorKey: inputColor,
            "inputSunRadius": NSNumber(value: inputSunRadius),
            "inputMaxStriationRadius": NSNumber(value: inputMaxStriationRadius),
            "inputStriationStrength": NSNumber(value: inputStriationStrength),
            "inputStriationContrast": NSNumber(value: inputStriationContrast),
            kCIInputTimeKey: NSNumber(value: inputTime)
            
        
        ]
        
        guard let sunbeamFilter = CIFilter(name: "CISunbeamsGenerator", withInputParameters: inputParameters) else { return nil }
        
        
        return sunbeamFilter.outputImage
    }
    
    
    //MARK: *********** LENTICULAR HALO
    
    func generateLenticularHaloCGImage(cgRect: CGRect, inputCenter: CIVector, inputColor: CIColor, inputHaloRadius: Double = 70.00, inputHaloWidth: Double = 87.00, inputHaloOverlap: Double = 0.77, inputStriationStrength: Double = 0.50, inputStriationContrast: Double = 1.00, inputTime: Double = 0.00) -> CGImage?{
        
        guard let ciImage = generateLenticularHaloCIImage(inputCenter: inputCenter, inputColor: inputColor, inputHaloRadius: inputHaloRadius, inputHaloWidth: inputHaloWidth, inputHaloOverlap: inputHaloOverlap, inputStriationStrength: inputStriationStrength, inputStriationContrast: inputStriationContrast, inputTime: inputTime) else { return nil }
        
        return coreImageContext.createCGImage(ciImage, from: cgRect)
    }
    
    
    func generateLenticularHaloCIImage(inputCenter: CIVector, inputColor: CIColor, inputHaloRadius: Double = 70.00, inputHaloWidth: Double = 87.00, inputHaloOverlap: Double = 0.77, inputStriationStrength: Double = 0.50, inputStriationContrast: Double = 1.00, inputTime: Double = 0.00) -> CIImage?{
    
        let inputParams = [
            kCIInputCenterKey: inputCenter,
            kCIInputColorKey: inputColor,
            "inputHaloRadius": NSNumber(value: inputHaloRadius),
            "inputHaloWidth": NSNumber(value: inputHaloWidth),
            "inputHaloOverlap": NSNumber(value: inputHaloOverlap),
            "inputStriationStrength": NSNumber(value: inputStriationStrength),
            "inputStriationContrast": NSNumber(value: inputStriationContrast),
            kCIInputTimeKey: NSNumber(value: inputTime)
        ]
        
        let haloFilter = CIFilter(name: "CILenticularHaloGenerator", withInputParameters: inputParams)
        
        return haloFilter?.outputImage
        
    
    }
    
    //MARK: *********** CHECKERBOARD
    
    func  generateCheckerboardCGImage(cgRect: CGRect, inputCenter: CIVector, color1: CIColor, color2: CIColor, inputWidth: Double = 80.00, inputSharpness: Double = 1.00) -> CGImage?{
        
        guard let ciImage = generateCheckerboardCIImage(inputCenter: inputCenter, color1: color1, color2: color2, inputWidth: inputWidth, inputSharpness: inputSharpness) else { return nil }
        
        return coreImageContext.createCGImage(ciImage, from: cgRect)
    }
    
    
    func generateCheckerboardCIImage(inputCenter: CIVector, color1: CIColor, color2: CIColor, inputWidth: Double = 80.00, inputSharpness: Double = 1.00) -> CIImage?{
        
        let inputParams = [
            kCIInputCenterKey: inputCenter,
            "inputColor0": color1,
            "inputColor1": color2,
            kCIInputWidthKey: NSNumber(value: inputWidth),
            kCIInputSharpnessKey: NSNumber(value: inputSharpness)
        
        ]
        
        
        let checkerBoardFilter = CIFilter(name: "CICheckerboardGenerator", withInputParameters: nil)
        
        
        return checkerBoardFilter?.outputImage
    }
    
    
}
