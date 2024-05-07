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
  overlayBlurLevel?: 'xs' | 'sm' | 'md' | 'lg';
  uppercaseNames?: boolean;
  compactPlayers?: boolean;
};

export type { SheetConfig as default };
