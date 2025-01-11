<script lang="ts">
  import data from '$store/data';
  import locales from '$store/locales';
  import { fetchNui } from '$utils/fetchNui';
  import { cn } from '$utils/misc';
  import Icon, { loadIcons } from '@iconify/svelte';
  import * as Tooltip from './lib/tooltip';

  let hasCopied = false;

  const copyServerId = () => {
    fetchNui('copyServerId');
    hasCopied = true;
    setTimeout(() => (hasCopied = false), 4000);
  };

  const copyIcons = {
    copy: 'mdi:cursor-default-click',
    copied: 'mdi:clipboard-check',
  };

  // preload icons to prevent possible "flash" of empty icon space before it loads
  // since it's visible only on hover, it's quite noticeable
  loadIcons([copyIcons.copy, copyIcons.copied]);
</script>

{#if $data.footer}
  <div class="flex select-none flex-wrap items-center justify-center gap-2">
    <Tooltip.Root openDelay={250} closeOnPointerDown={false} disableHoverableContent={true}>
      <Tooltip.Trigger>
        <button onclick={copyServerId} class="flex h-6 items-center gap-2 rounded-md bg-slate-600 px-2">
          <Icon icon="mingcute:user-2-fill" class="h-4 w-4" />
          {$data.footer.serverId}
        </button>
      </Tooltip.Trigger>
      <Tooltip.Content class={cn(hasCopied && 'bg-green-600')}>
        <div class="flex items-center gap-1">
          <Icon icon={hasCopied ? copyIcons.copied : copyIcons.copy} class="h-4 w-4" />
          <p>{hasCopied ? $locales.server_id_copied : $locales.copy_server_id}</p>
        </div>
      </Tooltip.Content>
    </Tooltip.Root>

    <div class="flex h-6 items-center gap-2 rounded-md bg-slate-600 px-2">
      <Icon icon="mingcute:group-fill" class="h-4 w-4" />
      {$data.footer.playerCount}/{$data.footer.maxPlayers}
    </div>
  </div>
{/if}
