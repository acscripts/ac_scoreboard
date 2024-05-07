import { writable } from 'svelte/store';
import type SheetData from '$types/data';

export default writable<SheetData>({
  footer: {
    serverId: 7,
    playerCount: 63,
    maxPlayers: 100,
  },
});
