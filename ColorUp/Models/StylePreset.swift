//
//  StylePreset.swift
//  ColorUp
//
//  Created by admin on 2026/2/7.
//

import Foundation

struct StylePreset: Identifiable {
    let id = UUID()
    let name: String
    let nameEN: String
    let adjustment: ColorAdjustment
    let category: String
    
    static let presets: [StylePreset] = [
        // 一、复古科技风格
        StylePreset(
            name: "早期黑白电视",
            nameEN: "1920s B&W TV",
            adjustment: ColorAdjustment(
                hue: 0.0,
                saturation: 0.0,
                brightness: 0.8,
                contrast: 0.7,
                lutIntensity: 0.5,
                exposure: 0.6,
                gamma: 1.8,
                useACES: 0.0
            ),
            category: "复古科技"
        ),
        StylePreset(
            name: "早期彩色电视",
            nameEN: "1950s Color TV",
            adjustment: ColorAdjustment(
                hue: 0.02,
                saturation: 0.6,
                brightness: 0.7,
                contrast: 0.5,
                lutIntensity: 0.3,
                exposure: 0.8,
                gamma: 2.0,
                useACES: 0.0
            ),
            category: "复古科技"
        ),
        StylePreset(
            name: "NTSC制式",
            nameEN: "NTSC Signal",
            adjustment: ColorAdjustment(
                hue: -0.03,
                saturation: 0.7,
                brightness: 0.9,
                contrast: 0.9,
                lutIntensity: 0.4,
                exposure: 0.85,
                gamma: 2.1,
                useACES: 0.0
            ),
            category: "复古科技"
        ),
        
        // 二、艺术创作风格
        StylePreset(
            name: "水墨画",
            nameEN: "Ink Painting",
            adjustment: ColorAdjustment(
                hue: 0.0,
                saturation: 0.2,
                brightness: 0.9,
                contrast: 1.5,
                lutIntensity: 0.6,
                exposure: 1.2,
                gamma: 1.6,
                useACES: 0.0
            ),
            category: "艺术创作"
        ),
        StylePreset(
            name: "铅笔画",
            nameEN: "Pencil Sketch",
            adjustment: ColorAdjustment(
                hue: 0.0,
                saturation: 0.1,
                brightness: 1.1,
                contrast: 1.8,
                lutIntensity: 0.3,
                exposure: 1.0,
                gamma: 1.4,
                useACES: 0.0
            ),
            category: "艺术创作"
        ),
        StylePreset(
            name: "版画木刻",
            nameEN: "Woodcut Print",
            adjustment: ColorAdjustment(
                hue: 0.05,
                saturation: 0.4,
                brightness: 1.0,
                contrast: 2.0,
                lutIntensity: 0.5,
                exposure: 0.9,
                gamma: 1.2,
                useACES: 0.0
            ),
            category: "艺术创作"
        ),
        
        // 三、胶片模拟
        StylePreset(
            name: "复古胶片70s",
            nameEN: "1970s Film",
            adjustment: ColorAdjustment(
                hue: 0.08,
                saturation: 0.5,
                brightness: 0.8,
                contrast: 1.3,
                lutIntensity: 0.7,
                exposure: 0.7,
                gamma: 2.4,
                useACES: 1.0
            ),
            category: "胶片模拟"
        ),
        StylePreset(
            name: "柯达胶卷",
            nameEN: "Kodak Film",
            adjustment: ColorAdjustment(
                hue: 0.04,
                saturation: 0.6,
                brightness: 0.9,
                contrast: 1.2,
                lutIntensity: 0.5,
                exposure: 1.0,
                gamma: 2.3,
                useACES: 0.0
            ),
            category: "胶片模拟"
        ),
        StylePreset(
            name: "富士胶卷",
            nameEN: "Fuji Film",
            adjustment: ColorAdjustment(
                hue: -0.02,
                saturation: 0.55,
                brightness: 0.95,
                contrast: 1.4,
                lutIntensity: 0.6,
                exposure: 1.1,
                gamma: 2.2,
                useACES: 0.0
            ),
            category: "胶片模拟"
        ),
        
        // 四、特殊效果
        StylePreset(
            name: "红外线摄影",
            nameEN: "Infrared Photo",
            adjustment: ColorAdjustment(
                hue: 0.6,
                saturation: 0.3,
                brightness: 1.2,
                contrast: 1.6,
                lutIntensity: 0.8,
                exposure: 1.3,
                gamma: 1.8,
                useACES: 0.0
            ),
            category: "特殊效果"
        ),
        StylePreset(
            name: "X光片",
            nameEN: "X-Ray",
            adjustment: ColorAdjustment(
                hue: 0.0,
                saturation: 0.0,
                brightness: 1.5,
                contrast: 0.3,
                lutIntensity: 0.2,
                exposure: 1.8,
                gamma: 1.0,
                useACES: 0.0
            ),
            category: "特殊效果"
        ),
        StylePreset(
            name: "夜视仪",
            nameEN: "Night Vision",
            adjustment: ColorAdjustment(
                hue: 0.7,
                saturation: 0.8,
                brightness: 1.3,
                contrast: 1.7,
                lutIntensity: 0.9,
                exposure: 1.5,
                gamma: 1.5,
                useACES: 0.0
            ),
            category: "特殊效果"
        ),
        
        // 五、现代风格
        StylePreset(
            name: "Instagram褪色",
            nameEN: "Instagram Fade",
            adjustment: ColorAdjustment(
                hue: 0.02,
                saturation: 0.4,
                brightness: 1.1,
                contrast: 0.8,
                lutIntensity: 0.6,
                exposure: 1.2,
                gamma: 2.0,
                useACES: 1.0
            ),
            category: "现代风格"
        ),
        StylePreset(
            name: "赛博朋克",
            nameEN: "Cyberpunk",
            adjustment: ColorAdjustment(
                hue: 0.6,
                saturation: 0.3,
                brightness: 0.7,
                contrast: 1.5,
                lutIntensity: 0.8,
                exposure: 0.6,
                gamma: 2.5,
                useACES: 0.0
            ),
            category: "现代风格"
        ),
        StylePreset(
            name: "高级灰",
            nameEN: "Premium Gray",
            adjustment: ColorAdjustment(
                hue: 0.0,
                saturation: 0.25,
                brightness: 1.0,
                contrast: 1.1,
                lutIntensity: 0.5,
                exposure: 1.0,
                gamma: 2.2,
                useACES: 1.0
            ),
            category: "现代风格"
        ),
        StylePreset(
            name: "莫兰迪色系",
            nameEN: "Morandi Colors",
            adjustment: ColorAdjustment(
                hue: 0.05,
                saturation: 0.3,
                brightness: 0.9,
                contrast: 0.9,
                lutIntensity: 0.4,
                exposure: 0.9,
                gamma: 2.0,
                useACES: 0.0
            ),
            category: "现代风格"
        ),
        
        // 六、游戏风格
        StylePreset(
            name: "生存恐怖",
            nameEN: "Survival Horror",
            adjustment: ColorAdjustment(
                hue: 0.1,
                saturation: 0.2,
                brightness: 0.6,
                contrast: 1.8,
                lutIntensity: 0.7,
                exposure: 0.5,
                gamma: 1.3,
                useACES: 0.0
            ),
            category: "游戏风格"
        ),
        StylePreset(
            name: "末日废土",
            nameEN: "Post-Apocalyptic",
            adjustment: ColorAdjustment(
                hue: 0.12,
                saturation: 0.35,
                brightness: 0.8,
                contrast: 1.4,
                lutIntensity: 0.6,
                exposure: 0.7,
                gamma: 1.7,
                useACES: 0.0
            ),
            category: "游戏风格"
        ),
        StylePreset(
            name: "历史模式",
            nameEN: "Historical Mode",
            adjustment: ColorAdjustment(
                hue: 0.08,
                saturation: 0.4,
                brightness: 0.9,
                contrast: 1.2,
                lutIntensity: 0.5,
                exposure: 0.9,
                gamma: 2.1,
                useACES: 0.0
            ),
            category: "游戏风格"
        ),
        
        // 七、工业设计
        StylePreset(
            name: "PANTONE品红",
            nameEN: "PANTONE Magenta",
            adjustment: ColorAdjustment(
                hue: 0.85,
                saturation: 0.7,
                brightness: 0.9,
                contrast: 1.3,
                lutIntensity: 0.7,
                exposure: 1.0,
                gamma: 2.2,
                useACES: 0.0
            ),
            category: "工业设计"
        )
    ]
    
    static var categories: [String] {
        let allCategories = presets.map { $0.category }
        return Array(Set(allCategories)).sorted()
    }
}
