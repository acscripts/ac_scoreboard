<script lang="ts">
  import { Dialog as SheetPrimitive } from 'bits-ui';
  import { fly } from 'svelte/transition';
  import { SheetOverlay, SheetPortal, type Side, sheetTransitions, sheetVariants } from './index';
  import { cn } from '$utils/misc';
  import type SheetConfig from '$types/config';

  type $$Props = SheetPrimitive.ContentProps & {
    side?: Side;
    showOverlay?: SheetConfig['showOverlay'];
    overlayBlurLevel?: SheetConfig['overlayBlurLevel'];
  };

  let className: $$Props['class'] = undefined;
  export let side: $$Props['side'] = 'right';
  export let showOverlay: $$Props['showOverlay'] = true;
  export let overlayBlurLevel: $$Props['overlayBlurLevel'] = 'sm';
  export { className as class };
  export let inTransition: $$Props['inTransition'] = fly;
  export let inTransitionConfig: $$Props['inTransitionConfig'] = sheetTransitions[side ?? 'right'].in;
  export let outTransition: $$Props['outTransition'] = fly;
  export let outTransitionConfig: $$Props['outTransitionConfig'] = sheetTransitions[side ?? 'right'].out;
</script>

<SheetPortal>
  {#if showOverlay}
    <SheetOverlay {overlayBlurLevel} />
  {/if}
  <SheetPrimitive.Content
    {inTransition}
    {inTransitionConfig}
    {outTransition}
    {outTransitionConfig}
    class={cn(sheetVariants({ side }), className)}
    {...$$restProps}
  >
    <slot />
  </SheetPrimitive.Content>
</SheetPortal>
