import { WebPlugin } from '@capacitor/core';
import type { AudioMode, AudiotoggleBluetoothPlugin } from './definitions';



export class AudiotoggleBluetoothWeb
  extends WebPlugin
  implements AudiotoggleBluetoothPlugin {

  async setAudioMode(data: {mode: AudioMode}): Promise<void> {
    console.log('MODE: ', data.mode);
    return;
  }

  async isHeadsetConnected(): Promise<{ connected: boolean }> {
    return {connected: false};
  }
}
