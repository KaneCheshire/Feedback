//
//  Feedback.swift
//  Created by Kane Cheshire on 16/12/2016.
//
import UIKit
import AVFoundation

/// Generates haptics and sounds as feedback on supported devices.
/// On devices that don't support haptics, the generator silently fails,
/// so you don't need to check for compatibility or OS version.
public struct Feedback {
    
    /// The type of haptic you want to generate.
    ///
    /// - impact: Configured with an ImpactType, this haptic generates a light, medium or heavy impact feeling to the user.
    /// - selection: Generates a gentle tap to the user indicating a selection has changed.
    /// - notification: Configured with a NotificationType, this haptic generates a warning, error or success feeling to the user.
    public enum HapticType {
        
        case selection
        case impact(ImpactType)
        case notification(NotificationType)
        
    }
    
    /// The type of impact haptic to generate.
    ///
    /// - light: A light impact is slightly stronger than HapticType.selection.
    /// - medium: A medium impact is slightly stronger than ImpactType.light but weaker than ImpactType.heavy.
    /// - heavy: A heavy impact is stronger than ImpactType.medium.
    public enum ImpactType: Int {
        
        case light
        case medium
        case heavy
        
        var soundName: String {
            switch self {
            case .light: return "light"
            case .medium: return "medium"
            case .heavy: return "heavy"
            }
        }
        
    }
    
    /// The type of notification haptic to generate.
    ///
    /// - error: Indicates an error has occurred to the user.
    /// - success: Indicates an action completed successfully to the user.
    /// - warning: Indicates to the user that a warning has occurred, or that something is about to happen.
    public enum NotificationType: Int {
        
        case error
        case success
        case warning
        
        var soundName: String {
            switch self {
            case .error: return "error"
            case .success: return "success"
            case .warning: return "warning"
            }
        }
        
    }
    
    /// The type of sound you want to generate.
    ///
    /// - selection: Generates a sound indicating a selection has changed.
    /// - impact: Generates a sound representing the level of impact configured.
    /// - notification: Generates a sound representing the type of notification configured.
    /// - custom: Generates a custom sound in your own target.
    public enum SoundType {
        
        case selection
        case impact(ImpactType)
        case notification(NotificationType)
        case custom(soundName: String, extension: String)
        
        var soundName: String {
            switch self {
            case .selection: return "selection"
            case .impact(let type): return type.soundName
            case .notification(let type): return type.soundName
            case .custom(soundName: let soundName, _): return soundName
            }
        }
        
        var `extension`: String {
            switch self {
            case .selection, .impact, .notification: return "m4a"
            case .custom(_, extension: let extensionType): return extensionType
            }
        }
        
        var bundle: Bundle {
            switch self {
            case .selection, .impact, .notification: return Bundle.assets ?? .main
            case .custom: return .main
            }
        }
        
    }
    
    internal let hapticType: HapticType?
    private(set) var player: AVAudioPlayer?
    private(set) var generator: Any?
    
    /// Creates a new generator configured with a haptic type.
    ///
    /// - Parameter hapticType: The haptic type this generator is configured with.
    public init(hapticType: HapticType? = nil, soundType: SoundType? = nil) {
        assert(hapticType != nil || soundType != nil, "You need to provide at least a haptic or sound type!")
        
        self.hapticType = hapticType
        if let hapticType = hapticType {
            if #available(iOS 10.0, *) {
                switch hapticType {
                case .selection: self.generator = UISelectionFeedbackGenerator()
                case .impact(let type): self.generator = UIImpactFeedbackGenerator(style: UIImpactFeedbackStyle(rawValue: type.rawValue) ?? .medium)
                case .notification: self.generator = UINotificationFeedbackGenerator()
                }
            }
        }

        
        if let soundType = soundType {
            try? AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
            guard let url = soundType.bundle.url(forResource: soundType.soundName, withExtension: soundType.extension) else { return }
            self.player = try? AVAudioPlayer(contentsOf: url)
            self.player?.prepareToPlay()
        }
    }
    
    /// Generates a haptic.
    /// The type of haptic generates will be determined by the configuration at creation time.
    ///
    /// It is safe to call this function on any version of iOS without checking availability.
    public func generateFeedback() {
        player?.play()
        if #available(iOS 10.0, *) {
            guard let hapticType = hapticType else { return }
            switch hapticType {
            case .selection: (generator as? UISelectionFeedbackGenerator)?.selectionChanged()
            case .impact: (generator as? UIImpactFeedbackGenerator)?.impactOccurred()
            case .notification(let type): (generator as? UINotificationFeedbackGenerator)?.notificationOccurred(UINotificationFeedbackType(rawValue: type.rawValue)!)
            }
        }
    }
    
    /// Prepares the taptic engine for use by powering it up momentarily.
    /// Call immediately after generating a haptic to keep the taptic engine powered up for
    /// a few seconds to reduce latency. Useful when scrolling through a list or timeline.
    ///
    /// It is safe to call this function on any version of iOS without checking availability.
    public func prepareForUse() {
        player?.prepareToPlay()
        if #available(iOS 10.0, *) {
            (generator as? UIFeedbackGenerator)?.prepare()
        }
    }
    
}

private extension Bundle {
    
    static let assets: Bundle? = {
        let bundle = Bundle(identifier: "org.cocoapods.Feedback")
        guard let url = bundle?.url(forResource: "FeedbackAssets", withExtension: "bundle") else { return nil }
        return Bundle(url: url)
    }()
    
}
