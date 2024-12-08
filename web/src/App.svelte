<script lang="ts">
  import VisibilityProvider from './providers/VisibilityProvider.svelte';
  import visibility from '$store/visibility';
  import config from '$store/config';
  import data from '$store/data';
  import locales from '$store/locales';
  import { debugData } from '$utils/debugData';
  import { fetchNui } from '$utils/fetchNui';
  import { isEnvBrowser } from '$utils/misc';
  import { useNuiEvent } from '$utils/useNuiEvent';
  import type SheetConfig from '$types/config';
  import type SheetData from '$types/data';
  import type Locales from '$types/locales';
  import * as Sheet from './components/lib/sheet';
  import Title from './components/title.svelte';
  import Groups from './components/groups.svelte';
  import Players from './components/players.svelte';
  import StatusIndicators from './components/status-indicators.svelte';
  import Footer from './components/footer.svelte';

  let isOpened = $state(false);

  if (isEnvBrowser()) {
    isOpened = true;
    visibility.set(true);
  }

  fetchNui('ready');

  useNuiEvent('setConfig', (newConfig: SheetConfig) => {
    config.set(newConfig);
  });

  useNuiEvent('setData', (newData: SheetData) => {
    data.set(newData);
  });

  useNuiEvent('setLocales', (newLocales: Locales) => {
    locales.set(newLocales);
  });

  useNuiEvent('setVisible', (visible: boolean) => {
    if (visible) {
      visibility.set(true);
      setTimeout(() => (isOpened = true), 0);
    } else {
      isOpened = false;
      setTimeout(() => visibility.set(false), 300);
    }
  });

  const onOpenChange = (open: boolean) => {
    if (!open) {
      fetchNui('close');
      setTimeout(() => visibility.set(false), 300);
    }
  };
</script>

{#if isEnvBrowser()}
  <div class="absolute flex w-full justify-center">
    <button
      class="m-2 rounded-md bg-slate-800 px-4 py-2"
      onclick={() => debugData([{ action: 'setVisible', data: true }], 0)}>Show</button
    >
  </div>
{/if}

<VisibilityProvider>
  <main class="flex h-full w-full">
    <Sheet.Root
      bind:open={isOpened}
      {onOpenChange}
      closeOnEscape={$config.closeOnEscape}
      closeOnOutsideClick={$config.closeOnOutsideClick}
    >
      <Sheet.Content side={$config.side} showOverlay={$config.showOverlay}>
        <div class="flex h-full flex-col gap-6">
          <Title />
          <div class="flex h-full flex-col gap-6 overflow-y-auto">
            <Groups />
            <Players />
          </div>
          <div class="flex flex-col gap-4">
            <StatusIndicators />
            <Footer />
          </div>
        </div>
      </Sheet.Content>
    </Sheet.Root>
  </main>
</VisibilityProvider>
