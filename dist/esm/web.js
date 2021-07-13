import { WebPlugin } from '@capacitor/core';
export class AudiotoggleBluetoothWeb extends WebPlugin {
    async setAudioMode(data) {
        console.log('MODE: ', data.mode);
        return;
    }
    async isHeadsetConnected() {
        return { status: false };
    }
}
//# sourceMappingURL=web.js.map