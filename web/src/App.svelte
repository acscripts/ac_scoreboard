<script lang="ts">
  import VisibilityProvider from './providers/VisibilityProvider.svelte';
  import visibility from './store/visibility';
  import config from './store/config';
  import data from './store/data';
  import locales from './store/locales';
  import { debugData } from '$utils/debugData';
  import { fetchNui } from '$utils/fetchNui';
  import { isEnvBrowser } from '$utils/misc';
  import { useNuiEvent } from '$utils/useNuiEvent';
  import type SheetConfig from '$types/config';
  import type SheetData from '$types/data';
  import type Locales from '$types/locales';
  import * as Sheet from './components/sheet';
  import Title from './components/title/title.svelte';
  import Footer from './components/footer/footer.svelte';

  /*
  debugData<SheetConfig>([
    {
      action: 'setConfig',
      data: {
        title: {
          text: 'Hypen RP',
          logo: 'https://static.hypen.cz/images/web/hypen-logo.svg',
        },
        side: 'left',
        closeOnEscape: false,
        closeOnOutsideClick: true,
        showOverlay: false,
      },
    },
  ]);
  */

  /*
  debugData<Locales>([
    {
      action: 'setLocales',
      data: {
        group_name: 'Skupina',
        group_count: 'Počet',
        player_name: 'Hráč',
        player_id: 'ID',
        copy_server_id: 'Zkopírovat své server ID',
        server_id_copied: 'Server ID zkopírováno',
      },
    },
  ]);
  */

  useNuiEvent('setConfig', (newConfig: SheetConfig) => {
    config.set(newConfig);
  });

  useNuiEvent('setData', (newData: SheetData) => {
    data.set(newData);
  });

  useNuiEvent('setLocales', (newLocales: Locales) => {
    locales.set(newLocales);
  });

  let isOpened: boolean;

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

  if (isEnvBrowser()) {
    isOpened = true;
    visibility.set(true);
  }
</script>

{#if isEnvBrowser()}
  <div class="absolute flex w-full justify-center">
    <button class="m-2 rounded-md bg-slate-800 px-4 py-2" on:click={() => visibility.set(true)}>Show</button>
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
      <Sheet.Content side={$config.side} showOverlay={$config.showOverlay} overlayBlurLevel={$config.overlayBlurLevel}>
        <Title title={$config.title} />
        Hello world
        <Footer footer={$data.footer} />
      </Sheet.Content>
    </Sheet.Root>
  </main>
</VisibilityProvider>
