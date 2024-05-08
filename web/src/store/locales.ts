import { writable } from 'svelte/store';
import type Locales from '$types/locales';

export default writable<Locales>({
  groups: 'Groups',
  players: 'Players',
  copy_server_id: 'Copy your server ID',
  server_id_copied: 'Server ID copied',
  anonymous_player: 'Anonymous player',
});
