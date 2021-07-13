import { WebPlugin } from '@capacitor/core';

import type { AudiotoggleBluetoothPlugin } from './definitions';

export class AudiotoggleBluetoothWeb
  extends WebPlugin
  implements AudiotoggleBluetoothPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
