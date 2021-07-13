import { registerPlugin } from '@capacitor/core';
const AudiotoggleBluetooth = registerPlugin('AudiotoggleBluetooth', {
    web: () => import('./web').then(m => new m.AudiotoggleBluetoothWeb()),
});
export * from './definitions';
export { AudiotoggleBluetooth };
//# sourceMappingURL=index.js.map