//
//  ImageProcessor.swift
//  ColorUp
//
//  Created by admin on 2026/2/7.
//

import UIKit
import CoreImage
import CoreImage.CIFilterBuiltins

class ImageProcessor {
    private let context = CIContext()
    
    func applyAdjustments(to image: UIImage, adjustments: ColorAdjustment) -> UIImage? {
        guard let ciImage = CIImage(image: image) else { return nil }
        
        var processedImage = ciImage
        
        // 1. 应用色相调整
        if adjustments.hue != 0.0 {
            let hueFilter = CIFilter.hueAdjust()
            hueFilter.inputImage = processedImage
            hueFilter.angle = Float(adjustments.hue * .pi) // 转换为弧度
            if let output = hueFilter.outputImage {
                processedImage = output
            }
        }
        
        // 2. 应用饱和度和亮度调整
        let colorControls = CIFilter.colorControls()
        colorControls.inputImage = processedImage
        colorControls.saturation = Float(adjustments.saturation)
        colorControls.brightness = Float((adjustments.brightness - 1.0) * 0.5) // 调整范围
        colorControls.contrast = Float(adjustments.contrast)
        if let output = colorControls.outputImage {
            processedImage = output
        }
        
        // 3. 应用曝光调整
        if adjustments.exposure != 1.0 {
            let exposureFilter = CIFilter.exposureAdjust()
            exposureFilter.inputImage = processedImage
            exposureFilter.ev = Float((adjustments.exposure - 1.0) * 2.0)
            if let output = exposureFilter.outputImage {
                processedImage = output
            }
        }
        
        // 4. 应用伽马矫正
        if abs(adjustments.gamma - 2.2) > 0.01 {
            let gammaFilter = CIFilter.gammaAdjust()
            gammaFilter.inputImage = processedImage
            gammaFilter.power = Float(adjustments.gamma / 2.2)
            if let output = gammaFilter.outputImage {
                processedImage = output
            }
        }
        
        // 5. 应用色调映射 (简化的ACES模拟)
        if adjustments.acesEnabled {
            let toneCurve = CIFilter.toneCurve()
            toneCurve.inputImage = processedImage
            toneCurve.point0 = CGPoint(x: 0.0, y: 0.0)
            toneCurve.point1 = CGPoint(x: 0.25, y: 0.20)
            toneCurve.point2 = CGPoint(x: 0.50, y: 0.50)
            toneCurve.point3 = CGPoint(x: 0.75, y: 0.80)
            toneCurve.point4 = CGPoint(x: 1.0, y: 1.0)
            if let output = toneCurve.outputImage {
                processedImage = output
            }
        }
        
        // 渲染最终图像
        guard let cgImage = context.createCGImage(processedImage, from: processedImage.extent) else {
            return nil
        }
        
        return UIImage(cgImage: cgImage)
    }
    
    func applyPreset(_ preset: StylePreset, to image: UIImage) -> UIImage? {
        return applyAdjustments(to: image, adjustments: preset.adjustment)
    }
}
