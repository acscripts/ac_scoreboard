import { writable } from 'svelte/store';
import type SheetConfig from '$types/config';

export default writable<SheetConfig>({
  title: {
    text: 'AC Scoreboard',
    logo: './logo.svg',
  },
  side: 'right',
  showOverlay: false,
  closeOnEscape: true,
  closeOnOutsideClick: true,
  uppercaseNames: false,
  highlightEmptyGroups: true,
  compactPlayers: false,
  compactGroups: false,
  playerColumns: 1,
  groupColumns: 1,
});
