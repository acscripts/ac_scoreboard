<script lang="ts">
  import VisibilityProvider from './providers/VisibilityProvider.svelte';
  import Icon from '@iconify/svelte';
  import { debugData } from './utils/debugData';
  import visibility from './store/visibility';
  import { fetchNui } from './utils/fetchNui';
  import * as Sheet from './components/sheet';
  import type SheetConfig from './types/config';
  import { useNuiEvent } from '$utils/useNuiEvent';

  debugData<SheetConfig>([
    {
      action: 'setConfig',
      data: {
        side: 'right',
        closeOnEscape: true,
        closeOnOutsideClick: true,
        showOverlay: true,
        overlayBlurLevel: 'sm',
      },
    },
  ]);

  let isOpened: boolean;
  let config: SheetConfig = {};

  useNuiEvent('setConfig', (data: SheetConfig) => {
    config = data;
  });

  visibility.subscribe((visible) => {
    if (visible) {
      setTimeout(() => {
        isOpened = true;
      }, 500);
    }
  });

  const onOpenChange = (open: boolean) => {
    if (!open) {
      setTimeout(() => {
        visibility.set(false);
        fetchNui('close');
      }, 300);
    }
  };
</script>

<button class="absolute m-2 rounded-md bg-background px-4 py-2" on:click={() => visibility.set(true)}>Open</button>

<VisibilityProvider>
  <main class="flex h-full w-full">
    <Sheet.Root
      bind:open={isOpened}
      {onOpenChange}
      closeOnEscape={config.closeOnEscape}
      closeOnOutsideClick={config.closeOnOutsideClick}
    >
      <Sheet.Content side={config.side} showOverlay={config.showOverlay} overlayBlurLevel={config.overlayBlurLevel}>
        AC Scoreboard
      </Sheet.Content>
    </Sheet.Root>
  </main>
</VisibilityProvider>
