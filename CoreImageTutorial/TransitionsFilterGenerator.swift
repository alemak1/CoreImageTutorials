//
//  TransitionsFilterGenerator.swift
//  CoreImageTutorial
//
//  Created by Aleksander Makedonski on 4/3/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import CoreImage


class TransitionFilterGenerator{
    
    
    static func generateAccordionFoldTransition(inputImage: CIImage, inputTargetImage: CIImage, inputBottomHeight: Double = 0.00, inputNumberOfFolds: Double = 3.00, inputFoldShadowAmount: Double = 0.10, inputTime: Double = 2.00) -> CIImage?{
        
        
        let inputParams = [
            kCIInputImageKey: inputImage,
            kCIInputTargetImageKey: inputTargetImage,
            "inputBottomHeight": NSNumber(value: inputBottomHeight),
            "inputNumberOfFolds": NSNumber(value: inputNumberOfFolds),
            "inputFoldShadowAmount": NSNumber(value: inputFoldShadowAmount),
            kCIInputTimeKey: NSNumber(value: inputTime)
            
        ]
        
        let accordionTransitionFilter = CIFilter(name: "CIAccordionFoldTransition", withInputParameters: inputParams)
        
        return accordionTransitionFilter?.outputImage
        
    }
    
    static func generateBarSwipeTransition(inputImage: CIImage, inputTargetImage: CIImage, inputAngle: Double = 3.14, inputWidth: Double = 30.0, inputBarOffset: Double = 10.00, inputTime: Double = 0.00) -> CIImage?{
        
        
        let inputParams = [
            kCIInputImageKey: inputImage,
            kCIInputTargetImageKey: inputTargetImage,
            kCIInputAngleKey: NSNumber(value: inputAngle),
            kCIInputTimeKey: NSNumber(value: inputTime),
            kCIInputWidthKey: NSNumber(value: inputWidth)
        ]
        
        let barSwipeFilter = CIFilter(name: "CIBarsSwipeTransition", withInputParameters: inputParams)
    
        
        return barSwipeFilter?.outputImage
    }
    
    static func generateCopyMachineTransition(inputImage: CIImage, inputTargetImage: CIImage, inputExtent: CIVector, inputColor: CIColor, inputAngle: Double = 3.14, inputWidth: Double = 30.0, inputBarOffset: Double = 10.00, inputOpacity: Double = 1.30, inputTime: Double = 0.00) -> CIImage?{
        
        
        let inputParams = [
            kCIInputImageKey: inputImage,
            kCIInputTargetImageKey: inputTargetImage,
            kCIInputExtentKey: inputExtent,
            kCIInputColorKey: inputColor,
            kCIInputAngleKey: NSNumber(value: inputAngle),
            kCIInputWidthKey: NSNumber(value: inputWidth),
            kCIInputTimeKey: NSNumber(value: inputTime),
            "inputOpacity": NSNumber(value: inputOpacity)
        ]
        
        let copyMachineTransitionFilter = CIFilter(name: "CICopyMachineTransition", withInputParameters: inputParams)
        
        
        return copyMachineTransitionFilter?.outputImage
    }
    
    
    
    static func generateSwipeTransition(inputImage: CIImage, inputTargetImage: CIImage, inputExtent: CIVector, inputColor: CIColor, inputAngle: Double = 0.00, inputWidth: Double = 300.0, inputBarOffset: Double = 10.00, inputOpacity: Double = 1.30, inputTime: Double = 0.00) -> CIImage?{
        
        
        let inputParams = [
            kCIInputImageKey: inputImage,
            kCIInputTargetImageKey: inputTargetImage,
            kCIInputExtentKey: inputExtent,
            kCIInputColorKey: inputColor,
            kCIInputAngleKey: NSNumber(value: inputAngle),
            kCIInputWidthKey: NSNumber(value: inputWidth),
            kCIInputTimeKey: NSNumber(value: inputTime),
            "inputOpacity": NSNumber(value: inputOpacity)
        ]
        
        let swipeTransitionFiter = CIFilter(name: "CICopyMachineTransition", withInputParameters: inputParams)
        
        
        return swipeTransitionFiter?.outputImage
    }
    
