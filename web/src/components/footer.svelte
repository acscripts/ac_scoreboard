<script lang="ts">
  import data from '$store/data';
  import locales from '$store/locales';
  import { cn } from '$utils/misc';
  import { copy } from 'svelte-copy';
  import Icon from '@iconify/svelte';
  import * as Tooltip from './lib/tooltip';

  let hasCopied = false;

  const onServerIdCopy = () => {
    hasCopied = true;
    setTimeout(() => (hasCopied = false), 4000);
  };
</script>

<div class="text-md flex select-none items-center justify-center gap-2">
  <Tooltip.Root openDelay={250} closeOnPointerDown={false}>
    <Tooltip.Trigger>
      <div
        use:copy={`${$data.footer.serverId}`}
        on:svelte-copy={onServerIdCopy}
        class="flex h-6 items-center gap-2 rounded-md bg-slate-600 px-2"
      >
        <Icon icon="mingcute:user-2-fill" class="h-4 w-4" />
        {$data.footer.serverId}
      </div>
    </Tooltip.Trigger>
    <Tooltip.Content class={cn(hasCopied && 'bg-green-600')}>
      <div class="flex items-center gap-1">
        <Icon icon={hasCopied ? 'mdi:clipboard-check' : 'mdi:cursor-default-click'} class="h-4 w-4" />
        <p>{hasCopied ? $locales.server_id_copied : $locales.copy_server_id}</p>
      </div>
    </Tooltip.Content>
  </Tooltip.Root>

  <div class="flex h-6 items-center gap-2 rounded-md bg-slate-600 px-2">
    <Icon icon="mingcute:group-fill" class="h-4 w-4" />
    {$data.footer.playerCount}/{$data.footer.maxPlayers}
  </div>
</div>
