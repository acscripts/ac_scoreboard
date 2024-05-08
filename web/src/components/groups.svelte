<script lang="ts">
  import data from '$store/data';
  import config from '$store/config';
  import locales from '$store/locales';
  import { cn } from '$utils/misc';
</script>

<div>
  <div class="mb-1 select-none font-bold uppercase">{$locales.groups}</div>

  <div class={cn('grid gap-1', $config.groupColumns === 1 ? 'grid-cols-1' : 'grid-cols-2')}>
    {#each $data.groups as group (group)}
      <div
        class={cn(
          'flex items-center justify-between gap-2 rounded-md bg-slate-700 px-2',
          $config.compactRows ? 'py-1' : 'py-2'
        )}
      >
        <span class="truncate">{group.name}</span>
        <span class="min-w-9 flex-shrink-0 select-none rounded-md bg-slate-800 px-2 text-center">{group.count}</span>
      </div>
    {/each}
  </div>
</div>
