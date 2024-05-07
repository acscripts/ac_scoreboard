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

  const defaultTitleLogo = './logo.svg';
  const handleMissingImage = () => {
    config.title.logo = defaultTitleLogo;
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
        <div class="mb-4 flex h-8 items-center gap-2">
          {#if config.title.logo !== false}
            <img
              class="h-full"
              style="color-scheme:dark;"
              src={config.title.logo ?? defaultTitleLogo}
              alt="Server logo"
              on:error={handleMissingImage}
            />
          {/if}
          {#if config.title.text !== false}
            <p class="text-xl font-semibold">{config.title.text ?? 'AC Scoreboard'}</p>
          {/if}
        </div>
        Hello world
      </Sheet.Content>
    </Sheet.Root>
  </main>
</VisibilityProvider>
