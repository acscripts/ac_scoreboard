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
  overlayBlurLevel: 'sm',
});
