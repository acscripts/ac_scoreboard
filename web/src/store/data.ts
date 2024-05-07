import { writable } from 'svelte/store';
import type SheetData from '$types/data';

export default writable<SheetData>({
  footer: {
    serverId: 7,
    playerCount: 63,
    maxPlayers: 100,
  },
  players: [
    { name: 'Bob', id: 7 },
    { name: 'George Washington had very long name', id: 32 },
    { name: 'Franta', id: 1 },
  ],
});
