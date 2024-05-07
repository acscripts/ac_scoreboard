<script lang="ts">
  import VisibilityProvider from './providers/VisibilityProvider.svelte';
  import visibility from './store/visibility';
  import { debugData } from '$utils/debugData';
  import { fetchNui } from '$utils/fetchNui';
  import { useNuiEvent } from '$utils/useNuiEvent';
  import type SheetConfig from '$types/config';
  import * as Sheet from './components/sheet';
  import Title from './components/title/title.svelte';

  debugData<SheetConfig>([
    {
      action: 'setConfig',
      data: {
        title: {
          // text: 'Hypen RP',
          // logo: 'https://static.hypen.cz/images/web/hypen-logo.svg',
          // text: false,
          // logo: false,
        },
        side: 'right',
        closeOnEscape: true,
        closeOnOutsideClick: true,
        showOverlay: true,
        overlayBlurLevel: 'sm',
      },
    },
  ]);

  let isOpened: boolean;
  let config: SheetConfig = { title: {} };

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

<button class="absolute m-2 rounded-md bg-slate-800 px-4 py-2" on:click={() => visibility.set(true)}>Open</button>

<VisibilityProvider>
  <main class="flex h-full w-full">
    <Sheet.Root
      bind:open={isOpened}
      {onOpenChange}
      closeOnEscape={config.closeOnEscape}
      closeOnOutsideClick={config.closeOnOutsideClick}
    >
      <Sheet.Content side={config.side} showOverlay={config.showOverlay} overlayBlurLevel={config.overlayBlurLevel}>
        <Title title={config.title} />
        Hello world
      </Sheet.Content>
    </Sheet.Root>
  </main>
</VisibilityProvider>
