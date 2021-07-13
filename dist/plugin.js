var capacitorAudiotoggleBluetooth = (function (exports, core) {
    'use strict';

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

    Object.defineProperty(exports, '__esModule', { value: true });

    return exports;

}({}, capacitorExports));
//# sourceMappingURL=plugin.js.map
