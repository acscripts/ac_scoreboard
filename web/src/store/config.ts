import { writable } from 'svelte/store';
import type SheetConfig from '$types/config';

export default writable<SheetConfig>({
  title: {
    text: 'AC Scoreboard',
    logo: './logo.svg',
  },
  side: 'right',
  closeOnEscape: true,
  closeOnOutsideClick: true,
  showOverlay: true,
  overlayBlur: 'sm',
  compactRows: false,
  uppercaseNames: false,
  playerColumns: 1,
  groupColumns: 1,
});
