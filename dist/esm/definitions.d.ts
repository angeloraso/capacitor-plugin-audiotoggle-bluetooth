export declare type AudioMode = 'EARPIECE' | 'SPEAKER' | 'NORMAL' | 'RINGTONE';
export interface AudiotoggleBluetoothPlugin {
    setAudioMode(data: {
        mode: AudioMode;
    }): Promise<void>;
    isHeadsetConnected(): Promise<{
        status: boolean;
    }>;
}
