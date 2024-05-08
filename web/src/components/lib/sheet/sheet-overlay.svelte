<script lang="ts">
  import { Dialog as SheetPrimitive } from 'bits-ui';
  import { fade } from 'svelte/transition';
  import { cn } from '$utils/misc';
  import type SheetConfig from '$types/config';
  import type { OverlayBlurLevel } from '$types/config';

  type $$Props = SheetPrimitive.OverlayProps & {
    overlayBlur?: SheetConfig['overlayBlur'];
  };

  let className: $$Props['class'] = undefined;
  export let overlayBlur: $$Props['overlayBlur'] = 'sm';
  export { className as class };
  export let transition: $$Props['transition'] = fade;
  export let transitionConfig: $$Props['transitionConfig'] = {
    duration: 150,
  };

  const blurLevelClasses: { [key in OverlayBlurLevel]: string } = {
    xs: 'backdrop-blur-sm',
    sm: 'backdrop-blur',
    md: 'backdrop-blur-md',
    lg: 'backdrop-blur-lg',
  };
</script>

<SheetPrimitive.Overlay
  {transition}
  {transitionConfig}
  class={cn(
    'fixed inset-0 z-50 bg-slate-900/80',
    overlayBlur ? blurLevelClasses[overlayBlur] : 'backdrop-blur-none',
    className
  )}
  {...$$restProps}
/>
