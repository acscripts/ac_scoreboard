import { Dialog as SheetPrimitive } from 'bits-ui';
import { type VariantProps, tv } from 'tailwind-variants';
import Portal from './sheet-portal.svelte';
import Overlay from './sheet-overlay.svelte';
import Content from './sheet-content.svelte';

const Root = SheetPrimitive.Root;

export {
  Root,
  Content,
  //
  Portal as SheetPortal,
  Overlay as SheetOverlay,
};

export const sheetVariants = tv({
  base: 'fixed z-50 gap-4 bg-slate-900 p-6 shadow-lg',
  variants: {
    side: {
      left: 'inset-y-0 left-0 h-full w-3/4 border-r sm:max-w-sm',
      right: 'inset-y-0 right-0 h-full w-3/4 border-l sm:max-w-sm',
    },
  },
  defaultVariants: {
    side: 'right',
  },
});

export const sheetTransitions = {
  left: {
    in: {
      x: '-100%',
      duration: 500,
      opacity: 1,
    },
    out: {
      x: '-100%',
      duration: 300,
      opacity: 1,
    },
  },
  right: {
    in: {
      x: '100%',
      duration: 500,
      opacity: 1,
    },
    out: {
      x: '100%',
      duration: 300,
      opacity: 1,
    },
  },
};

export type Side = VariantProps<typeof sheetVariants>['side'];
