package com.anura.plugins.audiotogglebluetooth;

import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothHeadset;
import android.bluetooth.BluetoothManager;
import android.content.Context;
import android.media.AudioManager;

import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;

@CapacitorPlugin(name = "AudiotoggleBluetooth")
public class AudiotoggleBluetoothPlugin extends Plugin {
	private BluetoothAdapter bluetoothAdapter;

    @PluginMethod
    public void setAudioMode(PluginCall call) {
        Context context = getContext();
	    AudioManager audioManager = (AudioManager) context.getSystemService(Context.AUDIO_SERVICE);

		if (call.hasOption("mode")) {
			String audioMode = call.getString("mode");
			if (audioMode.equals("EARPIECE")) {
				audioManager.setMode(AudioManager.MODE_IN_COMMUNICATION);
				audioManager.setSpeakerphoneOn(false);
				audioManager.setBluetoothScoOn(false);
        audioManager.stopBluetoothSco();
        call.resolve();
			} else if (audioMode.equals("SPEAKER")) {
				audioManager.setMode(AudioManager.MODE_NORMAL);
				audioManager.setSpeakerphoneOn(true);
				audioManager.setBluetoothScoOn(false);
        audioManager.stopBluetoothSco();
        call.resolve();
			} else if (audioMode.equals("RINGTONE")) {
				audioManager.setMode(AudioManager.MODE_RINGTONE);
				audioManager.setSpeakerphoneOn(false);
				call.resolve();
			} else if (audioMode.equals("BLUETOOTH")) {
				audioManager.setMode(AudioManager.MODE_NORMAL);
				audioManager.setSpeakerphoneOn(false);
				audioManager.setBluetoothScoOn(true);
				audioManager.startBluetoothSco();
				call.resolve();
			} else if (audioMode.equals("NORMAL")) {
				audioManager.setMode(AudioManager.MODE_NORMAL);
				audioManager.setSpeakerphoneOn(false);
        audioManager.setBluetoothScoOn(false);
        audioManager.stopBluetoothSco();
				call.resolve();
			} else {
				call.errorCallback("Invalid audio mode: " + audioMode);
			}
		} else {
			call.errorCallback("Audio mode is required");
		}
    }

	@PluginMethod
	public void isHeadsetConnected(PluginCall call) {
    	if (bluetoothAdapter == null) {
			BluetoothManager bluetoothManager = (BluetoothManager) getActivity().getSystemService(Context.BLUETOOTH_SERVICE);
			bluetoothAdapter = bluetoothManager.getAdapter();
		}

		boolean result = bluetoothAdapter != null && bluetoothAdapter.isEnabled()
				&& bluetoothAdapter.getProfileConnectionState(BluetoothHeadset.HEADSET) == BluetoothHeadset.STATE_CONNECTED;

		JSObject output = new JSObject();
		output.put("connected", result);
		call.resolve(output);
	}
}
