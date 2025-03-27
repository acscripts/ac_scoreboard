<script lang="ts">
  import Icon from '@iconify/svelte';
  import data from '$store/data';
  import config from '$store/config';
  import locales from '$store/locales';
  import { cn } from '$utils/misc';
</script>

{#if $data.groups}
  <div>
    <div class="mb-1 select-none font-bold uppercase">{$locales.groups}</div>

    <div class={cn('grid gap-1', $config.groupColumns === 1 ? 'grid-cols-1' : 'grid-cols-2')}>
      {#each $data.groups as group (group)}
        <div
          class={cn(
            'flex items-center justify-between gap-2 rounded-md bg-slate-700 px-2',
            $config.compactGroups ? 'py-1' : 'py-2'
          )}
        >
          <div class="flex items-center gap-2 truncate">
            {#if group.icon}
              <Icon icon={group.icon} class="h-4 min-w-4" />
            {/if}
            <span class="truncate">{group.label}</span>
          </div>
          {#if group.count !== undefined}
            <span
              class={cn(
                'min-w-9 flex-shrink-0 select-none rounded-md bg-slate-800 px-2 text-center',
                $config.highlightEmptyGroups && group.count === 0 && ' text-red-400'
              )}>{group.count}</span
            >
          {/if}
        </div>
      {/each}
    </div>
  </div>
{/if}
