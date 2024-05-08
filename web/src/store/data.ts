import { writable } from 'svelte/store';
import type SheetData from '$types/data';

export default writable<SheetData>({
  footer: {
    serverId: 7,
    playerCount: 63,
    maxPlayers: 100,
  },
  groups: [
    { name: 'Police', count: 7 },
    { name: 'EMS', count: 6 },
    { name: 'Mechanics', count: 2 },
    { name: 'Taxi', count: 1 },
    { name: 'Unemployed', count: 47 },
  ],
  players: [
    { name: 'Bob', id: 7 },
    { name: 'George Washington had very long name', id: 32 },
    { name: 'Franta', id: 1 },
    { name: 'Zoo', id: 60 },
  ],
  statusIndicators: [
    { label: 'House robbery', icon: 'mdi:house', isActive: true },
    { label: 'Store robbery', icon: 'mdi:store', isActive: true },
    { label: 'Bank robbery', icon: 'mdi:bank', isActive: false },
  ],
});
