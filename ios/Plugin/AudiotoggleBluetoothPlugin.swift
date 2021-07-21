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
    let session: AVAudioSession = AVAudioSession.sharedInstance();

    @objc public func setAudioMode(_ call: CAPPluginCall) {
        let audioMode = call.getString("mode") ?? "";
            
        print("AUDIO MODE: \(audioMode) - SESSION:  \(session)");
        if (audioMode == "EARPIECE") {
            do {
                try session.setCategory(.playAndRecord, mode: .voiceChat, options:[.interruptSpokenAudioAndMixWithOthers]);
                try session.overrideOutputAudioPort(.none);
                try session.setActive(true);
            } catch let error as NSError {
                call.reject("ERROR \(audioMode):  \(error.localizedDescription)")
            }
        } else if (audioMode == "SPEAKER") {
            do {
                try session.setCategory(.playAndRecord, mode: .voiceChat, options:[.interruptSpokenAudioAndMixWithOthers, .defaultToSpeaker]);
                try session.overrideOutputAudioPort(.speaker);
                try session.setActive(true);
            } catch let error as NSError {
                call.reject("ERROR \(audioMode):  \(error.localizedDescription)")
            }
        } else if (audioMode == "RINGTONE") {
            do {
                try session.setCategory(.playAndRecord, mode: .default, options:[.interruptSpokenAudioAndMixWithOthers, .defaultToSpeaker]);
                try session.overrideOutputAudioPort(.speaker);
                try session.setActive(true);
            } catch let error as NSError {
                call.reject("ERROR \(audioMode):  \(error.localizedDescription)")
            }
        } else if (audioMode == "BLUETOOTH") {
            do {
                try session.setCategory(.playAndRecord, mode: .voiceChat, options:[.interruptSpokenAudioAndMixWithOthers, .allowBluetooth]);
                try session.overrideOutputAudioPort(.speaker);
                try session.setActive(true);
            } catch let error as NSError {
                call.reject("ERROR \(audioMode):  \(error.localizedDescription)")
            }
        } else if (audioMode == "NORMAL") {
            do {
                try session.setCategory(.soloAmbient, mode: .default, options: []);
                try session.setActive(true);
            } catch let error as NSError {
                call.reject("ERROR \(audioMode):  \(error.localizedDescription)")
            }
        } else {
            call.reject("Invalid audio mode: " + audioMode)
        }
                
        call.resolve();
    }
    
    @objc public func isHeadsetConnected(_ call: CAPPluginCall) {
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
