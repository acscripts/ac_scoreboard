type Title = {
  text?: string;
  logo?: string;
};

type SheetConfig = {
  title: Title;
  side?: 'left' | 'right';
  showOverlay?: boolean;
  closeOnEscape?: boolean;
  closeOnOutsideClick?: boolean;
  overlayBlurLevel?: 'xs' | 'sm' | 'md' | 'lg';
};

export type { SheetConfig as default };
