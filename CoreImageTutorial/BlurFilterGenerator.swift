//
//  BlurFilterGenerator.swift
//  CoreImageTutorial
//
//  Created by Aleksander Makedonski on 4/3/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import CoreImage


class BlurFilterGenerator{
    
    static func generateBoxBlurCIImage(inputImage: CIImage, inputRadius: Double) -> CIImage?{
        
        let inputParams = [
            kCIInputImageKey: inputImage,
            kCIInputRadiusKey: NSNumber(value: inputRadius)
        ]
        
        
        let boxBlurFilter = CIFilter(name: "CIBoxBlur", withInputParameters: inputParams)
        
        return boxBlurFilter?.outputImage
        
    }
    
    static func generateDiscBlurCIImage(inputImage: CIImage, inputRadius: Double) -> CIImage?{
        
        let inputParams = [
            kCIInputImageKey: inputImage,
            kCIInputRadiusKey: NSNumber(value: inputRadius)
        ]
        
        let discBlurFilter = CIFilter(name: "CIDiscBlur", withInputParameters: inputParams)
        
        return discBlurFilter?.outputImage
        
    }
    
    
    static func generateGaussianBlurCIImage(inputImage: CIImage, inputRadius: Double) -> CIImage?{
        
        let inputParams = [
            kCIInputImageKey: inputImage,
            kCIInputRadiusKey: NSNumber(value: inputRadius)
        ]
        
        let gaussianBlurFilter = CIFilter(name: "CIGaussianBlur", withInputParameters: inputParams)
        
        return gaussianBlurFilter?.outputImage
    }
    
    
    static func generateZoomBlurCIImage(inputImage: CIImage, inputCenter: CIVector, inputAmount: Double) -> CIImage?{
        
        let inputParams = [
            kCIInputImageKey: inputImage,
            kCIInputCenterKey: inputCenter,
            "inputAmount" : NSNumber(value: inputAmount)
        ]
        
        let zoomBlurFilter = CIFilter(name: "CIZoomBlur", withInputParameters: inputParams)
        
        return zoomBlurFilter?.outputImage
    }
    
    
    static func generateMotionBlurCIImage(inputImage: CIImage, inputRadius: Double, inputAngle: Double) -> CIImage?{
        
        let inputParams = [
            kCIInputImageKey: inputImage,
            kCIInputRadiusKey: NSNumber(value: inputRadius),
            kCIInputAngleKey: NSNumber(value: inputAngle)
        ]
        
        let motionBlurFilter = CIFilter(name: "CIMotionBlur", withInputParameters: inputParams)
        
        return motionBlurFilter?.outputImage
        
    }
    
    static func generateMaskedVariableBlurCIImage(inputImage: CIImage, inputMask: CIImage, inputRadius: Double) -> CIImage?{
        
        let inputParams = [
            kCIInputImageKey: inputImage,
            kCIInputMaskImageKey: inputMask,
            kCIInputRadiusKey: NSNumber(value: inputRadius)
        ]
        
        let maskedVariableBlurFilter = CIFilter(name: "CIMaskedVariableBlur", withInputParameters: inputParams)
        
        return maskedVariableBlurFilter?.outputImage
    }
}
