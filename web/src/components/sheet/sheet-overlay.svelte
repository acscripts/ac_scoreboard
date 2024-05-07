<script lang="ts">
  import { Dialog as SheetPrimitive } from 'bits-ui';
  import { fade } from 'svelte/transition';
  import { cn } from '$utils/misc';
  import type SheetConfig from '../../types/config';

  type $$Props = SheetPrimitive.OverlayProps & {
    overlayBlurLevel?: SheetConfig['overlayBlurLevel'];
  };

  let className: $$Props['class'] = undefined;
  export let overlayBlurLevel: $$Props['overlayBlurLevel'] = 'sm';
  export { className as class };
  export let transition: $$Props['transition'] = fade;
  export let transitionConfig: $$Props['transitionConfig'] = {
    duration: 150,
  };
</script>

<SheetPrimitive.Overlay
  {transition}
  {transitionConfig}
  class={cn('fixed inset-0 z-50 bg-slate-900/80', `backdrop-blur-${overlayBlurLevel}`, className)}
  {...$$restProps}
/>
