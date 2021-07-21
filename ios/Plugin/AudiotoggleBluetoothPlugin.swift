import Foundation
import Capacitor
import Foundation
import AVFoundation

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(AudiotoggleBluetoothPlugin)
public class AudiotoggleBluetoothPlugin: CAPPlugin {

    @objc public func setAudioMode(_ call: CAPPluginCall) {
        if #available(iOS 14.5, *) {
            let session: AVAudioSession = AVAudioSession.sharedInstance();
            let audioMode = call.getString("mode") ?? "";
            if (audioMode == "EARPIECE") {
                do {
                    print("AUDIO MODE: \(audioMode)");
                    try session.setCategory(.playAndRecord, mode: .voiceChat, options:[.interruptSpokenAudioAndMixWithOthers])
                    try session.setActive(true);
                    try session.overrideOutputAudioPort(.none);
                } catch let error as NSError {
                    call.reject("ERROR \(audioMode):  \(error.localizedDescription)")
                }
            } else if (audioMode == "SPEAKER") {
                do {
                    print("AUDIO MODE: \(audioMode)");
                    try session.setCategory(.playAndRecord, mode: .voiceChat, options:[.interruptSpokenAudioAndMixWithOthers, .defaultToSpeaker]);
                    try session.setActive(true);
                    try session.overrideOutputAudioPort(.speaker);
                } catch let error as NSError {
                    call.reject("ERROR \(audioMode):  \(error.localizedDescription)");
                }
            } else if (audioMode == "RINGTONE") {
                do {
                    print("AUDIO MODE: \(audioMode)");
                    try session.setCategory(.playAndRecord, mode: .default, options:[.interruptSpokenAudioAndMixWithOthers, .defaultToSpeaker]);
                    try session.setActive(true);
                    try session.overrideOutputAudioPort(.speaker);
                } catch let error as NSError {
                    call.reject("ERROR \(audioMode):  \(error.localizedDescription)");
                }
            } else if (audioMode == "BLUETOOTH") {
                do {
                    print("AUDIO MODE: \(audioMode)");
                    try session.setCategory(.playAndRecord, mode: .voiceChat, options:[.interruptSpokenAudioAndMixWithOthers, .allowBluetooth]);
                    try session.setActive(true);
                    try session.overrideOutputAudioPort(.speaker);
                } catch let error as NSError {
                    call.reject("ERROR \(audioMode):  \(error.localizedDescription)");
                }
            } else if (audioMode == "NORMAL") {
                do {
                    print("AUDIO MODE: \(audioMode)");
                    try session.setCategory(.soloAmbient, mode: .default, options: []);
                    try session.setActive(false);
                } catch let error as NSError {
                    call.reject("ERROR \(audioMode):  \(error.localizedDescription)");
                }
            } else {
                print("AUDIO MODE: \(audioMode)");
                call.reject("Invalid audio mode: " + audioMode);
            }
                    
            call.resolve();
        } else {
            call.reject("IOS 14.5 version required");
        };
        
    }
    
    @objc public func isHeadsetConnected(_ call: CAPPluginCall) {
        let session: AVAudioSession = AVAudioSession.sharedInstance();
        call.resolve(["connected": session.isHeadphonesConnected]);
    }
}

extension AVAudioSession {

    static var isHeadphonesConnected: Bool {
        return sharedInstance().isHeadphonesConnected
    }

    var isHeadphonesConnected: Bool {
        return !currentRoute.outputs.filter { $0.isHeadphones }.isEmpty
    }

}

extension AVAudioSessionPortDescription {
    var isHeadphones: Bool {
        return portType == AVAudioSession.Port.headphones
    }
}
