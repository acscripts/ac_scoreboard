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

  /*
  debugData<SheetConfig>([
    {
      action: 'setConfig',
      data: {
        title: {
          text: 'Hypen RP',
          logo: 'https://static.hypen.cz/images/web/hypen-logo.svg',
        },
        side: 'right',
        showOverlay: false,
        closeOnEscape: true,
        closeOnOutsideClick: true,
        uppercaseNames: false,
        compactRows: false,
        playerColumns: 1,
        groupColumns: 1,

        // alternative values
        // side: 'left',
        // showOverlay: true,
        // closeOnEscape: false,
        // closeOnOutsideClick: false,
        // uppercaseNames: true,
        // compactRows: true,
        // playerColumns: 2,
        // groupColumns: 2,
      },
    },
  ]);
  */

  /*
  debugData<Locales>([
    {
      action: 'setLocales',
      data: {
        groups: 'Skupiny',
        players: 'Hráči',
        copy_server_id: 'Zkopírovat své server ID',
        server_id_copied: 'Server ID zkopírováno',
        anonymous_player: 'Anonymní hráč',
      },
    },
  ]);
  */

  let isOpened = false;

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
