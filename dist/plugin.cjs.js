'use strict';

Object.defineProperty(exports, '__esModule', { value: true });

var core = require('@capacitor/core');

const AudiotoggleBluetooth = core.registerPlugin('AudiotoggleBluetooth', {
    web: () => Promise.resolve().then(function () { return web; }).then(m => new m.AudiotoggleBluetoothWeb()),
});

class AudiotoggleBluetoothWeb extends core.WebPlugin {
    async setAudioMode(data) {
        console.log('MODE: ', data.mode);
        return;
    }
    async isHeadsetConnected() {
        return { connected: false };
    }
}

var web = /*#__PURE__*/Object.freeze({
    __proto__: null,
    AudiotoggleBluetoothWeb: AudiotoggleBluetoothWeb
});

exports.AudiotoggleBluetooth = AudiotoggleBluetooth;
//# sourceMappingURL=plugin.cjs.js.map