    static func generateRippleTransition(inputImage: CIImage, inputTargetImage: CIImage, inputShadingImage: CIImage, inputCenter: CIVector, inputExtent: CIVector, inputWidth: Double = 300.0, inputScale: Double = 0.00, inputTime: Double = 0.00) -> CIImage?{
        
        
        let inputParams = [
            kCIInputImageKey: inputImage,
            kCIInputTargetImageKey: inputTargetImage,
            kCIInputShadingImageKey: inputShadingImage,
            kCIInputCenterKey: inputCenter,
            kCIInputExtentKey: inputExtent,
            kCIInputScaleKey: NSNumber(value: inputScale),
            kCIInputWidthKey: NSNumber(value: inputWidth),
            kCIInputTimeKey: NSNumber(value: inputTime),
        ]
        
        let rippleTransitionFilter = CIFilter(name: "CIRippleTransition", withInputParameters: inputParams)
        
        
        return rippleTransitionFilter?.outputImage
    }
    
    
    static func generateModTransition(inputImage: CIImage, inputTargetImage: CIImage, inputCenter: CIVector, inputColor: CIColor, inputAngle: Double = 2.00, inputRadius: Double = 150.00, inputCompression: Double = 300.00, inputTime: Double = 0.00) -> CIImage?{
        
        
        let inputParams = [
            kCIInputImageKey: inputImage,
            kCIInputTargetImageKey: inputTargetImage,
            kCIInputCenterKey: inputCenter,
            kCIInputRadiusKey: NSNumber(value: inputRadius),
            kCIInputAngleKey: NSNumber(value: inputAngle),
            kCIInputTimeKey: NSNumber(value: inputTime),
            "inputCompression": NSNumber(value: inputCompression)
        ]
        
        let modTransitionFilter = CIFilter(name: "CIModTransition", withInputParameters: inputParams)
        
        
        return modTransitionFilter?.outputImage
    }
    
    static func generateDissolveTransition(inputImage: CIImage, inputTargetImage: CIImage, inputTime: Double = 0.00) -> CIImage?{
        
        
        let inputParams = [
            kCIInputImageKey: inputImage,
            kCIInputTargetImageKey: inputTargetImage,
            kCIInputTimeKey: NSNumber(value: inputTime),
        ]
        
        let modTransitionFilter = CIFilter(name: "CIModTransition", withInputParameters: inputParams)
        
        
        return modTransitionFilter?.outputImage
    }
    
    
    static func generateFlashTransition(inputImage: CIImage, inputTargetImage: CIImage, inputCenter: CIVector, inputExtent: CIVector, inputColor: CIColor, inputTime: Double = 0.00, inputFadeThreshold: Double = 0.85, inputStriationContrast: Double = 1.38, inputStriationStrength: Double = 0.50, inputMaxStriationRadius: Double = 2.58) -> CIImage?{
        
        
        let inputParams = [
            kCIInputImageKey: inputImage,
            kCIInputTargetImageKey: inputTargetImage,
            kCIInputCenterKey: inputCenter,
            kCIInputExtentKey: inputExtent,
            kCIInputTimeKey: NSNumber(value: inputTime),
            "inputMaxStriationRadius": NSNumber(value: inputMaxStriationRadius),
            "inputStriationContrast": NSNumber(value: inputStriationContrast),
            "inputStriationStrength": NSNumber(value: inputStriationStrength),
            "inputFadeThreshold": NSNumber(value: inputFadeThreshold)
        ]
        
        let flashTransitionFilter = CIFilter(name: "CIFlashTransition", withInputParameters: inputParams)
        
        
        return flashTransitionFilter?.outputImage
    }
    
    static func generatePageCurlTransition(inputImage: CIImage, inputTargetImage: CIImage, inputBacksideImage: CIImage, inputShadingImage: CIImage,inputExtent: CIVector, inputAngle: Double = 0.00, inputRadius: Double = 100.0, inputTime: Double = 0.00) -> CIImage?{
        
        let inputParams = [
            kCIInputImageKey: inputImage,
            kCIInputTargetImageKey: inputTargetImage,
            "inputBacksideImage": inputBacksideImage,
            kCIInputShadingImageKey: inputShadingImage,
            kCIInputExtentKey: inputExtent,
            kCIInputTimeKey: NSNumber(value: inputTime),
            kCIInputAngleKey: NSNumber(value: inputAngle),
            kCIInputRadiusKey: NSNumber(value: inputRadius)
        ]
        
        let pageCurlTransitionFilter = CIFilter(name: "CIPageCurlTransition", withInputParameters: inputParams)
        
        return pageCurlTransitionFilter?.outputImage
    }
    
    //TODO: Implement PageCurl Transition with Shadow
    //TOOD: Implement Disintegrate with Mask Transition
}
