<script lang="ts">
  import data from '$store/data';
  import { cn } from '$utils/misc';
  import Icon from '@iconify/svelte';
  import * as Tooltip from './lib/tooltip';
</script>

{#if $data.statusIndicators}
  <div class="flex select-none flex-wrap items-center justify-center gap-2">
    {#each $data.statusIndicators as item}
      <Tooltip.Root openDelay={250} closeOnPointerDown={false} disableHoverableContent={true}>
        <Tooltip.Trigger>
          <Icon icon={item.icon} class={cn('h-6 w-6', item.isActive ? 'text-green-500' : 'text-red-500')} />
        </Tooltip.Trigger>
        <Tooltip.Content>
          <p>{item.label}</p>
        </Tooltip.Content>
      </Tooltip.Root>
    {/each}
  </div>
{/if}
