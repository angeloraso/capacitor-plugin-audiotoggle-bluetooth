import { WebPlugin } from '@capacitor/core';
import type { AudioMode, AudiotoggleBluetoothPlugin } from './definitions';
export declare class AudiotoggleBluetoothWeb extends WebPlugin implements AudiotoggleBluetoothPlugin {
    setAudioMode(data: {
        mode: AudioMode;
    }): Promise<void>;
    isHeadsetConnected(): Promise<{
        connected: boolean;
    }>;
}
