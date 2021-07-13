import { registerPlugin } from '@capacitor/core';

import type { AudiotoggleBluetoothPlugin } from './definitions';

const AudiotoggleBluetooth = registerPlugin<AudiotoggleBluetoothPlugin>(
  'AudiotoggleBluetooth',
  {
    web: () => import('./web').then(m => new m.AudiotoggleBluetoothWeb()),
  },
);

export * from './definitions';
export { AudiotoggleBluetooth };
