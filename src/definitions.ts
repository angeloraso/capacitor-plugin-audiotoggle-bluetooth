export interface AudiotoggleBluetoothPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
