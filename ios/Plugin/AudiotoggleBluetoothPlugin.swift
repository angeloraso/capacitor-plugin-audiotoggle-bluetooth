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
            
        if (audioMode == "EARPIECE") {
            do {
                try session.setCategory(AVAudioSession.Category.playAndRecord);
                try session.overrideOutputAudioPort(AVAudioSession.PortOverride.none);
            } catch {
                call.reject("ERROR: " + audioMode)
            }
        } else if (audioMode == "SPEAKER") {
            do {
                try session.setCategory(AVAudioSession.Category.playAndRecord);
                try session.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker);
            } catch {
                call.reject("ERROR: " + audioMode)
            }
        } else if (audioMode == "RINGTONE") {
            do {
                try session.setCategory(AVAudioSession.Category.playAndRecord);
                try session.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker);
            } catch {
                call.reject("ERROR: " + audioMode)
            }
        } else if (audioMode == "BLUETOOTH") {
            do {
                try session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options:[ AVAudioSession.CategoryOptions.allowBluetooth]);
                try session.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker);
            } catch {
                call.reject("ERROR: " + audioMode)
            }
        } else if (audioMode == "NORMAL") {
            do {
                try session.setCategory(AVAudioSession.Category.soloAmbient);
            } catch {
                call.reject("ERROR: " + audioMode)
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
