type Title = {
  text?: string | false;
  logo?: string | false;
};

type SheetConfig = {
  title: Title;
  side?: 'left' | 'right';
  showOverlay?: boolean;
  closeOnEscape?: boolean;
  closeOnOutsideClick?: boolean;
  uppercaseNames?: boolean;
  compactRows?: boolean;
  playerColumns?: 1 | 2;
  groupColumns?: 1 | 2;
};

export type { SheetConfig as default };
